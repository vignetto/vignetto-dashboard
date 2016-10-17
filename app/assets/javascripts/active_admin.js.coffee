#= require active_admin/base
#= require jquery-ui-timepicker-addon.min

$(document).ready ->
  initDatetimePicker = (fields) ->  
    selection = if fields == 0 then 'input.hasDatetimePicker' else fields
    $(selection).datetimepicker
      controlType: 'select'
      oneLine: false
      dateFormat: 'dd/mm/yy'
      timeFormat: 'hh:mm  TT'
      beforeShow: ->
        setTimeout (->
          $('#ui-datepicker-div').css 'z-index', '3000'
          return
        ), 100
        return
    return

  initDatetimePicker(0)

  $('.has_many_container.event_items .button.has_many_add, .has_many_container.event_dates .button.has_many_add').on 'click', ->
    selection = '.'+$(this).parent().attr('class').toString().replace(/\s+/g, '.')+' input.hasDatetimePicker'
    setTimeout (->
      initDatetimePicker( selection )  
      return
    ), 1000  
    return