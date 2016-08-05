@Groups = new Mongo.Collection("groups")

Groups.helpers {
  "creator": ->
    return Users.findOne(this.creatorId)

  "members": ->
    return Users.find({_id: {$in: this.memberIds}})

  "membercount": ->
    return this.members().count()

  "sheetcount": ->
    return this.emails.length

  "moment": ->
    return moment(this.createdAt).format("HH:mm:SS | DD.MM.YYYY")
}

Meteor.methods {
  "createGroup": (name, emails) ->
    if Meteor.userId()
      newGroupId = Groups.insert {
        name: name
        creatorId: Meteor.userId()
        memberIds: [Meteor.userId()]
        createdAt: new Date()
      }
      Meteor.call("sendInvitation", emails, newGroupId)
      return newGroupId

  "addUserToGroup": (userId, groupId) ->
    if Meteor.userId()
      Groups.update(groupId, {$push: {memberIds: userId}})
}
