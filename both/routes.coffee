Router.map ->
  this.route("landing", {
    path: "/"
    onBeforeAction: () ->
      if !Meteor.user()
        this.render("landing")
      else
        this.subscribe("users")
        this.subscribe("userData")
        this.subscribe("groups")
        this.subscribe("messages", Meteor.user().group.current)
        this.subscribe("images", Meteor.user().group.current)
        this.subscribe("tasks", Meteor.user().group.current)
        this.redirect("/app")
        this.next()
  })

  this.route("app", {
    path: "/app"
    onBeforeAction: () ->
      if !Meteor.user()
        this.redirect("/")
        this.next()
      else
        this.subscribe("users")
        this.subscribe("userData")
        this.subscribe("groups")
        this.subscribe("messages", Meteor.user().group.current)
        this.subscribe("images", Meteor.user().group.current)
        this.subscribe("tasks", Meteor.user().group.current)
        this.render("app")
  })

  this.route("addsheet", {
    path: "/addsheet/:_id"
  })
