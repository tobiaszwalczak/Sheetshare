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

  "click .first-login-popup .button.done": ->
    # Mark users first login as done
    $(".popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
      $(".popup input").val("")
      $(".popup input").blur()
    )

  "click .first-login-popup .package": (evt) ->
    $(".first-login-popup .package").removeClass("slcd")
    $(evt.currentTarget).addClass("slcd")

  "click .first-login-popup .invite-button": ->
    $(".first-login-popup .invite-button").fadeOut(300, ->
      $(".first-login-popup #create-first-group #email").focus()
      $(".first-login-popup #create-first-group #email").fadeIn(300)
    )

  "blur #create-first-group #email": ->
    $(".first-login-popup #create-first-group #email").fadeOut(300, ->
      $(".first-login-popup #create-first-group #email").blur()
      $(".first-login-popup .invite-button").fadeIn(300)
    )
    $(".first-login-popup #create-first-group #email").hide()
}

Template.firstlogin.helpers {
  "firstLoginStep": ->
    return Session.get("firstLoginStep")
}
