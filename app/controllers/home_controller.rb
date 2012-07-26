#encoding: utf-8
#区域代理用户管理中心

require 'open-uri'
require 'base_extension'
require 'cgi'
require 'iconv'

class HomeController < ApplicationController
  before_filter :auth

  def auth
    authenticate_user!
    
  end

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

  def location

  end
  #短信宝测试
  def search 

    #http://www.smsbao.com/query?u=inruby&p=inruby.com
    #http://www.smsbao.com/sms?u=inruby&p=inruby.com&m=15928661802&c=testaaf 
    #发送短信接口： 通过'open-uri', 加密使用Digest::MD5
    p = Digest::MD5.hexdigest "kenrome001"
    @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
    content = %{你见，或者不见我.
我就在那里;
不悲不喜 ;

你念，或者不念我 ;
情就在那里 ;
不来不去 ;

你爱，或者不爱我 ;
爱就在那里; 
不增不减. }
    puts content
    puts 'cgi:'
    puts CGI.escape(content)
    puts 'URL>>>>>>>>>>>>>>>>>>>>>'
    puts URI.escape (content)
    puts 'encoding'
    puts content.encoding
    puts 'force_encode'
    puts content.force_encoding('utf-8')
    puts 'encoding'
    puts content.encoding

    # open("http://www.smsbao.com/sms?u=inruby&p=#{p}&m=15928661802&c=#{URI.escape(content)}") {|f|
    #   f.each_line {|line| p line}
    # }
    status = SmsBao.send('15928661802', content)
    render :text => status
  end
end

