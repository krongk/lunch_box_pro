# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#shop_address_tokens').tokenInput '/shop_addresses.json'
    theme: 'facebook'
    prePopulate: $('#shop_address_tokens').data('load')
    propertyToSearch: "addr"
    hintText: "输入部分地址也行"
    noResultsText: "没找到匹配的位置"
    searchingText: "开找啦..."
    preventDuplicates: true
    tokenLimit: 1