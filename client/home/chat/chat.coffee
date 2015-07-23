Meteor.subscribe("messages")
Meteor.subscribe("users")

Template.chat.rendered = ->
  UserStatus.startMonitor({threshold: 30000, interval: 1000, idleOnBlur: true})
  $("textarea").autosize()
  $("section.chat").animate({scrollTop: $("section.chat")[0].scrollHeight}, 100)
  Meteor.call("updateIsTyping", false)
  UserStatus.events.on("connectionLogout", -> Meteor.call("updateIsTyping", false))


Template.chat.helpers {
  "onlineStatusIndicator": (creator) ->
    if creator.status.online
      if creator.status.idle
        return "idle"
      else
        return "online"
    else
      return "offline"

  "onlineStatusName": (creator) ->
    if creator.status.online
      if creator.status.idle
        return "Abwesend"
      else
        return "Online"
    else
      return "Offline"

  "Users": ->
    return Users.find()

  "Messages": ->
    return Messages.find({}, {sort: {createdAt: 1}})

  "emojis": ->
    return Emojis
}

Template.chat.events {
  "keypress #chat-textarea": (evt) ->
    if evt.which == 13
      text = $("#chat-textarea").val()
      if /\S/.test(text)
        Meteor.call("createMessage", text)
      $("section.chat").animate({scrollTop: $("section.chat")[0].scrollHeight}, 100)
      $("#chat-textarea").val("")
      $("#chat-textarea").trigger("autosize.resize")
      return false

  "keyup #chat-textarea": ->
    value = $("#chat-textarea").val()
    if /\S/.test(value) && !Meteor.user().isTyping
      Meteor.call("updateIsTyping", true)
    else if !/\S/.test(value) && Meteor.user().isTyping
      Meteor.call("updateIsTyping", false)

  "click .emoji-button": ->
    $(".emoji-window").show()
    $(".emoji-close-button").fadeIn(100)
    $(".emoji-window").animate({"right":"0px"}, 600, "easeInOutQuart")

  "click .emoji-close-button": ->
    $(".emoji-window").animate({"right":"-256px"}, 600, "easeInOutQuart", ->
      $(".emoji-window").hide()
      $(".emoji-close-button").fadeOut(100)
    )
    $("#chat-textarea").focus()

  "click .emoji-window .emoji-tag": (evt) ->
    tag = ":" + $(evt.currentTarget).attr("title") + ":"
    $(".emoji-window").animate({"right":"-256px"}, 600, "easeInOutQuart", ->
      $(".emoji-window").hide()
      $(".emoji-close-button").fadeOut(100)
    )
    insertAtCursor("chat-textarea", tag)
    $("#chat-textarea").focus()
    $("#chat-textarea").trigger("autosize.resize")
}

insertAtCursor = (id, value) ->
  field = document.getElementById("chat-textarea")
  if document.selection
    field.focus()
    sel = document.selection.createRange()
    sel.text = value
  else if field.selectionStart || field.selectionStart == "0"
    startPos = field.selectionStart
    endPos = field.selectionEnd
    field.value = field.value.substring(0, startPos) + value + field.value.substring(endPos, field.value.length)
    field.selectionStart = field.selectionEnd = startPos + value.length
  else
    field.value += value
