$:.unshift(File.dirname(__FILE__))
require "sms_bao/version"
require 'open-uri'

module SmsBao
  #send sms
  def self.send(phones, content)
  	result = nil
  	user_name = 'inruby'
  	password = Digest::MD5.hexdigest "kenrome001"
  	open("http://www.smsbao.com/sms?u=inruby&p=#{password}&m=#{phones}&c=#{URI.escape(content)}") {|f|
      f.each_line {|line| result = line}
    }
    case result
    when '0'
	    'success'
    when '30' 
	    'password error'
    when '40'
      'bad account'
    when '41'
      'no money'
    when '42'
      'account expired'
    when '43'
      'IP denied'
    when '50'
      'content sensitive'
    when '51'
      'bad phone number'
    else 
	    'unknown error'
    end
  end
end

=begin
# http://www.smsbao.com/openapi

##短信发送API
http://www.smsbao.com/sms?u=USERNAME&p=PASSWORD&m=PHONE&c=CONTENT 
USERNAME：在本短信平台注册的用户名 
PASSWORD：平台登录密码MD5后的值 
PHONE：目标手机号码，多个手机号码用半角逗号分割 
CONTENT：发送内容，采用UTF-8 URL ENCODE 

返回 '0' 视为发送成功，其他内容为错误提示内容

##短信接收API
http://xxx.xxx.xxx/xxx?m=PHONE&c=CONTENT 
http://xxx.xxx.xxx/xxx：接收短信的URL地址 
PHONE：发送方手机号码 
CONTENT：短信内容，采用UTF-8 URL ENCODE 

返回 '0' 视为接收成功，其他内容为错误提示内容

##查询余额API
http://www.smsbao.com/query?u=USERNAME&p=PASSWORD 
USERNAME：在本短信平台注册的用户名 
PASSWORD：平台登录密码MD5后的值 

第一行返回 '0' 视为发送成功，其他内容为错误提示内容
如果第一行返回成功，则第二行返回 '发送条数,剩余条数'

##错误代码表
30：密码错误 
40：账号不存在
41：余额不足
42：帐号过期
43：IP地址限制
50：内容含有敏感词
51：手机号码不正确
=end