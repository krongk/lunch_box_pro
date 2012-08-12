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
      @point = cookies[:user_input_addr].split(',')
    elsif request.remote_ip != '127.0.0.1' && ipa = IpAddress.find_by_ip(request.remote_ip)
      a = ipa.address
      #3.set cookie
      cookies[:user_input_addr] = { :value => "#{a.latitude},#{a.longitude}", :expires => 1.month.from_now } 
      @point = [a.latitude, a.longitude]
    else
      redirect_to new_address_path
      return
    end

    #reset addr session
    session[:shop_address_ids] = nil
    session[:location_point] = nil
    #reset cart session
    session[:cart] = nil

    #@shop_addresses = ShopAddress.near(@point, 0.2).paginate(:page => params[:page] || 1, :per_page => 6)
    @has_out_food_shop_addresses = ShopAddress.joins(:shop).where('shops.has_out_food = 1').near(@point, 0.2).paginate(:page => params[:page] || 1, :per_page => 20)
    @no_out_food_shop_addresses = ShopAddress.joins(:shop).where('shops.has_out_food = 0').near(@point, 0.2).paginate(:page => params[:page] || 1, :per_page => 6)
    
    #@shop_addresses = ShopAddress.near(@point, 0.1).paginate(:page => params[:page] || 1, :per_page => 6)
    #@has_out_food_shop_addresses, @no_out_food_shop_addresses = @shop_addresses.partition{|sd| sd.shop.has_out_food == true}
    
    @has_out_food_shop_addresses = @has_out_food_shop_addresses.sort{|a, b| b.shop.sort_id <=> a.shop.sort_id}

    #==new shop need to geocode
    # @shop_addresses.each do |sa|
    #   begin
    #     point = Geocoder.coordinates(sa.full_addr)
    #   rescue 
    #   end
    #   if point
    #     sa.latitude = point[0]
    #     sa.longitude = point[1]
    #     sa.save!
    #   end
    # end

    # @shop_addresses = ShopAddress.near(@point, 0.5) if @shop_addresses.size < 5
    # @shop_addresses = ShopAddress.near(@point, 1) if @shop_addresses.size < 5
    # @shop_addresses = ShopAddress.near(@point, 2) if @shop_addresses.size < 5
    if @has_out_food_shop_addresses.empty? && @no_out_food_shop_addresses.empty?
      flash[:info] = "请输入您所在的区域，目前只开通了成都市区范围的外卖搜索"
      redirect_to new_address_path
      return
    end
    #form map data
    session[:shop_address_ids] ||= @has_out_food_shop_addresses.map(&:id)
    session[:location_point] ||= @point
    
    respond_to do |format|
      format.html #show.html
      format.js
      format.json { render :json => @has_out_food_shop_addresses }
   end
  end
  
  #use for address auto-complete
  def map_data
    if session[:location_point].present? && session[:shop_address_ids].present?
      @shop_addresses = ShopAddress.find(session[:shop_address_ids])
      render json: @shop_addresses.map{|sa| [sa.shop.id, sa.shop.name, sa.latitude, sa.longitude, sa.shop.show_has_out_food, [sa.shop.shop_contact.tel_phone,sa.shop.shop_contact.mobile_phone].compact.join(',')].join('|')}
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
    if session[:location_point].present?  && params[:shop_dish_id]
      @shop = Shop.find(params[:shop_id])
      @shop_dish = ShopDish.find(params[:shop_dish_id])
      session[:cart] ||= {}
      session[:cart][params[:shop_id]] ||= {}

      if session[:cart][params[:shop_id]][params[:shop_dish_id]]
        session[:cart][params[:shop_id]][params[:shop_dish_id]][:count] = session[:cart][params[:shop_id]][params[:shop_dish_id]][:count] + 1
      else
        session[:cart][params[:shop_id]][params[:shop_dish_id]] = {:name => params[:name], :price => params[:price], :count => 1}
      end
      render 'add_cart.js'
    else
      redirect_to new_address_path
      return
    end
  end

  def delete_cart
    @shop = Shop.find(params[:shop_id])
    @shop_dish = ShopDish.find(params[:shop_dish_id])
    session[:cart][params[:shop_id]].delete(params[:shop_dish_id])
    if session[:cart][params[:shop_id]].empty?
      session[:cart].delete(params[:shop_id])
    end
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
