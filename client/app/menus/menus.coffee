Template.menus.events {
  "click #menus .profilemenu .logout": ->
    BigScreen.exit()
    Meteor.logout()
    Router.go("/")

  "mouseup #menus .groupmenu .groupitem": (evt) ->
    id = $(evt.currentTarget).data("id")
    $(".anything-else").click()
    $(".group-window .sections section").fadeOut(300, ->
      Meteor.call("setCurrentGroup", id)
      $(".group-window .sections section").delay(200).fadeIn(300)
    )

  "click .anything-else": ->
    $("#menus .menu, .anything-else").removeClass("slcd")
    $(".top-bar .top-menu .button").removeClass("slcd")
}

Template.menus.helpers {

  "groups": ->
    Groups.find()

  "knownUsers": ->
    Users.find()

}
