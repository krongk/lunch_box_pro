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
end
