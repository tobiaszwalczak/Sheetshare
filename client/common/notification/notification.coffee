Template.notification.events {

  "click #notification .dismiss-button": ->
    clearTimeout(NotificationTimeout)
    $("#notification").removeClass("showing")
    setTimeout(->
      $("#notification").removeClass("success error info")
      $("#notification .content").html("")
    , 300)
}
