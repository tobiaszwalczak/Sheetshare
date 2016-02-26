Meteor.subscribe("groups")

Template.home.events {
  "click .top-bar .top-menu .group-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .group-button").hasClass("slcd")
      $(".top-bar .top-menu .group-button, .menus .groupmenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .group-button").hasClass("slcd")
      $(".menus .menu, .top-bar .top-menu .button").removeClass("slcd")
      $(".top-bar .top-menu .group-button, .menus .groupmenu").addClass("slcd")
    else
      $(".top-bar .top-menu .group-button, .menus .groupmenu, .anything-else").removeClass("slcd")

  "click .top-bar .top-menu .profile-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .profile-button").hasClass("slcd")
      $(".top-bar .top-menu .profile-button, .menus .profilemenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .profile-button").hasClass("slcd")
      $(".menus .menu, .top-bar .top-menu .button").removeClass("slcd")
      $(".top-bar .top-menu .profile-button, .menus .profilemenu").addClass("slcd")
    else
      $(".top-bar .top-menu .profile-button, .menus .profilemenu, .anything-else").removeClass("slcd")

  "click .anything-else": ->
    $(".menus .menu, .anything-else").removeClass("slcd")
    $(".top-bar .top-menu .profile-button, .top-bar .top-menu .group-button").removeClass("slcd")

  "click .menu.groupmenu .grouplist .groupitem .name": (evt) ->
    id = $(evt.currentTarget).data("id")
    $(".anything-else").click()
    $(".group-window .sections section").fadeOut(300, ->
      Meteor.call("setCurrentGroup", id)
      $(".group-window .sections section").delay(200).fadeIn(300)
    )
}

Template.menus.events {
  "click .menus .profilemenu .logout": ->
    BigScreen.exit()
    Meteor.logout()
    Router.redirect("/")
}

Template.menus.helpers {
  "groups": ->
    return Groups.find()
}
