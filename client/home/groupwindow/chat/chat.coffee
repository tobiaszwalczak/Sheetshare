Meteor.subscribe("messages")
Meteor.subscribe("users")

Template.chat.rendered = ->
  UserStatus.startMonitor({threshold: 30000, interval: 1000, idleOnBlur: true})
  $("section.chat textarea").autosize()
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
  "keypress section.chat #chat-textarea": (evt) ->
    if evt.which == 13
      text = $("#chat-textarea").val()
      if /\S/.test(text)
        Meteor.call("createMessage", text)
      $("section.chat").animate({scrollTop: $("section.chat")[0].scrollHeight}, 100)
      $("section.chat #chat-textarea").val("")
      $("section.chat #chat-textarea").trigger("autosize.resize")
      return false

  "keyup section.chat #chat-textarea": ->
    value = $("section.chat #chat-textarea").val()
    if /\S/.test(value) && !Meteor.user().isTyping
      Meteor.call("updateIsTyping", true)
    else if !/\S/.test(value) && Meteor.user().isTyping
      Meteor.call("updateIsTyping", false)

  "click section.chat .emoji-button": ->
    unless $("section.chat .emoji-button").hasClass("close-emoji-button")
      $("section.chat .emoji-window").addClass("showing")
      $("section.chat .emoji-button").attr({"title":"Schließen"})
      $("section.chat .emoji-button").html(Blaze.toHTMLWithData(Template.entypo, "circle-with-cross"))
    else
      $("section.chat .emoji-window").removeClass("showing")
      $("section.chat .emoji-button").attr({"title":"Emojis"})
      $("section.chat .emoji-button").html(Blaze.toHTMLWithData(Template.entypo, "emoji-flirt"))


    $("section.chat .emoji-button").toggleClass("close-emoji-button")

  "focus section.chat #chat-textarea": ->
    if $("section.chat .emoji-button").hasClass("close-emoji-button")
      $(".emoji-window").removeClass("showing")
      $("section.chat .emoji-button").removeClass("close-emoji-button")

  "click section.chat .emoji-window .emoji-tag": (evt) ->
    tag = ":" + $(evt.currentTarget).attr("title") + ":"
    $("section.chat .emoji-window").removeClass("showing")
    $("section.chat .emoji-button").removeClass("close-emoji-button")
    insertAtCursor("chat-textarea", tag)
    $("section.chat #chat-textarea").focus()
    $("section.chat #chat-textarea").trigger("autosize.resize")
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
