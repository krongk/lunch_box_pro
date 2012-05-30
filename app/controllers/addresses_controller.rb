#encoding: utf-8
class AddressesController < ApplicationController
  layout 'application2'
  def new
    @address = Address.new
  end

  def create
    #1. check params
    # ^[\u4E00-\u9FFF]+$     
    # 匹配简体和繁体     
    # ^[\u4E00-\u9FA5]+$     
    # 匹配简体  
    q = params[:address][:addr]
    if q.blank? || q !~ /[\u4E00-\u9FFF]{3,}/
      flash[:error] = "请输入正确的地址"
      redirect_to new_address_path
      return
    end
    #2. geocoder 地址
    a = Address.get(q)
    unless a
      flash[:error] = "您输入的地址无效，找不到与您地址匹配的任何信息"
      redirect_to new_address_path
      return
    end

    #3.set cookie
    cookies.delete :addr
    cookies[:addr] = "#{a.addr}|#{a.latitude},#{a.longitude}"

    #4.store IP-address
    if request.remote_ip
      begin
        ip_addr = IpAddress.find_or_create_by_ip(request.remote_ip)
        ip_addr.address_id = a.id
        ip_addr.save!
      rescue
      end
    end
    flash[:notice] = "欢迎来到成都订餐网，尽情享受您的订餐之旅吧！"
    redirect_to '/'
  end

  #render json used for auto-complete
  def index
    # puts "addr_has object::::::"
    # puts @@addr_hash

    # @@addr_has ||= RailsOnWeb::Application.config.address_token
    # @@addr_has = @@addr_has.select{|k, v| v =~ /#{params[:term]}/i}
    # @addresses = @@addr_has.keys[0..30]
    # render json: @addresses

    # @addresses = Address.address_hash.select{|k, v| v =~ /#{params[:term]}/i}.keys[0..10]
    # render json: @addresses

    @addresses = Address.where("en_addr like ? OR addr like ?", "%#{params[:term]}%", "%#{params[:term]}%").limit(10)
    render json: @addresses.map(&:addr)
  end
end
