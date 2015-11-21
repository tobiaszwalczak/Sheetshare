Meteor.subscribe("users")
Meteor.subscribe("userData")

Template.home.events {
  "click .top-bar .top-menu .fullscreen-button": (evt) ->
    if BigScreen.enabled
      $(evt.target).toggleClass("exit-fullscreen")
      if $(evt.target).hasClass("exit-fullscreen")
        BigScreen.request()
        $(evt.target).attr({title: "Fenstermodus"})
        $(evt.target).html(Blaze.toHTMLWithData(Template.entypo, "browser"))
      else
        BigScreen.exit()
        $(evt.target).attr({title: "Vollbildmodus"})
        $(evt.target).html(Blaze.toHTMLWithData(Template.entypo, "resize-full-screen"))
    else
      # TODO: Fallback

  "click .dark-background": ->
    $(".popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
      $(".popup input").val("")
      $(".popup input").blur()
    )
}
