class Order < ActiveRecord::Base
  belongs_to :shop
  belongs_to :user
  has_many :order_details, :dependent => :destroy

  #scope :status, group(:status)
  def self.recent(count)
    Order.order("updated_at DESC").limit(count)
  end


end
