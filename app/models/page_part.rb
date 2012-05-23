class PagePart < ActiveRecord::Base
  belongs_to :page
  belongs_to :part
end
