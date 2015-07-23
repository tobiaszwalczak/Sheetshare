@Users = Meteor.users

Users.helpers {
  "other": ->
    return true unless Meteor.userId() == this._id
}

Meteor.methods {
  "updateIsTyping": (isTyping) ->
    Users.update(Meteor.user(), {$set: {isTyping: isTyping}})
}
