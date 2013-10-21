#= require jquery
#= require results.jst
#= require_tree ./examples

$ = jQuery

class App
  constructor: ->
    @$results  = $('.results').hide()
    @$info     = $('.info')
    @$textarea = $('textarea').on('input', @debounce(@render))

    $('.examples [data-name]').click(@clickExample)
    $('body').on('click', '.clear', @clickClear)

  clickExample: (e) =>
    e.preventDefault()

    name = $(e.currentTarget).data('name')
    @$textarea.val(JST["examples/#{name}"]())
    @render()

  clickClear: (e) =>
    e.preventDefault()
    @$textarea.val('')
    @render()

  render: =>
    text = @$textarea.val()

    if text
      @showLoading()

      $.post('/lint', text: text)
        .complete(@hideLoading)
        .success(@done)

    else
      @$info.show()
      @$results.hide()

  done: (results) =>
    @$info.hide()
    @$results.html(JST['results'](results)).show()

  showLoading: =>
    @$info.hide()
    @$results.html(JST['results'](loading: true)).show()

  debounce: (callback, wait = 500) ->
    timeout = null

    (args...) ->
      later = =>
        callback(args...)

      clearTimeout(timeout)
      timeout = setTimeout(later, wait)

$ -> new App