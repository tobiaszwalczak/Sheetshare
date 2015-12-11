@Messages = new Mongo.Collection("messages")

Messages.helpers {
  "creator": ->
    return Users.findOne(this.creatorId)

  "image": ->
    return Images.findOne(this.id)

  "other": ->
    return true unless Meteor.userId() == this.creatorId

  "moment": ->
    moment(this.createdAt).format("HH:mm:SS | DD.MM.YYYY")

  "justEmojis": ->
    text = this.text
    regexp = new RegExp(":" + Emojis.all().join(":|:") + ":","g")
    if text.replace(regexp, "") == ""
      return true
    else
      return false

  "typeText": ->
    return true if this.type == "text"

  "typeImage": ->
    return true if this.type == "image"

  "typeLatex": ->
    return true if this.type == "latex"

}

Meteor.methods {
  "createMessage": (text, type, id) ->
    if Meteor.user()
      Messages.insert {
        creatorId: Meteor.userId()
        text: text
        type: type
        id: id
        createdAt: new Date()
      }
}
