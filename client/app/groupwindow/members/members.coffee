Template.members.helpers {

  members: ->
    return Meteor.user().currentGroup().members()

  knownUsersExist: ->
    return true if Users.findOne({_id: {$nin: memberIds = Meteor.user().currentGroup().memberIds}})

  knownUsers: ->
    return Users.find({_id: {$nin: Meteor.user().currentGroup().memberIds}})

}



Template.members.events {

  "click section.members .add-member-button": (evt) ->
    if Users.findOne({_id: {$nin: Meteor.user().currentGroup().memberIds}})
      $(evt.target).addClass("adding expanded")
    else
      $(evt.target).addClass("adding")
    $("section.members .add-member-button input").focus()

  "blur section.members .add-member-button input": (evt) ->
    $(".add-member-button").removeClass("adding expanded")
    $(evt.target).val("")

  "submit section.members form#add-member-form": ->
    email = $("section.members form#add-member-form input").val().trim()
    group = Meteor.user().currentGroup()
    emailsInGroup = group.members().map (obj) -> obj.profile.email
    if email != ""
      if email in emailsInGroup
        Notify("error", "<b>#{email}</b> ist bereits in dieser Gruppe.")
      else
        Meteor.call("sendInvitation", [email], group._id, group.name)
        Notify("success", "<b>#{email}</b> wurde zur Gruppe <b>#{group.name}</b> eingeladen.")
    $("section.members form#add-member-form input").val("")
    return false

  "click section.members .add-member-button .known-users .user": (evt) ->
    userId = $(evt.currentTarget).data("id")
    profile = Users.findOne(userId).profile
    group = Meteor.user().currentGroup()
    Meteor.call("sendInvitation", [profile.email], group._id, group.name)
    Notify("success", "<b>#{profile.name}</b> wurde zur Gruppe <b>#{group.name}</b> eingeladen.")

}
