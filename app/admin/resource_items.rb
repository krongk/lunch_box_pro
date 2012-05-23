#encoding: utf-8
ActiveAdmin.register ResourceItem do
  menu :parent => "资源中心"

  form :partial => "form"

  member_action :file_upload, :method => :put do 
  end

  controller do
      # This code is evaluated within the controller class
    def upload
  	  require 'fileutils'
  		tmp = params[:file_upload][:my_file].tempfile
  		file = File.join("public", params[:file_upload][:my_file].original_filename)
  		FileUtils.cp tmp.path, file
  		#FileUtils.rm fileutils
    end
  end

  sidebar :"帮助中心" do
    ul do
      li "资源分类包括网站所使用的所有：图片、音频、视频、flsh等！"
      li "在上传过程中，请一定要认真确认资源相对应的类型，否则前台无法正常显示！"
    end
  end

  index do
    column :id
    column :resource_path
    column :resource_name
    column :resource_note do |item|
      #str = ["名称：#{item.resource_name}<br/>"]
      #str << "描述：#{item.resource_note.to_s.truncate(200)}"
      str = []
      if item.resource_type == ResourceItem.type_hash.key('picture').to_s
        str << "<img src = '#{item.resource_path}' width = '60px' />"
      end
      str.join.html_safe
    end
    default_actions
  end

end
