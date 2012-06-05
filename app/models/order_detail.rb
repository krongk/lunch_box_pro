class OrderDetail < ActiveRecord::Base
  belongs_to :order
  belongs_to :shop_dish
end
