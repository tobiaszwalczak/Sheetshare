@Notify = (type, message) ->
  $("#notification .content").html(message)
  $("#notification").addClass("showing "+ type)
  @NotificationTimeout = setTimeout(->
    $("#notification").removeClass("showing")
    setTimeout(->
      $("#notification").removeClass("success error info")
      $("#notification .content").html("")
    , 300)
  , 4000)
