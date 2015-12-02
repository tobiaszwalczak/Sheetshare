Router.map ->
  this.route("landing", {
    path: "/"
    onBeforeAction: (pause) ->
      if !Meteor.user()
        this.render("landing")
      else
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
        this.render("home")
  })

  this.route("addsheet", {
    path: "/addsheet/:_id"
  })
