#= require jquery
#= require results.jst

$ = jQuery

class App
  constructor: ->
    @$results  = $('.results')
    @$textarea = $('textarea').on('input', @debounce(@submit))

  submit: (e) =>
    text    = @$textarea.val()
    request = $.post('/lint', text: text)

    request.success(@done)

  done: (results) =>
    @$results.html(JST['results'](results))

  debounce: (callback, wait = 300) ->
    timeout = null

    (args...) ->
      later = =>
        callback(args...)

      clearTimeout(timeout)
      timeout = setTimeout(later, wait)

$ -> new App