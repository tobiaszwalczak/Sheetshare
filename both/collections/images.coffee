@Images = new FS.Collection("images", {
  stores: [new FS.Store.FileSystem("images", {path: "~/uploads"})]
})

Images.allow {
  insert: (userId,project) ->
    return true
  update: (userId,project,fields,modifier) ->
   return true
  remove: (userId,project) ->
    return true
  download: () ->
    return true
}
