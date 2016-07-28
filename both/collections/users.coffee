@Users = Meteor.users

Users.helpers {
  "other": ->
    return true unless Meteor.userId() == this._id

  "currentGroup": ->
    return Groups.findOne(this.group.current)
}

Meteor.methods {
  "updateIsTyping": (isTyping) ->
    Users.update(Meteor.userId(), {$set: {isTyping: isTyping}})

  "setCurrentGroup": (groupId) ->
    Users.update(Meteor.userId(), {$set: {"group.current": groupId}})

  "setCurrentGroupTab": (name) ->
    Users.update(Meteor.userId(), {$set: {"group.tab": name}})
}
