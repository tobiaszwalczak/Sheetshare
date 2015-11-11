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

  "users": ->
    return Users.find()

  "messages": ->
    return Messages.find({}, {sort: {createdAt: 1}})

  "emojis": ->
    return Emojis
}

Template.chat.events {
  "keypress section.chat #chat-textarea": (evt) ->
    if evt.which == 13
      text = $("section.chat #chat-textarea").val()
      if /\S/.test(text)
        Meteor.call("createMessage", text, "text")
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

  "click section.chat .emojis-button": ->
    $("section.chat .more-button.close").click()

    unless $("section.chat .emojis-button").hasClass("close")
      $("section.chat .emojis-widget").addClass("showing")
      $("section.chat .emojis-button").attr({"title":"Schließen"})
      Meteor.setTimeout( ->
        $("section.chat .emojis-button").html(Blaze.toHTMLWithData(Template.entypo, "cross"))
      , 300)
    else
      $("section.chat .emojis-widget").removeClass("showing")
      $("section.chat .emojis-button").attr({"title":"Emojis"})
      Meteor.setTimeout( ->
        $("section.chat .emojis-button").html(Blaze.toHTMLWithData(Template.entypo, "emoji-flirt"))
      , 300)

    $("section.chat .emojis-button").toggleClass("close")

  "click section.chat .more-button": ->
    $("section.chat .emojis-button.close").click()

    unless $("section.chat .more-button").hasClass("close")
      $("section.chat .more-widget").addClass("showing")
      $("section.chat .more-button").attr({"title":"Schließen"})
      Meteor.setTimeout( ->
        $("section.chat .more-button").html(Blaze.toHTMLWithData(Template.entypo, "cross"))
      , 300)
    else
      $("section.chat .more-widget").removeClass("showing")
      $("section.chat .more-button").attr({"title":"Mehr"})
      Meteor.setTimeout( ->
        $("section.chat .more-button").html(Blaze.toHTMLWithData(Template.entypo, "dots-three-horizontal"))
      , 300)
      $("section.chat .latex-widget").removeClass("showing")
      Meteor.setTimeout( ->
        $("section.chat .latex-widget #latex-textarea").val("")
        $("section.chat .latex-widget .latex-output").text("")
      , 600)

    $("section.chat .more-button").toggleClass("close")

  "click section.chat .latex-button": ->
    $("section.chat .more-widget").removeClass("showing")
    $("section.chat .latex-widget").addClass("showing")
    Meteor.setTimeout( ->
      $("section.chat .latex-widget #latex-textarea").focus()
    , 600)

  "focus section.chat #chat-textarea": ->
    $("section.chat .widget-button.close").click()

  "click section.chat .emojis-widget .emoji-tag": (evt) ->
    tag = ":" + $(evt.currentTarget).attr("title") + ":"
    $("section.chat .emojis-button.close").click()
    insertAtCursor("chat-textarea", tag)
    $("section.chat #chat-textarea").focus()
    $("section.chat #chat-textarea").trigger("autosize.resize")

  "keyup section.chat .latex-widget #latex-textarea": (evt) ->
    input = $(evt.target).val()
    $("section.chat .latex-widget .latex-output").text(input)
    $(".latex-output").latex()
    if evt.which == 13
      text = $("section.chat .latex-widget #latex-textarea").val()
      if /\S/.test(text)
        Meteor.call("createMessage", text, "latex")
        $("section.chat .more-button.close").click()
      return false

}

insertAtCursor = (id, value) ->
  field = document.getElementById(id)
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
