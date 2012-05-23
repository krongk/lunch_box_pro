#encoding: utf-8
ActiveAdmin.register Page do
  menu :label => "网页中心", :priority  => 2
  menu :parent => "网页中心"

  filter :title
  filter :menu_match
  filter :updated_at
  filter :show_in_menu
  filter :deletable

  index do
    column :id
    column :title do |item|
      link_to item.title, admin_page_path(item)
    end
    column :body do |item|
      strip_tags(item.body).truncate(80) unless item.body.blank?
    end
    column :path_name
    # column :updated_at do |item|
    #   item.updated_at.strftime("%Y-%m-%d")
    # end
    default_actions
  end

  show do |item|
    h3 item.title, :class => 'admin_title'
    div :class => 'admin_content' do
      simple_format item.body
    end
  end

  sidebar :"帮助中心" do
    ul do
      li "网站前台大部分的网页的动态编辑部分，都在这部分修改！"
      li "请根据’标题‘与前台的菜单相对应。"
      li "’删除‘操作，可能导致前台显示错误，所以在考虑要删除一条数据，请别点击’删除‘菜单，而是在编辑页面中，将’可否删除‘修改为’1‘。"
    end
  end

end
