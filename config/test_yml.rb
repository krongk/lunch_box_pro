$:.unshift(File.dirname(__FILE__))
require 'rubygems'
require 'yaml'

conf = YAML.load_file(File.join(File.dirname(__FILE__), 'site_map.yml'))

unless conf['home'].nil?
	#home
	puts conf['home']['title']
	puts conf['home'][0]
	puts conf['home'][1]
	puts ',,,,,,,'
	conf["home"]["menu"].each do |menu| 
	  puts menu.size
	  puts menu[0]
	  puts menu[1]
	  puts menu[1]['title']
	  break
	end
end

# home:
#   title: 首页
#   menu:
#     about:
#       title: 关于我们
#       meta: 关于
#     contact:
#       title: 联系我们