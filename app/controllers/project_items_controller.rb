class ProjectItemsController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_project_cate

  def index
    @project_items = ProjectItem.where("tags regexp '#{params[:tag]}'").order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 16) if params[:tag]
    @project_items ||= params[:project_cate_id] ? 
      ProjectItem.where(:project_cate_id => params[:project_cate_id]).order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 16) : 
      ProjectItem.order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 16)
  end

  private
  def load_project_cate
    @project_cates = ProjectCate.all
  end
end
