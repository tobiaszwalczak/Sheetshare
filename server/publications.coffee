Meteor.publish("messages", ->
  return Messages.find()
)

Meteor.publish("users", ->
  return Users.find()
)

Meteor.publish("userData", ->
  if this.userId
    return Users.find({_id: this.userId})
  else
    this.ready()
)

Meteor.publish("tasks", ->
  if this.userId
    return Tasks.find({})
  else
    this.ready()
)
