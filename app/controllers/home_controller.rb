#encoding: utf-8
#区域代理用户管理中心
class HomeController < ApplicationController
  before_filter :authenticate_user!
  def index
  	#redirect_to :action => :site_map
    @shops = Shop.where(:updated_by => current_user.id).paginate(:page => params[:page] || 1, :per_page => 40)
    @orders = Order.where(:shop_id => @shops.map(&:id)).paginate(:page => params[:page] || 1, :per_page => 40)
  end

  def edit_order
    @order = Order.find(params[:id])
  end

  def update_order
    @order = Order.find(params[:order][:id])

    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to('/home/index', :notice => '订单修改成功.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @order.errors, :status => :unprocessable_entity }
      end
    end
  end

  def search 
    #http://www.smsbao.com/query?u=inruby&p=inruby.com
    #http://www.smsbao.com/sms?u=inruby&p=inruby.com&m=15928661802&c=testaaf 
    #发送短信接口： 通过'open-uri', 加密使用Digest::MD5
    p = Digest::MD5.hexdigest "kenrome001"
    open("http://www.smsbao.com/sms?u=inruby&p=#{p}&m=15928661802&c=testaaf") {|f|
      f.each_line {|line| p line}
    }

  end
end