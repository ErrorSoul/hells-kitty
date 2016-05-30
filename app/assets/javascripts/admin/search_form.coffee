$ ->
  $('.open-search').on 'click', (e) ->
    e.preventDefault()
    $('.form-search').slideToggle()
