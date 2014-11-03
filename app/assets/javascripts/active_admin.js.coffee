#= require jquery
#= require jquery_ujs
#= require jquery-ui
#= require datetimepicker/jquery.datetimepicker.js
#= require active_admin/base

setupDateTimePicker = (container) ->
  defaults =
    formatDate: 'y-m-d'
    format: 'Y-m-d H:i'
    allowBlank: true
    defaultSelect: false
    validateOnBlur: false

  $(container).find('.jquery-datetime-picker').each ->
    options = $(@).data('datepicker-options')
    $(@).datetimepicker $.extend(defaults, options)

$ ->
  $(document).on('focus', '.datepicker:not(.hasDatepicker)', ->
    options = $(@).data 'datepicker-options'
    $(@).datetimepicker $.extend(defaults, options)
  )

  $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
    setupDateTimePicker fieldset

  setupDateTimePicker document.body
