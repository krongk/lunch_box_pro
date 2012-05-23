# encoding: utf-8
# This rake file is to initialize app and prepare data for user.
# steps:
#   1. rake rails_on_web:init_all_data
#   2. rake rails_on_web:generate_all_page

namespace :rails_on_web do
	desc "init all data(load_yaml, init_site_data, init_page_data)"
	task :init_all_data => [:load_yaml, :init_site_data, :init_page_data]

	desc "load yaml(private method: loading site_map.yml)"
	task :load_yaml => :environment do
	  puts 'loading yaml'
	  @conf = YAML.load_file("#{Rails.root}/config/site_map.yml")
	end

	desc "init site(insert site_map.yml menu of site into site page table)"
	task :init_site_data do
	  puts 'init site'
	  unless @conf['site'].nil?
		@conf['site'].each do |site|
		  if Site.find_by_name(site[0])
		  	puts "duplicate of site.name: #{site[0]}, skip"
		  	next
		  end
		  Site.create!(:name => site[0], :value => site[1])
		end
	  end
	end

	desc "init page(insert site_map.yml menu into page table)"
	task :init_page_data do
	  puts 'init page'
	  unless @conf['menu'].nil?
	  	@conf['menu'].each do |menu|
	  	  create_page(menu)
	  	end
	  end
	end
  #create pages to store in database
  def create_page(menu, parent = 0, position = 0)
      unless menu[1].nil?
        if Page.find_by_path_name(menu[0])
          puts "duplicate of menu: #{menu[0]}, skip"
          return
        end
        path_name = nil
        if parent > 0
          path_name = Page.find(parent).path_name if Page.find(parent)
        end
        meta_keywords = @conf['meta']['keywords']
        meta_description= @conf['meta']['description']
        page = Page.create!(
          :parent_id => parent,
          :path_name => path_name.nil? ? menu[0] : "#{path_name}:#{menu[0]}",
          :position => position,
          :title => menu[1]['title'],
          :menu_match => menu[1]['menu_match'],
          :meta_keywords => "#{menu[1]['title']} #{meta_keywords}",
          :meta_description => "#{menu[1]['title']}-#{meta_description}",
          :show_in_menu => menu[1]['show_in_menu'] || 1,
          :deletable => position == 0 ? 0 : 1  #0:no, 1:yes
        )
      end
      if page.present?
      parent = page.id
    else
      return
    end
      #insert sub menu
      while (menu = menu[1].nil? ? nil : menu[1]['menu']) do
        menu.each do |sub_menu|
          create_page(sub_menu, parent, position + 1)
        end
      end
  end
#========================================================================
  desc "generate all pages(load_page, generate_layout_page, generate_site_map)"
  task :generate_all_page => [:load_page, :generate_layout_page, :generate_site_map]
  
  desc "load pages(private method: loading erb pages to prepare generate page)"
  task :load_page => :environment do
    puts 'loading erb pages to prepare generate page'
    @site_map_path = "#{Rails.root}/app/views/home/site_map.html.erb"
    @layout_path = "#{Rails.root}/app/views/layouts/application.html.erb"
  end

  desc "generate site_map page"
  task :generate_site_map do
    site_map_page = File.open(@site_map_path, "w")
    str_html_arr = ["<ul>"]
    Page.where(:parent_id => 0).each do |parent_menu|
      str_html_arr << "<li><a href='/pages/#{parent_menu.path_name}'>#{parent_menu.title}</a></li>"
      sub_str_arr = ["<ul>"]
      Page.where(:parent_id => parent_menu.id).each do |sub_menu|
        sub_str_arr << "<li><a href='/pages/#{sub_menu.path_name}'>#{sub_menu.title}</a></li>"
      end
      sub_str_arr << "</ul>"
      str_html_arr << sub_str_arr.join('') if sub_str_arr.size > 2
      str_html_arr << "\n"
    end
    str_html_arr << "</ul>"
    site_map_page.write(str_html_arr.join)
    site_map_page.close
    puts 'site_map page generated'
  end

  desc "generate application layout page"
  task :generate_layout_page do
    file_line_arr = []
    File.open(@layout_path, "r") do |f|
      file_line_arr << f.readlines
    end

    #Chinese menu
    cn_html_arr = ["<ul>"]
    cn_html_arr << "<li><a href='/'>首页</a></li>"
    cn_html_arr << "<li><a href='/news_cates/'>新闻资讯</a></li>"
    Page.where(:parent_id => 0).each do |parent_menu|
      cn_html_arr << "<li><a href='/pages/#{parent_menu.path_name}'>#{parent_menu.title}</a></li>"
    end
    cn_html_arr << "</ul>"

    #English menu
    en_html_arr = ["<ul>"]
    en_html_arr << "<li><a href='/'>Home</a></li>"
    Page.where("path_name like 'english:%'").each do |parent_menu|
      en_html_arr << "<li><a href='/en/#{parent_menu.path_name}'>#{parent_menu.title}</a></li>"
    end
    en_html_arr << ["</ul>"]

    html_str = '<% if params[:action] == "en" %>'
    html_str += en_html_arr.join
    html_str += '<% else %>'
    html_str += cn_html_arr.join
    html_str += '<% end %>'

    html = file_line_arr.join.sub(/\[nav\]/i, html_str)
    layout_page = File.open(@layout_path, "w+")
    layout_page.write(html)
    layout_page.close
    puts 'layout page generated'
  end

end

#rake RAILS_ENV=production utils:send_expire_soon_emails

 #t.string :title!
      # t.text :body
      # t.integer :parent_id, :default => 0
      # t.integer :position, :default => 0
      # t.string :path
      # t.string :meta_keywords !
      # t.string :meta_description!
      # t.string :path_name!
      # t.string :menu_match
      # t.integer :show_in_menum, :default => 1
      # t.integer :deletable, :default => 1

# menu:
#     about:
#       title: 'about'
#       meta_keywords: 'key word'
#       meta_description: 'meta desc'
#       menu_match: '/about'
#       show_in_menu: 1
#       menu:
#         about_us:
#           title: 'about us'
#           meta_keywords: 'key word us'
#           meta_description: 'meta desc us'
#           menu_match: '/about_us'
#           show_in_menu: 1
#         oompany_value:
#           title: 'company val'
#           meta_keywords: 'key word val'
#           meta_description: 'meta desc val'
#           menu_match: '/company_value'
#           show_in_menu: 1
