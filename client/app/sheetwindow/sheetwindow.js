Template.sheetwindow.onRendered(() => {
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
    $("#sheetwindow .sheetmodal.new-page").addClass("showing");
  }
});
