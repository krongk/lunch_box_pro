class NewsCate < ActiveRecord::Base
  has_many :news_items

  def self.recent(count)
    NewsCate.limit(count)
  end
end
