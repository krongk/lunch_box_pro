#encoding: utf-8
ActiveAdmin.register Part do
  menu :parent => '网页中心'
  filter :title

  index do
    column :id
    column :title
    column :body do |item|
      strip_tags(item.body).truncate(120) unless item.body.blank?
    end
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
      li "网页片段部分，用于一些特殊公用部分内容的设置。如果网站前台没有体现，或者开发人员没有特别提出，不用编辑该部分的任何内容！"
    end
  end
end
