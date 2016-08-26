@Users = Meteor.users

Users.helpers {
  "firstName": ->
    this.profile.name.split(" ")[0]

  "other": ->
    true unless Meteor.userId() == this._id

  "currentGroup": ->
    Groups.findOne(this.group.current)

  "currentGroupAdmin": ->
    group = Meteor.user().currentGroup()
    true if this._id == group.creatorId
}

Meteor.methods {
  "updateIsTyping": (isTyping) ->
    Users.update(Meteor.userId(), {$set: {isTyping: isTyping}})

  "setCurrentGroup": (groupId) ->
    Users.update(Meteor.userId(), {$set: {"group.current": groupId}})

  "setCurrentGroupTab": (name) ->
    Users.update(Meteor.userId(), {$set: {"group.tab": name}})

  "addKnownEmail": (userId, email) ->
    Users.update(userId, {$addToSet: {knownEmails: email}})
}
