class ShopAddressesController < InheritedResources::Base

  def index
    @shop_addresses = ShopAddress.limit(100).order(:addr)

    respond_to do |format|
      format.html
      format.json { render json: @shop_addresses.tokens(params[:q]) }
    end
  end
end
