# see: http://jqueryui.com/demos/autocomplete/
# 
jQuery ->
  $('#address_addr').autocomplete
    source: $('#address_addr').data('autocomplete-source')
    delay: 0