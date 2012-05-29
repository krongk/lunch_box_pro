class WelcomeController < ApplicationController
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
    if cookies[:addr]
      addr_arr = cookies[:addr].split('|')
      @location = addr_arr.shift
      @point = addr_arr.shift.split(',')
      @shop_addresses = ShopAddress.near(@point, 1).limit(20)
      @shop_addresses = ShopAddress.near(@point, 2) if @shop_addresses.size < 5
      @shop_addresses = ShopAddress.near(@point, 3) if @shop_addresses.size < 5
    else
      redirect_to new_address_path
    end
  end

  def help
  end

  def about
  end

  def agreement
  end

end
