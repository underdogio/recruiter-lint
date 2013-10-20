#= require jquery

$ = jQuery

class App
  constructor: ->
    @$form     = $('form').submit(@submit)
    @$textarea = $('textarea')

  submit: (e) =>
    e.preventDefault()

    text    = @$textarea.val()
    request = $.post('/lint', text: text)

    request.success(@done)

  done: (result) =>
    console.log(result)

$ -> new App