NotificationTimeout = null;
Notify = function(type, message) {
  $("#notification .content").html(message)
  $("#notification").addClass("showing "+ type)
  NotificationTimeout = Meteor.setTimeout(() => {
    $("#notification").removeClass("showing");
    Meteor.setTimeout(() => {
      $("#notification").removeClass("success error info");
      $("#notification .content").html("");
    }, 300);
  }, 4000);
};
