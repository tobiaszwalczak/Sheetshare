@Groups = new Mongo.Collection("groups")

Groups.helpers {
  "creator": ->
    return Users.findOne(this.creatorId)

  "membercount": ->
    return this.emails.length + 1

  "sheetcount": ->
    return this.emails.length

  "moment": ->
    return moment(this.createdAt).format("HH:mm:SS | DD.MM.YYYY")
}

Meteor.methods {
  "createGroup": (name, emails) ->
    if Meteor.user()
      Groups.insert {
        name: name
        creatorId: Meteor.userId()
        emails: emails
        createdAt: new Date()
      }

  "addUserToGroup": (id, userId) ->
    if Meteor.user()
      return true
}
