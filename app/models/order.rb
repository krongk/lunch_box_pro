class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :order_details
end
