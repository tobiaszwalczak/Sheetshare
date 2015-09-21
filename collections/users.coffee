@Users = Meteor.users

Users.helpers {
  "other": ->
    return true unless Meteor.userId() == this._id
}

Meteor.methods {
  "registerUser": (name, email, password) ->
    options = {
      email: email
      password: password
      profile: {
        name: name
        email: email
        image: "http://api.adorable.io/avatars/256/" + email
      }
      group: {
        tab: "chat"
      }
    }
    Accounts.createUser(options)


  "updateIsTyping": (isTyping) ->
    Users.update(Meteor.userId(), {$set: {isTyping: isTyping}})

  "setCurrentGroupTab": (name) ->
    Users.update(Meteor.userId(), {$set: {group: {tab: name}}})
}
