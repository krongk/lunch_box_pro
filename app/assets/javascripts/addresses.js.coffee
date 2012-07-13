# see: http://jqueryui.com/demos/autocomplete/
# 
jQuery ->
  $('#how_to_shop').bind 'click', (event) ->
    $('#div_liucheng').slideToggle(500)

  $('#slideshow1').sliders({ delay: 4500, speed: 500,ease: 'easeInBack' })

  $('#address_addr').bind 'focus', (event) ->
    if $('#address_addr').val() == '   输入您所在的地址'
      $('#address_addr').val('')