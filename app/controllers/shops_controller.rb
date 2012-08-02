#encoding: utf-8
class ShopsController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin_user!, :only => [:destroy]
  
  def index
    if params[:shop_name].blank?
      @shops =Shop.paginate(:page => params[:page] || 1, :per_page => 20)
    else
      @shops = Shop.joins(:shop_address).where("shops.name like '%#{params[:shop_name]}%' OR shop_addresses.addr like '%#{params[:shop_name]}%' ").paginate(:page => params[:page] || 1, :per_page => 20)
    end
  end

  def create
    super
    #translate
    @shop.en_name = Pinyin.t(@shop.name)
    @shop.updated_by = current_user.id
    @shop.save!
  end

  def update
    @shop = Shop.find(params[:id])

    #"0"=>{"dish_id"=>"571", "dish_name"=>"回锅肉", "price"=>"15", "is_discount"=>"0", "discount_value"=>"", "is_hot"=>"0", "_destroy"=>"false", "id"=>"23995"},
    params[:shop][:shop_dishes_attributes].each_pair do |k, dish_value|
      unless d = Dish.find_by_name(dish_value[:dish_name])
        d = Dish.create(:name => dish_value[:dish_name], :en_name => Pinyin.t(dish_value[:dish_name]))
      end
      params[:shop][:shop_dishes_attributes][k][:dish_id] = d.id
    end

    respond_to do |format|
      if @shop.update_attributes(params[:shop])
        @shop.updated_by = current_user.id
        @shop.en_name = Pinyin.t(@shop.name)
        unless params[:shop][:shop_address_attributes][:zone_name].blank?
          z = Zone.find_or_create_by_name(params[:shop][:shop_address_attributes][:zone_name])
          @shop.shop_address.zone_id = z.id
        end
        
        @shop.save!
        format.html { redirect_to(shop_url, :notice => '信息修改成功') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @shop.errors, :status => :unprocessable_entity }
      end
    end
  end

end
