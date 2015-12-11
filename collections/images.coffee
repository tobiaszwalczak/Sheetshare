@Images = new FS.Collection("images", {
  stores: [new FS.Store.FileSystem("images", {path: "~/uploads"})]
})

Images.allow {
  "insert": ->
    # add custom authentication code here
    return true
}
