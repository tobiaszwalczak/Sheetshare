Accounts.onCreateUser( (options, user) ->
  if options.profile
    user.profile = options.profile

    if user.services.facebook
      user.profile.image = "http://graph.facebook.com/" + user.services.facebook.id + "/picture/?type=large"

  return user
)
