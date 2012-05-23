#encoding: utf-8
load 'forager.rb'

class HomeController < ApplicationController
  def index
  	#redirect_to :action => :site_map
  end

  #It's a location tip, you can set lawyer => nil, and modify 'views/home/location.html.erb' to 'view/home/_location.html.erb'
  def location
  	#@ip = request.remote_id
  	@ip = '118.113.226.34'
  	@location = Rails.cache.read(@ip)
  end

  #syixia engine
  def search
    if params[:q].blank?
      flash[:notice] = "请输入搜索关键词！"
      render 'form', :layout => false
      return
    end
    @ic = Iconv.new('UTF-8//IGNORE', 'gb2312//IGNORE')
    @ic2 = Iconv.new('gb2312//IGNORE', 'UTF-8//IGNORE')
    @coder = HTMLEntities.new

    #get key word
    q = params[:q]
    q = q.squeeze(' ').strip unless q.blank?

    #get search source <web, wenda>
    t = params[:t] || 'web'
    t = ['web', 'wenda'].include?(t) ? t : 'web'

    #get page number
    @page = params[:page].to_i || 1
    @page = (1..100).include?(@page) ? @page : 1

    options = {:source => t.to_sym, :key_word => CGI.escape(@ic2.iconv(q)), :page => @page}
    # result = {:record_arr => [], :ext_key_arr => [], :source => 'web'}
    @result = Forager.get_result(options)
  
  end
end