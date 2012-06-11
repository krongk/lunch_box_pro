#encoding: utf-8
class ShopDish < ActiveRecord::Base
  belongs_to :shop
  belongs_to :dish

  def show_dish_name
    self.dish.name
  end

  def show_dish_description
    self.dish.description
  end
  
  def show_dish_price
    price.blank? ? "" : "价格：#{price}"
  end
end
