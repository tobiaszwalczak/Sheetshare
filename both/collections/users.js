Users = Meteor.users;

Users.helpers({
  firstName() {
    return this.profile.name.split(" ")[0];
  },
  other() {
    if (Meteor.userId() != this._id) return true;
  },
  currentGroup() {
    return Groups.findOne(this.group.current);
  },
  currentGroupAdmin() {
    var creatorId = Meteor.user().currentGroup().creatorId;
    if (this._id == creatorId) return true;
  }
});

Meteor.methods({
  updateIsTyping(isTyping) {
    Users.update(Meteor.userId(), {$set: {isTyping: isTyping}});
  },
  setCurrentGroup(groupId) {
    Users.update(Meteor.userId(), {$set: {"group.current": groupId}});
  },
  setCurrentGroupTab(name) {
    Users.update(Meteor.userId(), {$set: {"group.tab": name}});
  },
  addKnownEmail(userId, email) {
    Users.update(userId, {$addToSet: {knownEmails: email}})
  }
});
