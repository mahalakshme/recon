setupDateTimePicker = (container) ->
  defaults =
    formatDate: 'y-m-d'
    format: 'Y-m-d H:i'
    allowBlank: true
    defaultSelect: false
    validateOnBlur: false

  $(container).find('.jquery-datetime-picker').each ->
    options = $(@).data('datepicker-options')
    $(@).datetimepicker $.extend(options, defaults)

$ ->
  $(document).on('focus', '.datepicker:not(.hasDatepicker)', ->
    options = $(@).data 'datepicker-options'
    $(@).datetimepicker $.extend(options, defaults)
  )

  $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
    setupDateTimePicker fieldset

  setupDateTimePicker document.body
