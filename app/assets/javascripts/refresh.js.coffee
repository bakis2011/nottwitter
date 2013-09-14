$ ->
  setInterval (->
    $.ajax
      url: "refresh"
  ), 5000

  $('#name_name').focus()
