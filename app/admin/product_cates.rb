#encoding: utf-8
ActiveAdmin.register ProductCate do
  menu :label => '成功案例', :priority  => 4
  menu :label => "案例分类", :parent => "成功案例"

  sidebar :"帮助中心" do
  	ul do
  	  li "本页保存案例的分类信息！"
  	end
  end
end