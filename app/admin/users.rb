# encoding: utf-8
ActiveAdmin.register User do
  #menu false

  index do 
    column :id
    column :is_admin
    column :email do |item|
      link_to item.email || '<空>', admin_user_path(item)
    end
    column :sign_in_count
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :last_sign_in_ip
    default_actions
  end
end
