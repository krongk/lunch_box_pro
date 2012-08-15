class ShopDishVersion < ActiveRecord::Base
  belongs_to :shop
  belongs_to :dish
end
