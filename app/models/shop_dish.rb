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

  def show_dish_photo
    dish_dir = self.dish.en_name.to_s.gsub(/ /, '-')
    photo_path = "/dish/#{dish_dir}/1.jpg"
    if File.exist?(File.join(Rails.root, 'public', photo_path))
      %{<img src="#{photo_path}" alt="#{dish.name}"/>}
    else
      ""
    end
  end
  
  def show_dish_price
    price.blank? ? "" : "价格：#{price}"
  end
end
