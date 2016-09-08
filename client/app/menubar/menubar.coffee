Template.menubar.events {
  "click #menubar .group-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .group-button").hasClass("slcd")
      $(".top-menu .group-button, #menus .groupmenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .group-button").hasClass("slcd")
      $("#menus .menu, .top-menu .button").removeClass("slcd")
      $(".top-menu .group-button, #menus .groupmenu").addClass("slcd")
    else
      $(".top-menu .group-button, #menus .groupmenu, .anything-else").removeClass("slcd")

  "click #menubar .new-group-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .new-group-button").hasClass("slcd")
      $(".top-menu .new-group-button, #menus .newgroupmenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .new-group-button").hasClass("slcd")
      $("#menus .menu, .top-menu .button").removeClass("slcd")
      $(".top-menu .new-group-button, #menus .newgroupmenu").addClass("slcd")
    else
      $(".top-menu .new-group-button, #menus .newgroupmenu, .anything-else").removeClass("slcd")

  "click #menubar .notification-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .notification-button").hasClass("slcd")
      $(".top-menu .notification-button, #menus .notificationmenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .notification-button").hasClass("slcd")
      $("#menus .menu, .top-menu .button").removeClass("slcd")
      $(".top-menu .notification-button, #menus .notificationmenu").addClass("slcd")
    else
      $(".top-menu .notification-button, #menus .notificationmenu, .anything-else").removeClass("slcd")

  "click #menubar .profile-button": ->
    if !$(".anything-else").hasClass("slcd") && !$(".top-menu .profile-button").hasClass("slcd")
      $(".top-menu .profile-button, #menus .profilemenu, .anything-else").addClass("slcd")
    else if $(".anything-else").hasClass("slcd") && !$(".top-menu .profile-button").hasClass("slcd")
      $("#menus .menu, .top-menu .button").removeClass("slcd")
      $(".top-menu .profile-button, #menus .profilemenu").addClass("slcd")
    else
      $(".top-menu .profile-button, #menus .profilemenu, .anything-else").removeClass("slcd")

}
