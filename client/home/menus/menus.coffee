Template.home.events {
  #copy to menus.coffee
  "click .top-bar .top-menu .profile-button": ->
    $(".anything-else").toggleClass("slcd")
    $(".menus .profilemenu").toggleClass("slcd")
    $(".top-bar .top-menu .profile-button").toggleClass("slcd")

  "click .anything-else": ->
    $(".anything-else").removeClass("slcd")
    $(".menus .profilemenu").removeClass("slcd")
    $(".top-bar .top-menu .profile-button").removeClass("slcd")
}

Template.menus.events {
  "click .menus .profilemenu .logout": ->
    BigScreen.exit()
    Meteor.logout()
    Router.redirect("/")
}
