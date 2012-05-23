class NewsCatesController < InheritedResources::Base
  before_filter :authenticate_admin_user!, :except => [:index, :show]
  before_filter :load_news_cate

  def index
  	@news_items = params[:news_cate_id] ? 
  	  NewsItem.where(:news_cate_id => params[:news_cate_id]).paginate(:page => params[:page] || 1) : 
  	  NewsItem.paginate(:page => params[:page] || 1)
  end

  def show
	@news_items = NewsCate.find(params[:id]).news_items.paginate(:page => params[:page] || 1)
	super
  end

  private
  def load_news_cate
  	@news_cates = NewsCate.all
  end
end
