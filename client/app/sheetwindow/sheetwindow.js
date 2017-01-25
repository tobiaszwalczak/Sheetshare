Template.sheetwindow.onRendered(() => {
  Tracker.autorun(() => {
    Meteor.subscribe("homeworks", Meteor.user().group.current);
  });
  $("#homeworkStartDateInput, #homeworkEndDateInput").dateDropper();
});

Template.sheetwindow.helpers({
  userId() {
    return Meteor.userId();
  }
});

Template.sheetwindow.events({
  "click #sheetwindow .new-sheet .close-button"() {
    $("#sheetwindow .new-sheet").removeClass("showing");
  },
  "click #sheetwindow .sheetmodal.new-homework .close-button"() {
    $("#sheetwindow .sheetmodal.new-homework").removeClass("showing");
    $("#sheetwindow .sheetmodal.new-homework input").val("");
  },
  "click #sheetwindow .new-sheet .upload-button"() {
    $("#sheetwindow .new-sheet input").click();
  },
  "click #sheetwindow .toolcircle-menu .toolcircle"(event) {
    $(event.target).toggleClass("close");
    $("#sheetwindow .toolcircle-menu .options").toggleClass("showing");
    if ($(event.target).hasClass("close")) $(event.target).attr({title: "Aktionen verbergen"});
    else $(event.target).attr({title: "Aktionen"});
  },
  "click #sheetwindow .toolcircle-menu .options .option.new-image"() {
    $("#sheetwindow .toolcircle-menu .toolcircle.close").click();
    $("#sheetwindow .sheetmodal").removeClass("showing");
    $("#sheetwindow .sheetmodal.new-homework input").val("");
    $("#sheetwindow .sheetmodal.new-sheet").addClass("showing");
  },
  "click #sheetwindow .toolcircle-menu .options .option.new-homework"() {
    $("#sheetwindow .toolcircle-menu .toolcircle.close").click();
    $("#sheetwindow .sheetmodal").removeClass("showing");
    $("#sheetwindow .sheetmodal.new-homework").addClass("showing");
  },
  "click #sheetwindow .toolcircle-menu .options .option.new-page"() {
    $("#sheetwindow .toolcircle-menu .toolcircle.close").click();
    $("#sheetwindow .sheetmodal").removeClass("showing");
    $("#sheetwindow .sheetmodal.new-homework input").val("");
    $("#sheetwindow .sheetmodal.new-page").addClass("showing");
  },
  "submit #newHomeworkForm"(event) {
    const startDate = new Date($("#homeworkStartDateInput").val().split(".").reverse().join("-"));
    const endDate = new Date($("#homeworkEndDateInput").val().split(".").reverse().join("-"));
    const name = $("#homeworkNameInput").val() || "Aufgabe vom "+ $("#homeworkStartDateInput").val();
    const group = Meteor.user().currentGroup();

    if ($("#homeworkStartDateInput").val() && $("#homeworkEndDateInput").val()) {
      Meteor.call("createHomework", name, group._id, startDate, endDate);
      Notify("success", `Hausaufgabe <b>${name}</b> wurde erflogreich in der Gruppe <b>${group.name}</b> erstellt.`);
      $("#sheetwindow .sheetmodal.new-homework .close-button").click();
    } else {
      Notify("error", "Fülle bitte wenigstens den <b>Beginn</b> und die <b>Deadline</b> aus.");
    }

    return false;
  }
});
