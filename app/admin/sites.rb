#encoding: utf-8
ActiveAdmin.register Site do
  menu :priority  => 1

  sidebar :"帮助中心" do
  	ul do
  	  li "本页用户设置网站的全局数据！"
  	  li "注意：已经固定设置的内容，请不要修改’名称‘，只需要修改相应的’值‘。否则网站无法正确获取您设置的数据。"
  	end
  end
end
