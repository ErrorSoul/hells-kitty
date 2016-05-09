handleFileSelect = (evt) ->
  files = evt.target.files
  list = document.getElementById('list')
  list.innerHTML = ""
  # FileList object
  # Loop through the FileList and render image files as thumbnails.
  i = 0
  f = undefined
  while f = files[i]
    # Only process image files.
    if !f.type.match('image.*')
      i++
      continue
    reader = new FileReader
    # Closure to capture the file information.
    reader.onload = ((theFile) ->
      (e) ->
        # Render thumbnail.

        span = document.createElement('span')
        span.innerHTML = [
          '<div class="col-sm-4"> <img class="img-responsive img-thumbnail" src="'
          e.target.result
          '" title="'
          escape(theFile.name)
          '"/> </div>'
        ].join('')
        list.insertBefore span, null
        return
    )(f)
    # Read in the image file as a data URL.
    reader.readAsDataURL f
    i++
  return

document.getElementById('product_asset').addEventListener 'change', handleFileSelect, false
