Template.sheetwindow.events {
  "click #sheetwindow .toolcircle-menu .toolcircle": (evt) ->
    $(evt.target).toggleClass("close")
    $("#sheetwindow .toolcircle-menu .options").toggleClass("showing")

}
