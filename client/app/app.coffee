Template.app.events {
  "click .top-bar .top-menu .fullscreen-button": (evt) ->
    if BigScreen.enabled
      $(evt.target).toggleClass("exit-fullscreen")
      if $(evt.target).hasClass("exit-fullscreen")
        BigScreen.request()
        $(evt.target).attr({title: "Fenstermodus"})
        $(evt.target).html("").html("<i class='mdi mdi-fullscreen-exit'></i>")
      else
        BigScreen.exit()
        $(evt.target).attr({title: "Vollbildmodus"})
        $(evt.target).html("").html("<i class='mdi mdi-fullscreen'></i>")
    else
      # TODO: Fallback
}
