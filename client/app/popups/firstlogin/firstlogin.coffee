Template.firstlogin.rendered = ->
  unless Meteor.user().firstLogin
    Session.set("firstLoginStep", 1)
    $(".dark-background").fadeIn(300, ->
      $(".first-login-popup").delay(100).fadeIn(300)
    )

Template.firstlogin.events {
  "click #firstlogin .button.next-step": ->
    $(".first-login-popup .content-slider").animate({"left":"-=400px"}, 300, "easeInOutBack")
    Session.set("firstLoginStep", Session.get("firstLoginStep") + 1)

  "click #firstlogin .button.prev-step": ->
    $(".first-login-popup .content-slider").animate({"left":"+=400px"}, 300, "easeInOutBack")
    Session.set("firstLoginStep", Session.get("firstLoginStep") - 1)

  "click #firstlogin .button.done": ->
    # Mark users first login as done
    $(".popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
      $(".popup input").val("")
      $(".popup input").blur()
    )

  "click #firstlogin .package": (evt) ->
    $(".first-login-popup .package").removeClass("slcd")
    $(evt.currentTarget).addClass("slcd")

  "keypress #firstlogin form#create-first-group #members": (evt) ->
    name = $(".first-login-popup form#create-first-group #name").val()
    if evt.which == 13
      if /\S/.test(name)
        $(".first-login-popup form#create-first-group").submit()
      return false

  "submit #firstlogin form#create-first-group": ->
    name = $("form#create-first-group #name").val()
    emails = $("form#create-first-group #members").val().replace(" ", "").trim().split(",")
    Meteor.call("createGroup", name, emails, (error, result) ->
      Meteor.call("setCurrentGroup", result)
    )
    $("form#create-first-group #name").val("")
    $("form#create-first-group #members").val("")
    alert("Gruppe #{name} wurde erstellt.")
    $(".first-login-popup .button.next-step").click()
    return false
}

Template.firstlogin.helpers {
  "firstLoginStep": ->
    return Session.get("firstLoginStep")
}