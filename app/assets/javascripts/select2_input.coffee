setupDateTimePicker = (container) ->
  defaults =
    width: 'resolve'
    matcher: (search, text) ->
      search = search.toUpperCase()
      text = text.toUpperCase()
      j = -1

      for l in search
        continue if l == ' '
        j = text.indexOf(l, j+1)
        return false if j == -1

      return true

  $(container).find('.select2').each ->
    options = $(@).data('select2-options')
    $(@).select2 $.extend(options, defaults)

$ ->
  $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
    setupDateTimePicker fieldset

  setupDateTimePicker document.body
