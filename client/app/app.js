Template.app.onRendered(() => {
  Tracker.autorun(() => {
    Meteor.subscribe("users", Meteor.user().knownEmails);
    Meteor.subscribe("groups");
  });
});
