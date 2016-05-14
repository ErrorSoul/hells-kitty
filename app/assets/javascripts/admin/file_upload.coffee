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
        p = document.getElementById('input_label')
        console.log('p', p)
        p.innerHTML = 'Выбрано' + ' ' +  files.length
        span.innerHTML = [
          '<div class="col-md-6 bottom_20"> <img class="img-responsive img-thumbnail" src="'
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
if $('#product_asset').length
  document.getElementById('product_asset').addEventListener 'change', handleFileSelect, false

readURL = (input, id) ->
  if input.files and input.files[0]
    reader = new FileReader

    reader.onload = (e) ->
      $(input).parent()
              .first()
              .siblings('img').attr 'src', e.target.result
      return

    reader.readAsDataURL input.files[0]
  return

if ('.inputFile').length
        $('.inputFile').on 'change',  ->

          id = $(this).data('type')
          readURL this, id
          return

$('.relation-position').on 'click', ->
        $('.input-hide').trigger('click')
