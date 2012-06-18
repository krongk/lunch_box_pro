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
    if is_discount
      "有优惠，打#{discount_value}折"
    else
      ""
    end
  end

  def show_biz_time
    if biz_time.blank?
      ""
    else
      "营业时间：#{biz_time}"
    end
  end

  def show_avg
    if avg.blank?
      ""
    else
      "人均：￥#{avg}"
    end
  end

  def show_has_out_food
    if has_out_food
      "提供外卖"
    else
      "不提供外卖"
    end
  end

  def show_start_price
    "起送价：#{start_price}"
  end

  def show_outer_price
    "配送费：#{outer_price}"
  end

  def show_is_hot
    if is_hot
      "推荐"
    else
      ""
    end
  end

  def show_is_discount
    if is_discount
      "有折扣"
    else
      ""
    end
  end

  def show_rate
    rate.blank? ? "" : "评级：#{rate}"
  end
  def show_score
    score.blank? ? "" : "点评数：#{score}"
  end
  def show_score_sudu
    score_sudu.blank? ? "" : "速度：#{score_sudu}"
  end
  def show_score_kouwei
    score_kouwei.blank? ? "" : "口味：#{score_kouwei}"
  end
  def show_score_fuwu
    score_fuwu.blank? ? "" : "服务：#{score_fuwu}"
  end
  def show_tags
    tags.blank? ? "" : tags.split(',').map{|t| "<a href='/tags?#{t}' target='_blank'>#{t}</a>"}.join("，")
  end
  def show_photo_url
    photo_url.blank? ? "" : %{<span style="float: left: padding: 4px;"><img src="#{photo_url}" alt="#{name}"/></span>}
  end
  def show_shihe
    shihe.blank? ? "" : %{适合：#{shihe}}
  end
  def show_sheshi
    sheshi.blank? ? "" : %{<p>设施：#{sheshi}</p>}
  end
 
end
