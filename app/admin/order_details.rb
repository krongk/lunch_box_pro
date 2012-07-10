#encoding: utf-8
ActiveAdmin.register OrderDetail do
  menu :label => "订单管理", :priority  => 3
  menu :label => "订单详细", :parent => "订单管理"
end
