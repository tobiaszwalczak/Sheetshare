Meteor.publish("users", (emails) => {
  return Users.find({"profile.email": {$in: emails}});
  // return Users.find()
});

Meteor.publish("userData", function() {
  if (this.userId) return Users.find({_id: this.userId});
  else this.ready();
});

Meteor.publish("invitations", (email) => {
  return Invitations.find({email: email});
});

Meteor.publish("groups", function() {
  return Groups.find({memberIds: this.userId});
});

Meteor.publish("homeworks", (groupId) => {
  return Homeworks.find({groupId: groupId});
});

Meteor.publish("messages", (groupId) => {
  return Messages.find({groupId: groupId});
});

Meteor.publish("images", (groupId) => {
  return Images.find({groupId: groupId});
});

Meteor.publish("tasks", (groupId) => {
  return Tasks.find({groupId: groupId});
});
