Template.members.helpers {

  members: ->
    return Groups.findOne(Meteor.user().group.current).members()

  knownUsers: ->
    memberIds = Groups.findOne(Meteor.user().group.current).memberIds
    return Users.find({_id: {$nin: memberIds}})

}



Template.members.events {

  "click section.members .add-member-button": (evt) ->
    $(evt.target).addClass("adding")
    $("section.members .add-member-button input").focus()

  "blur section.members .add-member-button input": (evt) ->
    $(".add-member-button").removeClass("adding")
    $(evt.target).val("")

  "click section.members .add-member-button .known-users .user": (evt) ->
    userId = $(evt.currentTarget).data("id")
    profile = Users.findOne(userId).profile
    group = Groups.findOne(Meteor.user().group.current)
    Meteor.call("sendInvitation", [profile.email], group._id, group.name)
    Notify("success", "<b>#{profile.name}</b> wurde zur Gruppe <b>#{group.name}</b> eingeladen.")

}
