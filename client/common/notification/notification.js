Template.notification.events({
  "click #notification .dismiss-button"() {
    Meteor.clearTimeout(NotificationTimeout);
    $("#notification").removeClass("showing");
    Meteor.setTimeout(() => {
      $("#notification").removeClass("success error info");
      $("#notification .content").html("");
    }, 300);
  }
});
