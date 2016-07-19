Template.sheetwindow.helpers {
  "userId": ->
    return Meteor.userId()
}

Template.sheetwindow.events {
  "click #sheetwindow .new-sheet .close-button": ->
    $("#sheetwindow .new-sheet").removeClass("showing")
  "click #sheetwindow .new-sheet .upload-button": ->
    $("#sheetwindow .new-sheet input").click()

  "click #sheetwindow .toolcircle-menu .toolcircle": (evt) ->
    $(evt.target).toggleClass("close")
    $("#sheetwindow .toolcircle-menu .options").toggleClass("showing")
    if $(evt.target).hasClass("close")
      $(evt.target).attr({title: "Aktionen verbergen"})
    else
      $(evt.target).attr({title: "Aktionen"})

  "click #sheetwindow .toolcircle-menu .options .option.new-image": (evt) ->
    $("#sheetwindow .toolcircle-menu .toolcircle.close").click()
    $("#sheetwindow .new-sheet").addClass("showing")
}
