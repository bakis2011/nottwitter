$ ->
  $(document).click (e) ->
    obj = e.target
    form = $(obj).closest('#new_nottweet')
    if form.length > 0
      $('.nottweet-action').removeClass('hide')
      $('#nottweet_content').addClass('focus')
    else
      $('.nottweet-action').addClass('hide')
      $('#nottweet_content').removeClass('focus')

  $('.show_attachment').click (e) ->
    e.preventDefault()
    attachment = $(this).siblings('.attachment')
    if attachment.hasClass('hide')
      $(this).text('Hide Attachment')
    else
      $(this).text('Show Attachment')
    attachment.toggleClass('hide')

