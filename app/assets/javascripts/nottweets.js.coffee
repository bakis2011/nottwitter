$ ->
  $('textarea').focus (e) ->
    e.preventDefault()
    $('.nottweet-action').removeClass('hide')

  $('textarea').focusout (e) ->
    e.preventDefault()
    $('.nottweet-action').addClass('hide')

  $('.show_attachment').click (e) ->
    e.preventDefault()
    attachment = $(this).siblings('.attachment')
    if attachment.hasClass('hide')
      $(this).text('Hide Attachment')
    else
      $(this).text('Show Attachment')
    attachment.toggleClass('hide')

