#encoding: utf-8
ActiveAdmin.register Order do
  menu :label => "订单管理", :priority  => 3
  menu :label => "订单信息", :parent => "订单管理"
end
