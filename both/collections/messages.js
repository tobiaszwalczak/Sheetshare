Messages = new Mongo.Collection("messages");

Messages.helpers({
  creator() {
    return Users.findOne(this.creatorId);
  },
  image() {
    return Images.findOne(this.id);
  },
  other() {
    if (Meteor.userId() !== this.creatorId) return true;
  },
  moment() {
    return moment(this.createdAt).format("HH:mm:SS | DD.MM.YYYY");
  },
  justEmojis() {
    const text = this.text;
    const allEmojis = Emojis.all().join(":|:");
    const regexp = new RegExp(`:${allEmojis}:`,"g");
    if (text.replace(regexp, "") === "")
      return true;
    else
      return false;
  },
  typeText() {
    if (this.type === "text") return true;
  },
  typeImage() {
    if (this.type === "image") return true;
  },
  typeLatex() {
    if (this.type === "latex") return true;
  }
});

Meteor.methods({
  createMessage(text, type, id) {
    if (Meteor.user()) {
      Messages.insert({
        creatorId: Meteor.userId(),
        groupId: Meteor.user().group.current,
        text,
        type,
        id,
        createdAt: new Date()
      });
    }
  }
});
