Meteor.subscribe("users")
Meteor.subscribe("userData")

Template.home.events {
  "click #create-group-form .add-user": ->
    $("#create-group-form .add-user").fadeOut(300, ->
      $("#create-group-form input#email").fadeIn(300)
      $("#create-group-form input#email").focus()
    )

  "blur #create-group-form input#email": ->
    $("#create-group-form input#email").fadeOut(300, ->
      $("#create-group-form .add-user").fadeIn(300)
      $("#create-group-form input#email").val("")
    )

  "click .dark-background": ->
    $(".popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
      $(".popup input").val("")
      $(".popup input").blur()
    )
}
