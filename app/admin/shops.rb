# encoding: utf-8
ActiveAdmin.register Shop do
  scope :new_added
  scope :contacted
  scope :dealed

  menu :label => "餐厅管理", :priority  => 2
  menu :label => "餐厅信息", :parent => "餐厅管理"

  index do |item|
    column :id
    column :name
    column '地址' do |item|
      item.shop_address.nil? ? ' ' : link_to(item.shop_address.addr, admin_shop_address_path(item.id))
    end
    column '联系人' do |item|
      span item.shop_contact.nil? ? ' ' : link_to(item.shop_contact.tel_phone, admin_shop_contact_path(item.id))
      span link_to('编辑', [admin_shop_contact_path(item.id), 'edit'].join('/'))
    end
    column '菜单' do |item|
      span item.shop_dishes.empty? ? ' ' : link_to('查看菜单', admin_shop_shop_dishes_path(item.id))
      span link_to('添加', [admin_shop_shop_dishes_path(item.id), 'new'].join('/'))
    end
    column :is_new_added
    column :is_contacted
    column :is_dealed
    default_actions
  end
end
