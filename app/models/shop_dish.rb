#encoding: utf-8
class ShopDish < ActiveRecord::Base
  belongs_to :shop
  belongs_to :dish
  has_many :order_details
  
  before_save :check_dish_validate

  attr_accessor :dish_name

  def check_dish_validate
    if self.dish_name.present? && self.dish_id.nil?
      dish = Dish.find_by_name(self.dish_name)
      self.dish_id = dish.id if dish.present?
    end
  end

  def show_dish_description
    self.dish.description
  end
  
  def show_dish_price
    price.blank? ? "" : "价格：#{price}"
  end
end
