Template.menubar.events({
  "click #menubar .button"(event) {
    const anythingElse = $(".anything-else");
    const target = $(event.currentTarget);
    const targetMenu = $("#menus " + target.data("menu"));

    if (!anythingElse.hasClass("slcd") && !target.hasClass("slcd")) {
      anythingElse.addClass("slcd");
      target.addClass("slcd");
      targetMenu.addClass("slcd");
    } else if (anythingElse.hasClass("slcd") && !target.hasClass("slcd")) {
      $("#menus .menu, .top-menu .button").removeClass("slcd");
      target.addClass("slcd");
      targetMenu.addClass("slcd");
    } else {
      anythingElse.removeClass("slcd");
      target.removeClass("slcd");
      targetMenu.removeClass("slcd");
    }
  }
});
