# encoding = utf-8
$:.unshift(File.dirname(__FILE__))

require 'baidu_web'
require 'cgi'
result = BaiduWeb.search(CGI.escape("游戏"), :per_page => 10, :page_index => 1)

# class Test
#   def self.search(key, ha)
#     puts key
#     puts ha
#     puts ha.class
#     puts ha.size
#     puts ha[:key].to_s
#     puts ha[:b].to_s
#     puts ha[:c].to_s

#   end
# end

#  Test.search('a', :a=>'a', :key => '444', :b=>44)


#  0.times do |i|
#  	puts i
#  end

# http://www.baidu.com/s?wd=%C3%C0%C5%AE&rsv_bp=0&rsv_spt=3&inputT=930
# http://www.baidu.com/s?wd=%B3%C9%B6%BC&pn=0&rn=5&usm=4
# http://www.baidu.com/s?wd=%C3%C0%C5%AE&pn=50&rn=50&usm=4
# http://www.baidu.com/s?wd=%C3%C0%C5%AE&pn=100&rn=50&usm=4

#  rn -> per page record
#  pn -> start record


# html = Hpricot(doc);nil


# ic = Iconv.new("utf-8//IGNORE", "GB2312//IGNORE")
# doc = ""
# open("http://www.baidu.com/s?rn=50&bs=%C3%C0%C5%AE&f=8&rsv_bp=1&wd=mysql&inputT=2955", "r:gb2312:utf-8") {|f|
#   f.each_line do |line|
#   	doc += ic.iconv(line)
#   end
# };nil

# doc = Hpricot(doc);nil

# results = doc.at("div[@id='container']");nil

# results.search("table[@class='result']");nil

# doc.search("table[@class='result-op']").remove


# <table class="result-op" 
# cellpadding="0" cellspacing="0" srcid="6669" id="2" 
# mu="http://soft.baidu.com/softwaresearch/s?tn=software&amp;rn=10&amp;wd=mysql" 
# data-op="{'y':'BF0FFF7F'}"><style>.op_mini_table01_content table{margin-top:4px;}.op_mini_table01_content th{text-align:left;white-space:nowrap;background:url("http://www.baidu.com/aladdin/img/table/bg.gif") repeat-x 0 -37px;font-weight:normal;height:26px;line-height:26px;font-size:13px;padding:0 10px 0 8px;}.op_mini_table01_content td{white-space:nowrap;font-size:14px;border-bottom:#eee 1px solid;}.OP_TABLE_COMMON{ width:100%;}.OP_TABLE_COMMON td{ padding:7px 10px 7px 8px; font-size:14px;}.OP_TABLE_COMMON a,.OP_TABLE_COMMON a em{ text-decoration:none;}.OP_TABLE_COMMON a:hover,.OP_TABLE_COMMON a:hover em{ text-decoration:underline;}</style><script>function jI(D){var C=D;var B=0;while(C=C.parentNode){B=parseInt(C.getAttribute("id"));if(B>0){break}}var A=C.getElementsByTagName("a");for(var B=0;B<A.length;B++){if(D==A[B]){return B}}return A.length-1}function _aMC(C){var B=C,A=-1;while(B=B.parentNode){A=parseInt(B.getAttribute("id"));if(A>0){return A}}};</script><tbody><tr><td class="f"><h3 class="t"><a onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this)})" href="http://soft.baidu.com/softwaresearch/s?tn=software&amp;rn=10&amp;wd=mysql" target="_blank"><font size="3"><em>mysql</em>_相关下载信息363条_百度软件搜索</font></a><span class="tsuf tsuf-op" data="{title : 'mysql_相关下载信息363条_百度软件搜索', link : 'http:\/\/soft.baidu.com\/softwaresearch\/s?tn=software&amp;rn=10&amp;wd=mysql'}"></span></h3><div class="op_mini_table01_content op_software"> <table cellspacing="0" class="OP_TABLE_COMMON"><tbody><tr><th style="border-left:0;">软件名称</th><th>软件大小</th><th>来源</th></tr>  <tr><td> <a target="_blank" onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this),'p2':jI(this)})" href="http://www.skycn.com/soft/30406.html">Apache+Php+<em>Mysql</em> V1.3 绿色自动安装版</a></td><td width="120px;"> 13.44 M </td><td> 天空软件站 </td></tr>   <tr><td> <a target="_blank" onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this),'p2':jI(this)})" href="http://www.newhua.com/soft/3573.htm"><em>MYSQL</em> 5.5.15</a></td><td width="120px;"> 27.76 M </td><td> 华军软件园 </td></tr>   <tr><td> <a target="_blank" onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this),'p2':jI(this)})" href="http://www.duote.com/soft/3169.html"><em>MYSQL</em> For Windows V5.0.67(无毒无插件)</a></td><td width="120px;"> 23.27 M </td><td> 多特软件站 </td></tr>   <tr><td> <a target="_blank" onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this),'p2':jI(this)})" href="http://dl.pconline.com.cn/html_2/1/79/id=465&amp;pn=0.html"><em>MYSQL</em> 5.1.59</a></td><td width="120px;"> 26.7 M </td><td> 太平洋下载 </td></tr>   <tr><td> <a target="_blank" onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this),'p2':jI(this)})" href="http://xiazai.zol.com.cn/detail/9/89874.shtml"><em>MySQL</em> 5.5.15官方下载</a></td><td width="120px;"> 28.43 M </td><td> ZOL软件下载 </td></tr>  </tbody></table> <div style="padding:4px 0 2px;"><a onmousedown="return c({'fm':'alop','title':this.innerHTML,'url':this.href,'p1':_aMC(this),'p2':jI(this)})" style="color:#7777CC;font-size:12px;" href="http://soft.baidu.com/softwaresearch/s?tn=software&amp;rn=10&amp;wd=mysql" target="_blank">查看全部363条结果<span style="font-family:simsun">&gt;&gt;</span></a></div><font size="-1" color="#008000">soft.baidu.com/softwaresearch/s?tn=software&amp;r... 2011-10-1</font></div> </td></tr></tbody></table>