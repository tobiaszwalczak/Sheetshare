@Groups = new Mongo.Collection("groups")

Groups.helpers {
  "creator": ->
    return Users.findOne(this.creatorId)

  "members": ->
    return Users.find({_id: {$in: this.memberIds}})

  "membercount": ->
    return this.members().count()

  "sheetcount": ->
    return 0

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
      Meteor.call("sendInvitation", emails, newGroupId, name)
      return newGroupId

  "addUserToGroup": (userId, groupId) ->
    if Meteor.userId()
      group = Groups.findOne(groupId)
      memberEmails = group.members().map (obj) -> obj.profile.email
      userEmail = Users.findOne(userId).profile.email
      Users.update(userId, {$addToSet: {knownEmails: {$each: memberEmails}}})
      # BUG !!! 
      Users.update({_id: {$in: group.memberIds}}, {$addToSet: {knownEmails: userEmail}})
      Groups.update(groupId, {$addToSet: {memberIds: userId}})

  "removeUserFromGroup": (userId, groupId) ->
    if Meteor.userId()
      Groups.update(groupId, {$pull: {memberIds: userId}})
      user = Users.findOne(userId)
      if user.group.current == groupId
        Users.update(userId, {$set: {"group.current": ""}})
}
