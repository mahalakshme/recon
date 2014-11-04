setupSelectizeAutocomplete = (container) ->
  defaults =
    valueField: 'id'
    labelField: 'name'
    searchField: 'name'
    create: false
    load: (query, callback) ->
      console.log this
      return callback unless query.length

  $(container).find('.selectize-autocomplete').each ->
    options = $(@).data('selectize-options')
    $(@).selectize $.extend(options, defaults)

$ ->
  $(document).on 'has_many_add:after', '.has_many_container', (e, fieldset) ->
    setupSelectizeAutocomplete fieldset

  setupSelectizeAutocomplete document.body
