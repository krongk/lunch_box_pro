#encoding: utf-8
class Shop < ActiveRecord::Base
  has_one :shop_address
  has_one :shop_contact
  has_many :shop_dishes
  has_many :dishes, :through => :shop_dishes

  accepts_nested_attributes_for :shop_address, allow_destroy: false
  accepts_nested_attributes_for :shop_contact, allow_destroy: false
  accepts_nested_attributes_for :shop_dishes, allow_destroy: true

  after_save :create_address_contact

  def create_address_contact
    #create addxress
    ShopAddress.create(
      :shop_id => self.id,
      :region_id => 23,
      :city_id => 234
    )
    #create contact
    ShopContact.create(
      :shop_id => self.id
    )
  end

  def show_discount
    is_discount.blank? ? "" : "<p>有优惠，打#{discount_value}折</p>".html_safe
  end

  def show_biz_time
    biz_time.blank? ? "" : "<p>营业时间：#{biz_time}</p>".html_safe
  end

  def show_avg
    avg.blank? ? "" : "<p>人均：￥#{avg}</p>".html_safe
  end

  def show_has_out_food
    has_out_food ? %{<p class="has_out_food">该店提供外卖</p>}.html_safe : 
      %{<p>该店暂没上网开店<br/>您可以直接致电预定！</p>}.html_safe
  end

  def show_start_price
    start_price.blank? ? "" : "<p>起送价：￥#{start_price}</p>".html_safe
  end

  def show_outer_price
    outer_price.blank? ? "" : "<p>配送费：￥#{outer_price}</p>".html_safe
  end

  def show_is_hot
    !is_hot ? "" : %{<span class="hot">热卖</span>}.html_safe
  end

  def show_is_discount
    !is_discount ? "" : %{<span class="discount">打折</span>}.html_safe
  end

  def show_description
    if self.description.blank?
      str = %{主打：#{self.shop_cate}} unless self.shop_cate.blank?
      if self.shop_dishes.any?
        str += %{主推：#{self.shop_dishes.map{|sd| sd.dish.name}.join(', ')}}
      end
      str.html_safe
    else
      i = 0
      self.description.gsub(/(:?"|“)([^“”]+)(:?"|”)/){|m| %{<span class="rand_#{i += 1}">#{m}</span>}}.html_safe
    end
  end
  def show_rate
    rate.blank? ? "" : "<p>评级：#{rate}</p>".html_safe
  end
  def show_score
    score.blank? ? "" : "<p>点评数：#{score}</p>".html_safe
  end
  def show_score_sudu
    score_sudu.blank? ? "" : "<p>速度：#{score_sudu}</p>".html_safe
  end
  def show_score_kouwei
    score_kouwei.blank? ? "" : "<p>口味：#{score_kouwei}</p>".html_safe
  end
  def show_score_fuwu
    score_fuwu.blank? ? "" : "<p>服务：#{score_fuwu}</p>".html_safe
  end
  def show_tags
    tags.blank? ? "" : tags.split(',').map{|t| "<a href='/tags?#{t}' target='_blank'>#{t}</a>"}.join("，")
  end
  def show_photo
    photo_url.blank? ? %{<span style="float: left: padding: 4px; background-color:#ddd;"><img src="/assets/shop.jpg" alt="#{name}" width="100px"/></span>}.html_safe : 
      %{<span style="float: left: padding: 4px; background-color:#ddd;"><img src="#{photo_url}" alt="#{name}"  width="100px"/></span>}.html_safe
  end
  def show_shihe
    shihe.blank? ? "" : %{适合：#{shihe}}.html_safe
  end
  def show_sheshi
    sheshi.blank? ? "" : %{<p>设施：#{sheshi}</p>}.html_safe
  end

  def show_address
    self.shop_address.nil? ? "" : %{<p>地址：#{self.shop_address.addr}</p>}.html_safe
  end

  def show_contact_phone
    self.shop_contact.nil? ? "" : 
      [self.shop_contact.tel_phone, self.shop_contact.mobile_phone].any? ? 
        %{<p>订餐电话： #{[self.shop_contact.tel_phone, self.shop_contact.mobile_phone].compact.join("<br/>")}</p>}.html_safe :
        ""
  end
 
end
