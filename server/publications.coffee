Meteor.publish("users", (emails) ->
  emails = emails || []
  # return Users.find({"profile.email": {$in: emails}})
  return Users.find()
)

Meteor.publish("userData", ->
  if this.userId
    return Users.find({_id: this.userId})
  else
    this.ready()
)

Meteor.publish("invitations", (email) ->
  return Invitations.find({email: email})
)

Meteor.publish("groups", ->
  return Groups.find({memberIds: this.userId})
)

Meteor.publish("messages", (groupId) ->
  return Messages.find({groupId: groupId})
)

Meteor.publish("images", (groupId) ->
  return Images.find({groupId: groupId})
)

Meteor.publish("tasks", (groupId) ->
  return Tasks.find({groupId: groupId})
)
