$ ->
  $('#nottweet_content').click (e) ->
    e.preventDefault()
    $(this).addClass('nottweeting')
    $('.attachment').addClass('nottweeting')

  $('.show_attachment').click (e) ->
    e.preventDefault()
    attachment = $(this).siblings('.attachment')
    if attachment.hasClass('hide')
      $(this).text('Hide Attachment')
    else
      $(this).text('Show Attachment')
    attachment.toggleClass('hide')

