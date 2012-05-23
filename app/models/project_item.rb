class ProjectItem < ActiveRecord::Base
  belongs_to :project_cate
  self.per_page = 12

  def self.recent(count)
    ProjectItem.order("updated_at DESC").limit(count)
  end

  def self.recent_related(tag)
  	ProjectItem.where("tags regexp '#{tag}'").limit(10)
  end
end
