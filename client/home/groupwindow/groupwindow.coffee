Template.groupwindow.rendered = ->
  groupTab = Meteor.user().group.tab
  $(".group-window .sections section").removeClass("slcd")
  $(".group-window .sections section.#{groupTab}").addClass("slcd")
  $(".group-window .group-header .group-menu .button").removeClass("slcd")
  $(".group-window .group-header .group-menu .button##{groupTab}").addClass("slcd")

Template.groupwindow.events {
  "click .group-window .group-header .group-toggle": (evt) ->
    $(".group-window").toggleClass("hidden")
    $("#sheetwindow").toggleClass("expanded")
    if ($(evt.target).attr("title") == "Ausblenden")
      $(evt.target).attr("title", "Einblenden")
    else
      $(evt.target).attr("title", "Ausblenden")

  "click .group-window .group-header .group-menu .button": (evt) ->
    id = $(evt.target).attr("id")
    changeGroupTab(id)
}

changeGroupTab = (name) ->
  $(".group-window .sections section").removeClass("slcd")
  $(".group-window .group-header .group-menu .button").removeClass("slcd")

  Meteor.setTimeout( ->
    $(".group-window .sections section.#{name}").addClass("slcd")
  , 150)
  $(".group-window .group-header .group-menu .button##{name}").addClass("slcd")

  Meteor.call("setCurrentGroupTab", name)

  if name == "chat"
    $(".group-window section.chat").animate({scrollTop: $("section.chat")[0].scrollHeight}, 1)


Template.groupwindow.helpers {
  "group": ->
    return Groups.findOne(Meteor.user().group.current)
}
