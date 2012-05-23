class NewsItem < ActiveRecord::Base
  belongs_to :news_cate

  def self.recent(count, cate = 0, image = false)
    conditions = cate > 0 ? "news_cate_id = #{cate}" : "true"
    conditions += " AND image_path IS NOT NULL" if image
    NewsItem.where(conditions).order("updated_at DESC").limit(count)
  end

  #if id = 1 return 1..9
  #if id = 5 return 1..10
  #if id = 7 return 2..12
  def self.recent_related(id)
  	low = id > 5 ? id-5 : 1
  	height = id > 10 ? id + 5 : id + (10 - id)
  	NewsItem.where("id in(#{(low..height).to_a.join(',')})")
  end
end
