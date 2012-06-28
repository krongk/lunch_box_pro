# encoding: utf-8
ActiveAdmin.register Shop do
  scope :new_added
  scope :contacted
  scope :dealed

  menu :label => "餐厅管理", :priority  => 2
  menu :label => "餐厅信息", :parent => "餐厅管理"
  #scope_to :contacted
end
