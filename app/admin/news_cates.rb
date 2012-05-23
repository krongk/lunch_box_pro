#encoding: utf-8
ActiveAdmin.register NewsCate do
  menu :label => "新闻中心", :priority  => 3
  menu :label => "新闻分类", :parent => "新闻中心"
end
