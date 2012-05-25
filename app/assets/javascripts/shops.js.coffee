# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#shop_address_tokens').tokenInput '/shop_addresses.json'
    theme: 'mac'
    prePopulate: $('#shop_address_tokens').data('load')
    propertyToSearch: "addr"

