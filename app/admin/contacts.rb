#encoding: utf-8
ActiveAdmin.register Contact do
  menu :label => "客户留言", :priority  => 12
  filter :cate
  filter :title
  filter :name
  filter :email
  filter :phone
  filter :updated_at

  sidebar :"帮助中心" do
  	ul do
  	  li "本页保存客户前台的留言信息！"
  	end
  end
end
