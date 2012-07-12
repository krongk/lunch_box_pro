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

  def update
    phone = params[:order][:phone]
    addr = params[:order][:addr]
    user_note = params[:order][:user_note]
    require_deliver_time = params[:order][:require_deliver_time]

    session[:order][:order_ids].each do |order_id|
      @order = Order.find(order_id)
      @order.phone = phone
      @order.addr = addr
      @order.user_note = user_note
      @order.require_deliver_time = require_deliver_time
      @order.save!
    end

    respond_to do |format|
      if @order
        #发送短信
        #session[:order] = {:total_price => 0.0, :order_ids => []}
        session[:order][:order_ids].each do |order_id|
          order = Order.find(order_id)
          content = []
          content << "电话：#{order.phone}"
          content << "地址：#{order.addr}"
          order.order_details.each do |rd|
            content << "#{rd.shop_dish.dish.name}(#{rd.amount}份)" 
          end
          content << "总价：#{order.total_price}"
          content << "备注：#{order.user_note}"
          shop = Shop.find(order.shop_id)
          phone = shop.shop_contact.mobile_phone
          unless phone =~ /^1[23456789]\d{9}$/
            puts 'bad phone..........'
            flash[:tips] = "商家手机短信发送失败，请尝试拨打商家电话进行订餐：<h1 style='color: #cc3333;'>#{shop.shop_contact.tel_phone}</h1>".html_safe 
            render action: "edit"
            return
          end
          status = SmsBao.send(phone, content.join("\n"))
          unless status == 'success'
            flash[:tips] = "商家手机短信发送失败，请尝试拨打商家电话进行订餐：<h1 style='color: #cc3333;'>#{shop.shop_contact.tel_phone}</h1>".html_safe
            render action: "edit"
            return
          end
          Order.update(order_id, :sms_status => status)
        end
        #清空购物车
        session[:cart] = nil
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
