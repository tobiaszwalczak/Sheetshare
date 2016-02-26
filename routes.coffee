Router.map ->
  this.route("landing", {
    path: "/"
    onBeforeAction: (pause) ->
      if !Meteor.user()
        this.render("landing")
      else
        this.subscribe("users")
        this.subscribe("userData")
        this.subscribe("groups")
        this.subscribe("messages", Meteor.user().group.current)
        this.subscribe("images", Meteor.user().group.current)
        this.subscribe("tasks", Meteor.user().group.current)
        this.redirect("/home")
        this.next()
  })

  this.route("home", {
    path: "/home"
    onBeforeAction: (pause) ->
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
        this.render("home")
  })

  this.route("addsheet", {
    path: "/addsheet/:_id"
  })
