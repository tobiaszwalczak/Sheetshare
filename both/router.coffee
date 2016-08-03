Router.map ->
  this.route("/", {
    template: "landing"
    cache: true
    loadingTemplate: "loading"
    action: ->
      if Meteor.userId()
        Router.go("/app")
      else
        this.render("landing")
  })

  this.route("/app", {
    template: "app"
    loadingTemplate: "loading"
    fastRender: true
    waitOn: ->
      return [
        Meteor.subscribe("users")
        Meteor.subscribe("userData")
        Meteor.subscribe("groups")
      ]
    action: ->
      if Meteor.userId()
        this.render("app")
      else
        Router.go("/")
  })

  this.route("addsheet", {
    path: "/addsheet/:_id"
  })
