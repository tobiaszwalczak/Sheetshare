Router.route "/", ->
  this.render("landing")

Router.route "/home", ->
  this.render("home")

Router.onBeforeAction( ->
  if Meteor.userId()
    this.render("home")
  else
    this.redirect("/")
    this.next()
)
