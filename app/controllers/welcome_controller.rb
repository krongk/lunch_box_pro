#encoding: utf-8
class WelcomeController < ApplicationController
  
  #实验： token-input
  def search
    @shop = Shop.new
    render 'search', :layout => nil
  end

  def index
     # <Geocoder::Result::Freegeoip:0x931cde8
     # @cache_hit=nil,
     # @data=
     #  {"ip"=>"127.0.0.1",
     #   "city"=>"",
     #   "region_code"=>"",
     #   "region_name"=>"",
     #   "metrocode"=>"",
     #   "zipcode"=>"",
     #   "latitude"=>"0",
     #   "longitude"=>"0",
     #   "country_name"=>"Reserved",
     #   "country_code"=>"RD"}> 
    #1. check if has cookies
    #cookies[:addr] = "#{a.addr}|#{a.latitude},#{a.longitude}"
    if cookies[:user_input_addr]
      addr_arr = cookies[:user_input_addr].split('|')
      @location = addr_arr.shift
      #get location
      cookies[:location] = @location
      @point = addr_arr.shift.split(',')
    else
      redirect_to new_address_path
    end

    @shop_addresses = ShopAddress.near(@point, 0.2).paginate(:page => params[:page] || 1, :per_page => 26)
    # @shop_addresses = ShopAddress.near(@point, 0.5) if @shop_addresses.size < 5
    # @shop_addresses = ShopAddress.near(@point, 1) if @shop_addresses.size < 5
    # @shop_addresses = ShopAddress.near(@point, 2) if @shop_addresses.size < 5
    @shop_count = @shop_addresses.size
    @dish_count = @shop_count * (rand(10) + 1) #@shop_addresses.map{|sd| sd.dish_count}.sum
    #form map data
    session[:shop_address_ids] = @shop_addresses.map(&:id)
    session[:location_point] = @point

    respond_to do |format|
      format.html #show.html
      format.js
      format.json { render :json => @shop_addresses }
   end
  end

  def map_data
    if cookies[:location].present? && session[:location_point].present? && session[:shop_address_ids].present?
      @shop_addresses = ShopAddress.find(session[:shop_address_ids])
      render json: @shop_addresses.map{|sa| [sa.shop.id, sa.shop.name, sa.latitude, sa.longitude].join('|')}
    else
      redirect_to '/'
      return
    end
  end

  def help
    render :help, :layout => nil
  end

  def about
  end

  def agreement
  end

end
