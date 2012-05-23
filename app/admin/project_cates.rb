#encoding: utf-8
ActiveAdmin.register ProjectCate do
  menu :label => 'IT项目中心', :priority  => 5
  menu :label => "项目分类", :parent => "IT项目中心"

  sidebar :"帮助中心" do
    ul do
      li "本页保存IT项目的分类信息！"
      li "1. 投融资项目"
      li "2. 解决方案"
      li "3. 用户在线提交的项目，在<a href='contacts'>这里</a>".html_safe
    end
  end
end
