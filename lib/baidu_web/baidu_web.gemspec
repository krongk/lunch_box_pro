# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "baidu_web/version"

Gem::Specification.new do |s|
  s.name        = "baidu_web"
  s.version     = BaiduWeb::VERSION
  s.authors     = ["krongk"]
  s.email       = ["kenrome@gmail.com"]
  s.homepage    = "www.inruby.com"
  s.summary     = %q{baidu_web is a gem for search web info from Baidu(www.baidu.com)}
  s.description = %q{
        Use baidu_web:
          result = BaiduWeb.search('key words')
          result.each do |record|
             puts record.title
             puts record.url
             puts record.summary
             puts record.date
             puts record.item_index
             puts record.cached_url
          end

        Test baidu_web gem on irb:
          $:.unshift(File.dirname(__FILE__))
          require 'baidu_web'
          require 'cgi'
          result = BaiduWeb.search(CGI.escape("游戏"), :per_page => 10, :page_index => 1)
  }

  s.rubyforge_project = "baidu_web"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
