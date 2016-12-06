Template.groupwindow.onRendered(() => {
  let groupTab = Meteor.user().group.tab || "chat";
  setTimeout(() => {
    $(".group-window .sections section, .group-window .group-header .group-menu .button")
      .removeClass("slcd");
    $(`.group-window .sections section.${groupTab}, .group-window .group-header .group-menu .button#${groupTab}`)
      .addClass("slcd");
  }, 500);
});

Template.groupwindow.helpers({
  group() {
    return Groups.findOne(Meteor.user().group.current);
  }
});

Template.groupwindow.events({
  "click .group-window .group-header .group-toggle"(event) {
    $(".group-window").toggleClass("hidden");
    $("#sheetwindow").toggleClass("expanded");
    if ($(event.target).attr("title") == "Ausblenden")
      $(event.target).attr("title", "Einblenden");
    else
      $(event.target).attr("title", "Ausblenden");
  },
  "click .group-window .group-header .group-menu .button"(event) {
    const id = $(event.target).attr("id");
    $(".group-window .sections section, .group-window .group-header .group-menu .button")
      .removeClass("slcd");
    $(`.group-window .group-header .group-menu .button#${id}, .group-window .sections section.${id}`)
      .addClass("slcd");
    Meteor.call("setCurrentGroupTab", name);
  },
  "click .group-window .empty .cta"(event) {
    $("#menubar .new-group-button").delay(500).click();
  }
});
