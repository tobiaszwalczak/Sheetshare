Meteor.subscribe("users")
Meteor.subscribe("userData")

Template.firstlogin.rendered = ->
  unless Meteor.user().firstLogin
    Session.set("firstLoginStep", 1)
    $(".dark-background").fadeIn(300, ->
      $(".first-login-popup").delay(100).fadeIn(300)
    )

Template.firstlogin.events {
  "click .first-login-popup .button.next-step": ->
    $(".first-login-popup .content-slider").animate({"left":"-=400px"}, 300, "easeInOutBack")
    Session.set("firstLoginStep", Session.get("firstLoginStep") + 1)

  "click .first-login-popup .button.prev-step": ->
    $(".first-login-popup .content-slider").animate({"left":"+=400px"}, 300, "easeInOutBack")
    Session.set("firstLoginStep", Session.get("firstLoginStep") - 1)

  "click .first-login-popup .package": (evt) ->
    $(".first-login-popup .package").removeClass("slcd")
    $(evt.currentTarget).addClass("slcd")

}

Template.firstlogin.helpers {
  "firstLoginStep": ->
    return Session.get("firstLoginStep")
}
