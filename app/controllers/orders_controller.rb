#encoding: utf-8
require 'base_extension'

class OrdersController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :only => [:destroy]
  before_filter :authenticate_user!, :except => [:index, :show, :new, :create, :edit, :update, :find]
  #session[:cart][params[:shop_id]][params[:shop_dish_id]] = {:name => params[:name], :price => params[:price], :count => 1}
  #. create order
  #. create order_detail
  #. edit order
  #{"1207"=>{"3088"=>{:name=>"楹昏荆楦″潡", :price=>nil, :count=>1}}}
  def new
    # render :text => session[:cart]
    # return

    #session[:order_show] only use to show on user successed ording! and remind order!
    session[:order_show] = nil
     
    if session[:cart]
      #one shop one order
      unless session[:aready_created]
        session[:order] = {:total_price => 0.0, :order_ids => []}
        session[:cart].each do |shop_id, v|
          order = Order.create!(:shop_id => shop_id)
          total_price = 0.0
          v.each do |shop_dish_id, vv|
            shop_dish = ShopDish.find(shop_dish_id)
            order_detail = OrderDetail.create!(:order_id => order.id, :shop_dish_id => shop_dish_id)
            order_detail.amount = vv[:count]
            order_detail.total_price = shop_dish.price.to_f * vv[:count].to_f
            order_detail.save!

            total_price += order_detail.total_price
          end
          total_price += Shop.find(shop_id).outer_price.to_f
          order.total_price = total_price
          
          #code = created_at + shop_id + order_id
          order.code = order.created_at.to_s.gsub(/[^0-9]/, '')[2..7] + shop_id.to_s.rjust(6, '0') + order.id.to_s.rjust(5, '0')
          order.save!

          session[:order][:total_price] += order.total_price
          session[:order][:order_ids] << order.id
        end
      end
      session[:aready_created] = true
      #add user addr
      redirect_to edit_order_path(session[:order][:order_ids].first)
    else
      redirect_to '/'
      return
    end
  end

  def edit
   unless session[:order]
      redirect_to '/'
      return
    end
    super
  end
  #params[:order] = {"phone"=>"15888888888", "addr"=>"test", "require_deliver_time(1i)"=>"2012", "require_deliver_time(2i)"=>"8", "require_deliver_time(3i)"=>"2", "require_deliver_time(4i)"=>"09", "require_deliver_time(5i)"=>"08", "user_note"=>"te"}
  def update
    phone = params[:order][:phone]
    addr = params[:order][:addr]
    user_note = params[:order][:user_note]
    #format time
    #DateTime.parse("2012-8-2 09:08")
    time_arr = params[:order].select{|k, v| k =~ /require_deliver_time/}.values
    require_deliver_time = nil
    if time_arr.size == 5
      require_deliver_time = DateTime.parse "#{time_arr[0]}-#{time_arr[1]}-#{time_arr[2]} #{time_arr[3]}:#{time_arr[4]}"
    end

    session[:order][:order_ids].each do |order_id|
      @order = Order.find(order_id)
      @order.phone = phone
      @order.addr = addr
      @order.user_note = user_note
      @order.require_deliver_time = require_deliver_time
      @order.save!
    end
    # %d - Day of the month (01..31)
    # %m - Month of the year (01..12)
    # %M - Minute of the hour (00..59)
    # %p - Meridian indicator (AM or PM)
    # %S - Second of the minute (00..60)
    # %w - Day of the week (Sunday is 0, 0..6)
    # %y - Year without a century (00..99)
    # %Y - Year with century
    respond_to do |format|
      if @order
        #发送短信
        #session[:order] = {:total_price => 0.0, :order_ids => []}
        
        session[:order][:order_ids].each do |order_id|
          order = Order.find(order_id)
          content = ["[#{order_id}]乐活成都外卖订单信息:\n"]
          content << "用户电话:#{order.phone}"
          content << %{下单时间:#{order.created_at.strftime("%Y-%m-%d %H:%M")}}
          content << "地址:#{order.addr}"
          order.order_details.each do |rd|
            content << "#{rd.shop_dish.dish.name}(#{rd.amount}份)\n" 
          end
          content << "总价:#{order.total_price}"
          content << "备注:#{order.user_note}"
          content << "[乐活客服:15928661802]"
          shop = Shop.find(order.shop_id)
          phone = shop.shop_contact.mobile_phone
          unless phone =~ /^1[23456789]\d{9}$/
            flash[:tips] = "商家所留手机有误，短信发送失败，请尝试拨打商家电话进行订餐：<h1 style='color: #cc3333;'>#{shop.shop_contact.tel_phone}</h1>".html_safe 
            render action: "edit"
            return
          end
          status = SmsBao.send(phone, content.join(","))
          unless status == 'success'
            flash[:tips] = "商家手机短信发送失败，请尝试拨打商家电话进行订餐：<h1 style='color: #cc3333;'>#{shop.shop_contact.tel_phone}</h1>".html_safe
            render action: "edit"
            return
          end
          Order.update(order_id, :sms_shop_status => status)

          #给用户发条短信
          u_content = ["您好，乐活外卖预定成功"]
          u_content << "如果长时间还未送达，请直接拨打"
          u_content << "餐厅电话：#{shop.shop_contact.tel_phone}"
          u_content << "手机：#{shop.shop_contact.mobile_phone}" unless shop.shop_contact.mobile_phone.blank?
          u_content << "[HAPPY.CD]"
          u_status = SmsBao.send(order.phone, u_content.join(","))
          Order.update(order_id, :sms_user_status => u_status)
        end
        #清空购物车
        session[:cart] = nil
        session[:aready_created] = false
        #清空订单
        session[:order_show] = session[:order] 
        session[:order] = nil
        
        format.html { redirect_to @order, notice: '订单提交成功.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  #订单查询
  def find
    #render :text => params
    q = params[:phone]
    unless q.blank?
      if q !~ /^1[23456789]\d{9}$/
        flash[:error] = "请输入正确的手机号码"
        render :action => :find
        return
      end

      orders = Order.where(:phone => q)
      if orders.empty?
        flash[:error] = "没有找到跟该手机号匹配的订单，请您确认手机号输入是否正确！"
        render :action => :find
        return
      end

      session[:order_show] = {:total_price => 0.0, :order_ids => []}
      orders.order('updated_at DESC').limit(20).each do |order|
        session[:order_show][:total_price] += order.total_price
        session[:order_show][:order_ids] << order.id
      end
    end
  end
end
