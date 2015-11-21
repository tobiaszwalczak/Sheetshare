Template.sheetwindow.events {
  "click #sheetwindow .toolcircle-menu .toolcircle": (evt) ->
    $(evt.target).toggleClass("close")
    $("#sheetwindow .toolcircle-menu .options").toggleClass("showing")
    if $(evt.target).hasClass("close")
      $(evt.target).attr({title: "Aktionen verbergen"})
    else
      $(evt.target).attr({title: "Aktionen"})

}
