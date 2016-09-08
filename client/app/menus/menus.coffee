Template.menus.onRendered ->
  Tracker.autorun ->
    Meteor.subscribe("invitations", Meteor.user().profile.email)


Template.menus.events {
  "click #menus .profilemenu .logout": ->
    Meteor.logout()
    Router.go("/")

  "mouseup #menus .groupmenu .groupitem": (evt) ->
    id = $(evt.currentTarget).data("id")
    $(".anything-else").click()
    $(".group-window .sections section").fadeOut(300, ->
      Meteor.call("setCurrentGroup", id)
      $(".group-window .sections section").delay(200).fadeIn(300)
    )

  "click #menus .notificationmenu .accept": (evt) ->
    id = $(evt.currentTarget).parents(".invitation").data("id")
    groupName = $(evt.currentTarget).parents(".invitation").data("name")
    Meteor.call("answerInvitation", id, true)
    Notify("success", "Du bist der Gruppe <b>#{groupName}</b> erfolgreich beigetreten.")

  "click #menus .notificationmenu .decline": (evt) ->
    id = $(evt.currentTarget).parents(".invitation").data("id")
    groupName = $(evt.currentTarget).parents(".invitation").data("name")
    Meteor.call("answerInvitation", id, false)
    Notify("error", "Einladung zur Gruppe <b>#{groupName}</b> abgelehnt.")

  "click .anything-else": ->
    $("#menus .menu, .anything-else").removeClass("slcd")
    $(".top-bar .top-menu .button").removeClass("slcd")
}

Template.menus.helpers {

  "groups": ->
    Groups.find()

  "knownUsers": ->
    Users.find()

  "notifications": ->
    if Invitations.findOne()? then true else false

  "invitations": ->
    Invitations.find()

  #"actions": ->
    #Actions.find()

}
