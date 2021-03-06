Template.checklist.onRendered(() => {
  Tracker.autorun(() => {
    Meteor.subscribe("tasks", Meteor.user().group.current);
  });
});

Template.checklist.helpers({
  notDoneTasks() {
    return Tasks.find({done: false}, {sort: {createdAt: -1}});
  },
  doneTasks() {
    return Tasks.find({done: true}, {sort: {doneAt: -1}});
  },
  tasksExist() {
    if (Tasks.findOne()) return true ;
  },
  doneTasksExist() {
    if (Tasks.findOne({done: true})) return true ;
  }
});

Template.checklist.events({
  "submit section.checklist #add-task-form"() {
    const content = $("section.checklist form#add-task-form input#todo").val();
    $("section.checklist form#add-task-form input#todo").val("");
    if (/\S/.test(content)) Meteor.call("createTask", content);
    return false;
  },
  "change section.checklist .tasks .task input.check"(event) {
    const target = $(event.currentTarget);
    const id = target.attr("id");
    if (target.prop("checked")) {
      target.parent(".task").hide();
      Meteor.call("checkTask", id, true);
    } else {
      Meteor.call("checkTask", id ,false);
    }
  },
  "click section.checklist .tasks .task .actions .action.info"(event) {
    const id = $(event.currentTarget).parent(".actions").data("id");
    $(".task").not(`.task[data-id='${id}']`).removeClass("showingInfobox");
    $(".task .infobox").not(`.task[data-id='${id}']`).removeClass("showing");
    $(`.task[data-id='${id}']`).toggleClass("showingInfobox");
    $(`.task[data-id='${id}'] .infobox`).toggleClass("showing");
  },
  "click section.checklist .tasks .task .actions .action.delete"(event) {
    const id = $(event.currentTarget).parent(".actions").data("id");
    Meteor.call("deleteTask", id);
  }
});
