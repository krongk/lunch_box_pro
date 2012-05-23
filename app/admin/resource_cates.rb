#encoding: utf-8
ActiveAdmin.register ResourceCate do
  menu :label => "资源中心", :priority  => 5
  menu :label => "资源分类", :parent => "资源中心"  
  
  sidebar :"帮助中心" do
  	ul do
  	  li "资源分类包括网站所使用的所有：图片、音频、视频、flsh等！"
  	  li "你可以建立不同的分类来管理这些资源内容！"
  	end
  end
end
