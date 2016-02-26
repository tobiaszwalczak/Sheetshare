@Tasks = new Mongo.Collection("tasks")

Tasks.helpers {
  "creator": ->
    Users.findOne(this.creatorId).profile.name

  "moment": ->
    moment(this.createdAt).format("HH:mm · DD.MM.YYYY")

  "doneStatus": ->
    if this.doneAt
      return moment(this.doneAt).format("HH:mm · DD.MM.YYYY")
    else
      return false
}

Meteor.methods {
  "createTask": (content) ->
    Tasks.insert {
      creatorId: Meteor.userId()
      groupId: Meteor.user().group.current
      content: content
      done: false
      doneAt: false
      createdAt: new Date()
    }

  "checkTask": (id, done) ->
    if done
      Tasks.update(id, {$set: {done: done, doneAt: new Date()}})
    else
      Tasks.update(id, {$set: {done: done, doneAt: false}})

  "deleteTask": (id) ->
    Tasks.remove(id)
}
