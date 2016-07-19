Template.menus.events {
  "click #menus .profilemenu .logout": ->
    BigScreen.exit()
    Meteor.logout()
    Router.redirect("/")

  "click #menus .groupmenu .name": (evt) ->
    id = $(evt.currentTarget).data("id")
    $(".anything-else").click()
    $(".group-window .sections section").fadeOut(300, ->
      Meteor.call("setCurrentGroup", id)
      $(".group-window .sections section").delay(200).fadeIn(300)
    )

  "click .anything-else": ->
    $("#menus .menu, .anything-else").removeClass("slcd")
    $(".top-bar .top-menu .profile-button, .top-bar .top-menu .group-button").removeClass("slcd")
}

Template.menus.helpers {
  "groups": ->
    return Groups.find()
}
