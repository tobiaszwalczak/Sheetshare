Template.popups.events {
  "click .dark-background": ->
    $(".popup").fadeOut(300, ->
      $(".dark-background").delay(200).fadeOut(300)
      $(".popup input").val("")
      $(".popup input").blur()
    )
}
