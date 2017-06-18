window.TopCountPoller = {
  poll: (timeout) ->
    if timeout is 0
      TopCountPoller.request()
    else
      this.pollTimeout = setTimeout ->
        TopCountPoller.request()
      , timeout || 3000
  request: ->
    to_id = $('#messages').first().data('to_id')
    $.get('/messages/top_count', to_user_id: to_id)
}

jQuery ->
  TopCountPoller.poll(0)