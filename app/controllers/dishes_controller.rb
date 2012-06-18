class DishesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]

  def index
    if request.url =~ /shops\/(\d+)\/dishes/i
      @shop = Shop.find_by_id($1)
      @dishes = @shop.dishes
    else
      @dishes = Dish.paginate(:page => params[:page] || 1, :per_page => 40)
    end
  end

  #use for auto-complete json
  def get
    @dish = Dish.find_by_id(params[:id]) || Dish.find_or_create_by_name(params[:name])
    respond_to do |format|
      format.json { render json: @dish.id }
    end
  end

  #use for auto-complete
  def dish_list
    @dishes = Dish.where("en_name like ? OR name like ?", "%#{params[:term]}%",  "%#{params[:term]}%").limit(30)
    render json: @dishes.map(&:name)
  end

end
