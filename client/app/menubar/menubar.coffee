Template.menubar.events {
  "click #menubar .fullscreen-button": (evt) ->
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

  "click #menubar .group-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .group-button").hasClass("slcd")
      $(".top-bar .top-menu .group-button, #menus .groupmenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .group-button").hasClass("slcd")
      $("#menus .menu, .top-bar .top-menu .button").removeClass("slcd")
      $(".top-bar .top-menu .group-button, #menus .groupmenu").addClass("slcd")
    else
      $(".top-bar .top-menu .group-button, #menus .groupmenu, .anything-else").removeClass("slcd")

  "click #menubar .profile-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .profile-button").hasClass("slcd")
      $(".top-bar .top-menu .profile-button, #menus .profilemenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .profile-button").hasClass("slcd")
      $("#menus .menu, .top-bar .top-menu .button").removeClass("slcd")
      $(".top-bar .top-menu .profile-button, #menus .profilemenu").addClass("slcd")
    else
      $(".top-bar .top-menu .profile-button, #menus .profilemenu, .anything-else").removeClass("slcd")

}
