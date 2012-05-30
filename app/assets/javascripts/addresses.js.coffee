# see: http://jqueryui.com/demos/autocomplete/
# 
jQuery ->
  $('#address_addr').autocomplete
    source: $('#address_addr').data('autocomplete-source')
    minLength: 2
    autoFocus: true
    delay: 300
