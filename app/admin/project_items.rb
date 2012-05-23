#encoding: utf-8
ActiveAdmin.register ProjectItem do
  menu :label => "项目", :parent => "IT项目中心"

  index do 
    column :id
    column :title
    column :site_url do |item|
       item.site_url.blank? ? '' : "<a href='http://#{item.site_url.sub(/^http((:)?\/\/)?/, '')}' target='_blank'>#{item.site_url}</a>".html_safe
    end
    column :name
    column :phone
    column :email
    column :city
    column :company
    column :is_forager
    column :is_verfied
    column :updated_at
    default_actions
  end
end