#encoding: utf-8
class OrdersController < InheritedResources::Base

  #session[:cart][params[:shop_id]][params[:shop_dish_id]] = {:name => params[:name], :price => params[:price], :count => 1}
  #. create order
  #. create order_detail
  #. edit order
  #{"1207"=>{"3088"=>{:name=>"楹昏荆楦″潡", :price=>nil, :count=>1}}}
  def new
    # render :text => session[:cart]
    # return 
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
        order.total_price = total_price
        order.save!
        session[:order][:total_price] += order.total_price
        session[:order][:order_ids] << order.id
      end
      redirect_to edit_order_path(session[:order][:order_ids].first)
    else
      redirect_to '/'
      return
    end
  end

  def update
    phone = params[:order][:phone]
    addr = params[:order][:addr]
    user_note = params[:order][:user_note]
    
    session[:order][:order_ids].each do |order_id|
      @order = Order.find(order_id)
      @order.phone = phone
      @order.addr = addr
      @order.user_note = user_note
      @order.save!
    end

    respond_to do |format|
      if @order
        #清空购物车
        session[:cart] = nil
        #清空订单
        session[:order] = nil
        
        format.html { redirect_to @order, notice: '订单提交成功.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end


end
