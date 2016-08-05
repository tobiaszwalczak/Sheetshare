@Invitations = new Mongo.Collection("invitations")

Invitations.helpers {
  "creator": ->
    Users.findOne(this.creatorId)

  "group": ->
    Groups.findOne(this.groupId)
}

Meteor.methods {
  "sendInvitation": (emails, groupId) ->
    if Meteor.userId()
      # send email if no user with email
      for email in emails
        Invitations.insert {
          creatorId: Meteor.userId()
          groupId: groupId
          email: email
          createdAt: new Date()
        }

  "answerInvitation": (id, accepted) ->
    if Meteor.userId()
      groupId = Invitations.findOne(id).groupId
      if accepted
        Meteor.call("addUserToGroup", Meteor.userId(), groupId)
      else
        #Add declined action
      Invitations.remove(id)

}
