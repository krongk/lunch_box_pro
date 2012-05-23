#encoding: utf-8
ActiveAdmin.register NewsItem do
  menu :parent => "新闻中心"
  filter :title
  filter :external_path
  filter :created_at

  index do 
    column :id
    column :title do |item|
      link_to item.title || '<空>', admin_news_item_path(item)
    end
    column :body do |item|
      strip_tags(item.body).truncate(100) unless item.body.blank?
    end
    column :image_path do |item|
      unless item.image_path.blank?
        image_tag(item.image_path, :width => 60) 
      else
        "没有图片"
      end
    end
    column :external_path
    column :updated_at
    default_actions
  end
  # index :as => :grid, :columns => 5 do |item|
  #   li link_to item.title, admin_news_item_path(item)
  #   image_tag(item.image_path)
  # end

  show do |item|
    h3 item.title, :class => 'admin_title'
    div :class => 'admin_content' do
      simple_format item.body
    end
  end
end


# About strip_tags
# - remove html tag from body
# http://stackoverflow.com/questions/4253669/how-to-achieve-text-extract-on-rails