Accounts.onCreateUser( (options, user) ->
  if options.profile
    user.profile = options.profile
    user.group = {tab: "chat"}

    if user.services.facebook
      user.profile.image = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large"
      user.profile.email = user.services.facebook.email

  return user
)
