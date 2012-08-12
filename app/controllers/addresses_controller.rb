#encoding: utf-8
require 'open-uri'
class AddressesController < ApplicationController
  layout 'application2'
  
  def new
    @address = Address.new
    session[:location_point] = nil
  end

  def create
    #if has point value redirect to index directly
    #else find point by addr on table Address/or Geocoder
    cookies.delete :user_input_addr
    if params[:address][:latitude] =~ /\d+/ && params[:address][:longitude] =~ /\d+/
      cookies[:user_input_addr] = { :value => "#{params[:address][:latitude]},#{params[:address][:longitude]}", :expires => 1.month.from_now } 
    else
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
      cookies[:user_input_addr] = { :value => "#{a.latitude},#{a.longitude}", :expires => 1.month.from_now } 
    end

    #reset addr session
    session[:shop_address_ids] = nil
    session[:location_point] = nil
    #reset cart session
    session[:cart] = nil
    #4.store IP-address
    if ip = request.remote_ip
      begin
        ip_addr = IpAddress.find_or_create_by_ip(ip)
        unless ip_addr.address_id == a.id
          ip_addr.address_id = a.id
          ip_addr.save!
        end
      rescue
      end
    end
    flash[:notice] = "欢迎来到成都订餐网，尽情享受您的订餐之旅吧！"
    redirect_to '/'
  end

  #render json used for auto-complete
  def index
    @addresses = Address.where("en_combined_addr like ? OR en_addr like ? OR addr like ?",  "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%").limit(10)
    render json: @addresses.map(&:addr)
  end
  #render json used for index address map
  def get_address_by_point
    if params[:lat] =~ /\d+/ && params[:lng] =~ /\d+/
      cookies.delete :user_input_addr
      cookies[:user_input_addr] = { :value => "#{params[:lat]},#{params[:lng]}", :expires => 1.month.from_now }
      redirect_to '/'
    else
      redirect_to '/g'
    end
  end

  def get_address_by_name
    q = params[:addr]
    #2. geocoder 地址
    @addr = Address.get(q) unless q == '' || q == '   输入您所在的区域，如天府广场'
    respond_to do |format|
      format.html #show.html
      format.js
      format.json { render :json => @addr.nil? ? [30.6580501, 104.0659671] : [@addr.latitude, @addr.longitude] }
    end
  end

end
