#encoding: utf-8
class Shop < ActiveRecord::Base
  attr_accessible :address_ids, :address_tokens
  has_one :shop_address
  has_one :shop_contact
  has_many :shop_dishes
  has_many :dishes, :through => :shop_dishes

  attr_reader :address_tokens

  def address_tokens=(ids)
    self.address_ids = ids.split(',')
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

  def show_is_hot
    if is_hot
      "推荐"
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
    photo_url.blank? ? "" : %{<span style="float: left: padding: 4px;"><img src="/shop/#{photo_url}" alt="#{name}"/></span>}
  end
  def show_shihe
    shihe.blank? ? "" : %{适合：#{shihe}}
  end
  def show_sheshi
    sheshi.blank? ? "" : %{<p>设施：#{sheshi}</p>}
  end
 
end
