$ ->
  $(document).click (e) ->
    obj = e.target
    form = $(obj).closest('#new_bork')
    if form.length > 0
      $('.bork-action').removeClass('hide')
      $('#bork_content').addClass('focus')
    else
      $('.bork-action').addClass('hide')
      $('#bork_content').removeClass('focus')

  $('.show_attachment').click (e) ->
    e.preventDefault()
    attachment = $(this).siblings('.attachment')
    if attachment.hasClass('hide')
      $(this).text('Hide Attachment')
    else
      $(this).text('Show Attachment')
    attachment.toggleClass('hide')

  $("body").highlight("kate")
