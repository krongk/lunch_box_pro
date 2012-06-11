class Dish < ActiveRecord::Base
  belongs_to :dish_cate

  def photos
    dish_dir = self.en_name.to_s.gsub(/ /, '-')
    photo_path = "/dish/#{dish_dir}/1.jpg"
    if File.exist?(File.join(Rails.root, 'public', photo_path))
      %{<img src="#{photo_path}" alt="#{dish.name}"/>}
    else
      ""
    end
  end

end
