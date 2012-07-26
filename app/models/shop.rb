#encoding: utf-8
class Shop < ActiveRecord::Base
  has_one :shop_address, :dependent => :destroy  
  has_one :shop_contact, :dependent => :destroy  
  has_many :shop_dishes, :dependent => :destroy  
  has_many :dishes, :through => :shop_dishes
  has_many :orders, :dependent => :destroy  
  
  #user to add edit shop, add contact, address
  accepts_nested_attributes_for :shop_address, allow_destroy: false
  accepts_nested_attributes_for :shop_contact, allow_destroy: false
  accepts_nested_attributes_for :shop_dishes, allow_destroy: true

  #scope
  scope :new_added, where(:is_new_added => true)
  scope :contacted, where(:is_contacted => true)
  scope :dealed, where(:is_dealed => true)

  #one shop must has one contact, one address
  after_save :create_address_contact


  def self.recent(count)
    Shop.order("updated_at DESC").limit(count)
  end

  def create_address_contact
    #create addxress
    ShopAddress.find_or_create_by_shop_id(self.id)
    #create contact
    ShopContact.find_or_create_by_shop_id(self.id)
  end

  def show_biz_or_outer_time
    !outer_time.blank? ? %{<p class="outer_time">配送时间：#{outer_time}</p>}.html_safe :
    biz_time.blank? ? "" : %{<p class="biz_time">营业时间：#{biz_time}</p>}.html_safe
  end

  def show_avg
    avg.blank? ? "" : "<p>人均：￥#{avg}</p>".html_safe
  end

  def show_has_out_food
    has_out_food ? %{<p class="has_out_food">该店提供外卖</p>}.html_safe : 
      %{<p class="no_out_food"><i>该店暂没上网开店 #{[self.shop_contact.tel_phone, self.shop_contact.mobile_phone].any? ? "<br/>您可以直接电话预订！" : ""}</i></p>}.html_safe
  end

  def show_start_price
    start_price.blank? ? "" : %{<p class="shop_right">起送价：￥#{start_price}</p>}.html_safe
  end

  def show_outer_price
    outer_price.blank? ? "" : %{<p class="shop_right">配送费：￥#{outer_price}</p>}.html_safe
  end

  def show_is_hot
    !is_hot ? "" : %{<span class="shop_right_status hot">热卖</span>}.html_safe
  end

  def show_is_discount
    !is_discount ? "" : %{<span class="shop_right_status discount">打折</span>}.html_safe
  end
  def show_discount
    is_discount.blank? ? "" : "<p>有优惠，打#{discount_value}折</p>".html_safe
  end


  def show_take_out_status
    take_out_status.blank? ? "" : %{<span class="shop_right_status take_out_status">#{take_out_status}</span>}.html_safe 
  end

  def show_description
    str = '<div class="shop_description">'
    if self.description.blank?
      str += %{分类：#{self.shop_cate}} unless self.shop_cate.blank?
      if self.shop_dishes.any?
        str += %{, &nbsp;&nbsp;主推：#{self.shop_dishes.map{|sd| sd.dish.present? ? sd.dish.name : ''}.join(', ')}}
      end
    else
      i = 0
      str += self.description.gsub(/(:?"|“)([^“”]+)(:?"|”)/){|m| %{<span class="rand_#{i += 1}">#{m}</span>}}
    end
    unless shop_note.blank?
      str += %{<p class="shop_note"><b>店长公告：</b>&nbsp;&nbsp;#{shop_note}</p>}
    end
    str += '</div>'
    str.to_s.html_safe
  end
  def show_rate
    rate.blank? ? "" : %{<p><span class="rate rate_#{rate.to_i}">&nbsp;</span><span>&nbsp;&nbsp;评级：#{rate}</span></p>}.html_safe
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
    if photo_url.blank?
      %{<span style="float: left: padding: 4px; background-color:#ddd;"><img src="/assets/shop.jpg" alt="#{name}" width="100px"/></span>}.html_safe
    else
      photo_arr = photo_url.split(',').map{|c| c.strip}
      %{<span style="float: left: padding: 4px; background-color:#ddd;"><img src="/shop/#{photo_arr[0]}" alt="#{name}"  width="100px"/></span>}.html_safe
    end
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
        %{<p>订餐电话： <span class="red">#{[self.shop_contact.tel_phone, self.shop_contact.mobile_phone].compact.join("<br/>")}</span></p>}.html_safe :
        ""
  end
 
end
