Meteor.publish("users", ->
  return Users.find()
)

Meteor.publish("userData", ->
  if this.userId
    return Users.find({_id: this.userId})
  else
    this.ready()
)

Meteor.publish("groups", ->
  return Groups.find({})
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
