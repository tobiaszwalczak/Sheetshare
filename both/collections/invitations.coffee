@Invitations = new Mongo.Collection("invitations")

Invitations.helpers {
  "creator": ->
    Users.findOne(this.creatorId)

  "group": ->
    Groups.findOne(this.groupId)
}

Meteor.methods {
  "sendInvitation": (emails, groupId, groupName) ->
    if Meteor.userId()
      # send email if no user with email
      for email in emails
        if email != Meteor.user().profile.email
          Invitations.insert {
            creatorId: Meteor.userId()
            creatorName: Meteor.user().profile.name
            groupId: groupId
            groupName: groupName
            email: email
            createdAt: new Date()
          }
          Meteor.call("addKnownEmail", Meteor.userId(), email)

  "answerInvitation": (id, accepted) ->
    if Meteor.userId()
      groupId = Invitations.findOne(id).groupId
      if accepted
        Meteor.call("addUserToGroup", Meteor.userId(), groupId)
        Meteor.call("setCurrentGroup", groupId)
      else
        #Add declined action
      Invitations.remove(id)

}
