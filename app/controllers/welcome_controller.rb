#encoding: utf-8
class WelcomeController < ApplicationController
  
  #实验： token-input
  def search
    @shop = Shop.new
    render 'search', :layout => nil
  end

  def index
    #learn cookies: http://stackoverflow.com/questions/1232174/rails-cookies-set-start-date-and-expire-date
    #  # Sets a cookie that expires in 1 hour.
    #    cookies[:login] = { :value => "XJ-122", :expires => 1.hour.from_now }
    #1. check if has cookies
    #cookies[:addr] = "#{a.addr}|#{a.latitude},#{a.longitude}"
    if cookies[:user_input_addr]
      addr_arr = cookies[:user_input_addr].split('|')
      @location = addr_arr.shift
      @point = addr_arr.shift.split(',')
    else
      redirect_to new_address_path
      return
    end

    @shop_addresses = ShopAddress.near(@point, 0.2).paginate(:page => params[:page] || 1, :per_page => 26)
    @shop_addresses.each do |sa|
      begin
        point = Geocoder.coordinates(sa.full_addr)
      rescue 
      end
      if point
        sa.latitude = point[0]
        sa.longitude = point[1]
        sa.save!
      end
    end
    # @shop_addresses = ShopAddress.near(@point, 0.5) if @shop_addresses.size < 5
    # @shop_addresses = ShopAddress.near(@point, 1) if @shop_addresses.size < 5
    # @shop_addresses = ShopAddress.near(@point, 2) if @shop_addresses.size < 5
    @shop_count = @shop_addresses.size
    @dish_count = @shop_count * (rand(10) + 1) #@shop_addresses.map{|sd| sd.dish_count}.sum
    #form map data
    session[:shop_address_ids] = @shop_addresses.map(&:id)
    session[:location_point] = @point
    session[:location] = @location
    
    respond_to do |format|
      format.html #show.html
      format.js
      format.json { render :json => @shop_addresses }
   end
  end
  
  #use for address auto-complete
  def map_data
    if session[:location].present? && session[:location_point].present? && session[:shop_address_ids].present?
      @shop_addresses = ShopAddress.find(session[:shop_address_ids])
      render json: @shop_addresses.map{|sa| [sa.shop.id, sa.shop.name, sa.latitude, sa.longitude].join('|')}
    else
      redirect_to '/'
      return
    end
  end

  # cart = {
  #   shop:{
  #     shop_dish:{
  #       :name
  #       :price
  #       :count
  #     }
  #   }
  # }
  #{"1207"=>{"3088"=>{:name=>"楹昏荆楦″潡", :price=>nil, :count=>1}}}
  def add_cart
    if session[:location] && params[:shop_dish_id]
      @shop = Shop.find(params[:shop_id])
      @shop_dish = ShopDish.find(params[:shop_dish_id])
      session[:cart] ||= {}
      session[:cart][params[:shop_id]] ||= {}

      if session[:cart][params[:shop_id]][params[:shop_dish_id]]
        session[:cart][params[:shop_id]][params[:shop_dish_id]][:count] = session[:cart][params[:shop_id]][params[:shop_dish_id]][:count] + 1
      else
        session[:cart][params[:shop_id]][params[:shop_dish_id]] = {:name => params[:name], :price => params[:price], :count => 1}
      end
    else
      redirect_to new_address_path
      return
    end
  end

  def delete_cart
    @shop = Shop.find(params[:shop_id])
    @shop_dish = ShopDish.find(params[:shop_dish_id])
    session[:cart][params[:shop_id]].delete(params[:shop_dish_id])
  end

  def clear_cart
    session[:cart] = {}
    respond_to do |format|
      format.html {redirect_to '/'}
      format.js #{ render json: @pages }
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
