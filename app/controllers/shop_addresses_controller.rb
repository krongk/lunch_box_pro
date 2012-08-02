class ShopAddressesController < InheritedResources::Base
  before_filter :authenticate_user!, :except => [:index, :show]
  before_filter :authenticate_admin_user!, :only => [:destroy]

  def index
    @shop_addresses = ShopAddress.limit(100).order(:addr)

    respond_to do |format|
      format.html
      format.json { render json: @shop_addresses.tokens(params[:q]) }
    end
  end

end
