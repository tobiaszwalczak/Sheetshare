Template.landing.events {
  "click .top-menu .symbol": ->
    $("html, body").animate({ scrollTop: 0 }, 300)

  "click .top-menu .login-button, click header .or-login a": ->
    $(".dark-background").fadeIn(300, ->
      $(".login-popup").delay(100).fadeIn(300, ->
        $(".login-popup #email").focus()
      )
    )

  "submit #login-form": ->
    email = $("#login-form #email").val()
    password = $("#login-form #password").val()

    Meteor.loginWithPassword(email, password)
    return false

  "click .join-button": ->
    $(".dark-background").fadeIn(300, ->
      $(".join-popup").delay(100).fadeIn(300, ->
        $(".join-popup #name").focus()
      )
    )

  "click .dark-background, click .popup-close": ->
    $(".popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
      $(".popup input").blur()
    )

  "submit #signup-form": ->
    name = $("#signup-form #name").val()
    email = $("#signup-form #email").val()
    password = $("#signup-form #password").val()

    options = {
      email: email
      password: password
      profile: {
        name: name
        email: email
        image: "http://api.adorable.io/avatars/256/" + email
      }
    }

    Accounts.createUser(options)
    return false


  "click .login-button.facebook": ->
    Meteor.loginWithFacebook()
    $(".join-popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
    )
}
