# see: http://jqueryui.com/demos/autocomplete/
# 
jQuery ->
  $('#slideshow1').sliders({ delay: 4500, speed: 500,ease: 'easeInBack' })

  $('#address_addr').bind 'focus', (event) ->
    if $('#address_addr').val() == '   输入您所在的地址'
      $('#address_addr').val('')
  
  #
  #see: http://stackoverflow.com/questions/2823227/google-maps-modal-dialog-jquery
  $('#submit').bind 'click', (event) ->
    event.preventDefault()
    initialize_point()
    confirm_address '<br/>红色鼠标代表您当前所在的位置，用鼠标点击修改', () ->
      window.location.href = 'http://localhost:3000/get_address_by_point?' + 'lat=' + $('#address_latitude').val() + '&lng=' + $('#address_longitude').val()
    false
  confirm_address = (message, callback) ->
    $('#confirm').modal
      persist: false
      closeHTML: "<a href='#' title='Close' class='modal-close'>x</a>"
      position: ["20%",]
      overlayId: 'confirm-overlay'
      containerId: 'confirm-container'
      onShow: (dialog) ->
        #resize_gmap('confirm')
        modal = this
        $('.message', dialog.data[0]).append(message)
        $('.yes', dialog.data[0]).bind 'click', () ->
          if $.isFunction(callback)
            callback.apply()
          modal.close()
