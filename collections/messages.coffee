@Messages = new Mongo.Collection("messages")

Messages.helpers {
  "creator": ->
    return Users.findOne(this.creatorId)

  "other": ->
    return true unless Meteor.userId() == this.creatorId

  "moment": ->
    moment(this.createdAt).format("HH:MM:SS | DD.MM.YYYY")
}

Meteor.methods {
  "createMessage": (text) ->
    if Meteor.user()
      Messages.insert {
        creatorId: Meteor.userId()
        text: text
        createdAt: new Date()
      }
}
