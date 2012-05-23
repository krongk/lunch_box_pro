class ProductItem < ActiveRecord::Base
  belongs_to :product_cate

  def self.recent(count)
    ProductItem.order("updated_at DESC").limit(count)
  end

end
