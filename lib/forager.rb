$:.unshift(File.dirname(__FILE__))
require 'baidu_web/lib/baidu_web'
# require 'baidu_top/lib/baidu_top'
# require 'qihoo_wenda/lib/qihoo_wenda'

module Forager

  def self.get_result(opts)
    return BaiduWeb.search(opts[:key_word], :per_page => 20, :page_index => opts[:page])
  end
end