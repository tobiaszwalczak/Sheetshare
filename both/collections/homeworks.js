Homeworks = new Mongo.Collection("homeworks");

Meteor.methods({
  createHomework(name, groupId, startDate, endDate) {
    if (Meteor.userId()) {
      Homeworks.insert({
        name,
        creatorId: Meteor.userId(),
        groupId,
        startDate,
        endDate,
        done: false,
        doneAt: null,
        createdAt: new Date()
      });
    }
  }
});
