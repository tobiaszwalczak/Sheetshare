@Users = Meteor.users

Users.helpers {
  "other": ->
    return true unless Meteor.userId() == this._id
}

Meteor.methods {
  "updateIsTyping": (isTyping) ->
    Users.update(Meteor.userId(), {$set: {isTyping: isTyping}})

  "setCurrentGroupTab": (name) ->
    Users.update(Meteor.userId(), {$set: {group: {tab: name}}})
}
