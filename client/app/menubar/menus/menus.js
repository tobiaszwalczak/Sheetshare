Template.menus.onRendered(() => {
  Tracker.autorun(() => {
    Meteor.subscribe("invitations", Meteor.user().profile.email);
  });
});

Template.menus.events({
  "click #menus .profilemenu .logout"() {
    Router.go("/");
  },
  "mouseup #menus .groupmenu .groupitem"(event) {
    const id = $(event.currentTarget).data("id");
    $(".anything-else").click()
    $(".group-window .sections section").fadeOut(300, () => {
      Meteor.call("setCurrentGroup", id);
      $(".group-window .sections section").delay(200).fadeIn(300);
    });
  },
  "click #menus .notificationmenu .accept"(event) {
    const id = $(event.currentTarget).parents(".invitation").data("id");
    const groupName = $(event.currentTarget).parents(".invitation").data("name");
    Meteor.call("answerInvitation", id, true);
    Notify("success", `Du bist der Gruppe <b>${groupName}</b> erfolgreich beigetreten.`);
  },
  "click #menus .notificationmenu .decline"(event) {
    const id = $(event.currentTarget).parents(".invitation").data("id");
    const groupName = $(event.currentTarget).parents(".invitation").data("name");
    Meteor.call("answerInvitation", id, false);
    Notify("error", `Einladung zur Gruppe <b>${groupName}</b> abgelehnt.`);
  },
  "click .anything-else"() {
    $("#menus .menu, .anything-else, .top-bar .top-menu .button").removeClass("slcd");
  }
});

Template.menus.helpers({
  groups() {
    return Groups.find();
  },
  knownUsers() {
    return Users.find();
  },
  notifications() {
    if (Invitations.findOne()) return true;
    else return false;
  },
  invitations() {
    return Invitations.find();
  },
  actions() {
    return Actions.find();
  }
});
