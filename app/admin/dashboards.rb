#encoding: utf-8
ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.
  section :"快速导航" do
    ul do
      li link_to "添加新闻", new_admin_news_item_path
      li link_to "添加页面", new_admin_page_path
      li link_to "添加页面片断", new_admin_part_path
      li link_to "添加资源", new_admin_resource_item_path
      li link_to "添加产品", new_admin_product_item_path
    end
  end

  section :"最新新闻列表" do
    ul do
      NewsItem.recent(10).collect do |item|
        li link_to(item.title, admin_news_item_path(item))
      end
    end
  end

  section :"最新产品列表" do
    ul do
      ProductItem.recent(10).collect do |item|
        li link_to item.title, admin_product_item_path(item)
      end
    end
  end

  section :"最新资源列表" do
    ul do
      ResourceItem.recent(10).collect do |item|
        li link_to item.resource_name, admin_resource_item_path(item)
      end
    end
  end
end
