#encoding: utf-8

require "geocoder"
require "iconv"

@ic = Iconv.new("UTF-8//IGNORE", "GB2312//IGNORE")
addr =  "四川省成都市锦江区工业园区三色路38号"
puts Geocoder.coordinates(addr)