#= require jquery
#= require results.jst
#= require_tree ./examples

$ = jQuery

class App
  constructor: ->
    @$results  = $('.results').hide()
    @$info     = $('.info')
    @$textarea = $('textarea').on('input', @debounce(@submit))
    @$loading  = $('.loading')

    $('.examples [data-name]').click(@clickExample)
    $('body').on('click', '.clear', @clickClear)

  clickExample: (e) =>
    e.preventDefault()

    name = $(e.currentTarget).data('name')
    @$textarea.val(JST["examples/#{name}"]())
    @$textarea.trigger('input')

  clickClear: (e) =>
    e.preventDefault()
    @$textarea.val('').trigger('input')

  submit: (e) =>
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
    @$loading.addClass('active')

  hideLoading: =>
    setTimeout =>
      @$loading.removeClass('active')
    , 300

  debounce: (callback, wait = 300) ->
    timeout = null

    (args...) ->
      later = =>
        callback(args...)

      clearTimeout(timeout)
      timeout = setTimeout(later, wait)

$ -> new App