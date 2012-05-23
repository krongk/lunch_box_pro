class ProjectCatesController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_project_cate
  include ApplicationHelper
  
  def index
    @project_items = params[:project_cate_id] ? 
      ProjectItem.where(:project_cate_id => params[:project_cate_id]).order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 16) : 
      ProjectItem.order("updated_at DESC").paginate(:page => params[:page] || 1, :per_page => 16)
    @project_cate = ProjectCate.find_by_id(params[:project_cate_id]) || ProjectCate.first
  end

  def show
    @project_items = ProjectCate.find(params[:id]).project_items.paginate(:page => params[:page] || 1, :per_page => 16)
    super
  end

  private
  def load_project_cate
    @project_cates = ProjectCate.all
  end
end
