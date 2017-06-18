window.Poller = {
  poll: (timeout) ->
    if timeout is 0
      Poller.request()
    else
      this.pollTimeout = setTimeout ->
        Poller.request()
      , timeout || 5000
  clear: -> clearTimeout(this.pollTimeout)
  request: ->
    first_id = $('.message').first().data('id')
    to_id = $('#messages').first().data('to_id')
    $.get('/messages/show', to_user_id: to_id, after_id: first_id)
}

jQuery ->
  Poller.poll() if $('#messages').size() > 0