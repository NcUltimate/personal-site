Main = {
  initialize: ->
    this.Background.initialize()
    this.Menu.initialize()
    this.Embroidery.initialize()
}
$.jklemen = $.extend($.jklemen, Main)

$ -> 
  if $(window).width() <= 480
    setTimeout(->
      $('.site-menu').addClass('hidden')
    , 500)

  $(document).on 'click', '.hamburger', (e) ->
      $('.site-menu').toggleClass('hidden')

  $(window).on 'resize', (e) ->
    if $(window).width() <= 480
      $('.site-menu').addClass('hidden')
    else
      $('.site-menu').removeClass('hidden')

