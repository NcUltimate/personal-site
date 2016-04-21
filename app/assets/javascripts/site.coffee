Main = {
  initialize: ->
    this.Background.initialize()
    this.Menu.initialize()
    this.Embroidery.initialize()
}
$.jklemen = $.extend($.jklemen, Main)

$ -> $.jklemen.initialize()

