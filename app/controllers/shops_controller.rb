class ShopsController < InheritedResources::Base

  def index
    @shops =Shop.paginate(:page => params[:page] || 1, :per_page => 40)
  end

end
