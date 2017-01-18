Template.members.helpers({
  isAdmin() {
    if (Meteor.userId() == Meteor.user().currentGroup().creatorId) return true;
  },
  members() {
    return Meteor.user().currentGroup().members();
  },
  knownUsersExist() {
    if (Users.findOne({_id: {$nin: memberIds = Meteor.user().currentGroup().memberIds}})) return true;
  },
  knownUsers() {
    return Users.find({_id: {$nin: Meteor.user().currentGroup().memberIds}});
  },
});

Template.members.events({
  "click section.members .add-member-button"(event) {
    if (Users.findOne({_id: {$nin: Meteor.user().currentGroup().memberIds}}))
      $(event.target).addClass("adding expanded");
    else
      $(event.target).addClass("adding");
    $("section.members .add-member-button input").focus();
  },
  "blur section.members .add-member-button input"(event) {
    $(".add-member-button").removeClass("adding expanded");
    $(event.target).val("");
  },
  "submit section.members form#add-member-form"() {
    const email = $("section.members form#add-member-form input").val().trim();
    const group = Meteor.user().currentGroup();
    const emailsInGroup = group.members().map(obj => { return obj.profile.email });
    if (email != "") {
      if (email in emailsInGroup) {
        Notify("error", `<b>${email}</b> ist bereits in dieser Gruppe.`);
      } else {
        Meteor.call("sendInvitation", [email], group._id, group.name);
        Notify("success", `<b>${email}</b> wurde zur Gruppe <b>${group.name}</b> eingeladen.`);
      }
    }
    $("section.members form#add-member-form input").val("");
    return false;
  },
  "click section.members .add-member-button .known-users .user"(event) {
    const userId = $(event.currentTarget).data("id");
    const profile = Users.findOne(userId).profile;
    const group = Meteor.user().currentGroup();
    Meteor.call("sendInvitation", [profile.email], group._id, group.name);
    Notify("success", `<b>${profile.name}</b> wurde zur Gruppe <b>${group.name}</b> eingeladen.`);
  },
  "click section.members .remove-member-button"(event) {
    const userId = $(event.currentTarget).data("id");
    const name = Users.findOne(userId).profile.name;
    const groupId = Meteor.user().currentGroup()._id;
    Meteor.call("removeUserFromGroup", userId, groupId);
    Notify("success", `<b>${name}</b> wurde erfolgreich aus dieser Gruppe entfernt.`);
  }
});
