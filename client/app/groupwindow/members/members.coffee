Template.members.helpers {

  members: ->
    Users.find()

  knownUsers: ->
    Users.find()

}



Template.members.events {

  "click section.members .add-member-button": (evt) ->
    $(evt.target).addClass("adding")
    $("section.members .add-member-button input").focus()

  "blur section.members .add-member-button input": (evt) ->
    $(".add-member-button").removeClass("adding")
    $(evt.target).val("")

}
