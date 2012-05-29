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
      flash[:notice] = "请输入正确的地址"
      redirect_to new_address_path
      return
    end
    #2. geocoder 地址
    a = Address.get(q)
    unless a
      flash[:notice] = "您输入的地址无效，找不到与您地址匹配的任何信息"
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
    redirect_to '/'
  end

  #render json used for auto-complete
  def index
    @addresses = Address.order(:addr).where("addr like ?", "%#{params[:term]}%").limit(10)
    render json: @addresses.map(&:addr)
  end
end
