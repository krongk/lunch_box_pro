class ShopVersion < ActiveRecord::Base
  belongs_to :shop
  belongs_to :district
end
