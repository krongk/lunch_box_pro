# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
# 鼠标滚动到最后时候，加载更多列表：
# 参考：
# 错误：出现"ActionView::MissingTemplate" 和"undifiend method formats for nil.class" 错误
# 解决：在welcome/index.js.erb中，修改为： <%# j render(:partial => 'welcome/shop_addresses', 。。。
#        新建一个partial:　_shop_addresses.html.erb 用于展示餐厅列表， 当要翻页的时候，只是渲染此页。
jQuery ->
  if $('.pagination').length
    $(window).scroll ->
      url = $('.pagination .next_page').attr('href')
      if url && $(window).scrollTop() > $(document).height() - $(window).height() - 50
        $('.pagination').html("<p><img src='/assets/loading.gif'/></p>")
        $.getScript(url)
    $(window).scroll()

##http://stackoverflow.com/questions/2970558/bind-a-jquery-function-to-elements
#废弃了，用rails remote link 实现了
#jQuery ->
#  sp = '一'
#  increas =  -> sp = sp + '一'
#  ljust = (s) ->
#    total = 12 - s.length
#    sp = '一'
#    increas i for i in [1..total]
#    "#{s}#{sp}"
#
#  $('li.dish_item').bind 'click', (e) =>
#    current_li = $( e.target ).closest( "li" )
#    current_li.css("background-color", "#ccc")
#
#    str = "<li>#{ljust(current_li.attr('data-name'))}#{current_li.attr('data-price')} x 1</li>"
#    $('#order_dish_list').append(str)
