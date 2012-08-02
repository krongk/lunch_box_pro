# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('.remove_fields').bind 'click', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('.add_fields').bind 'click', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).attr('data-fields'))
    event.preventDefault()

  #auto-complete 菜单 home/_shop_dish_fields.html.rb
  $('.dish_name_field').autocomplete
    source: $('.dish_name_field').data('autocomplete-source')

  #通过菜单名找到菜单ID,在价格输入框blur的时候，将ID设置给隐藏的dish_id属性
  $('.dish_price').bind 'blur', (event) ->
    dish_name = $(this).prev('input')
    dish_id = $(dish_name).prev('input').val()
    $.getJSON '/get_dish.json?name=' + dish_name.attr('value'), (data) ->
      $(dish_name).prev('input').val(data)
      