Template.home.events {
  #copy to menus.coffee
  "click .top-bar .top-menu .profile-button": ->
    $(".menus .profilemenu").toggleClass("slcd")
    $(".top-bar .top-menu .profile-button").toggleClass("slcd")
}

Template.menus.events {
  "click .menus .profilemenu .logout": ->
    Meteor.logout()
    Router.go("/")
}
