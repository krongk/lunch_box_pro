# encoding: utf-8
ActiveAdmin.register ShopDish do
  belongs_to :shop
  
  menu :label => "餐厅菜单", :parent => "餐厅管理"
end
