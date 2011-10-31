@module "tc", ->
  @module "lib", ->
    class @SocketIOWrapper
      constructor: (url, options) ->
        @url = url
        @options = options
        console.log "SocketIOWrapper instantiated with url:#{@url}"

      connect: (autoReconnect=true, autoReconnectTimeout=2000) =>
        if not tc.socket
          if @.hasOwnProperty('on_connecting')
            @on_connecting()
          console.log "We woulc normally connect to Socket.IO here, but this is just a test :)"
          # tc.socket = new io.Socket(@url, @options)
          tc.socket = off
          return
          tc.socket.connect()
        tc.socket.on('connect', @on_connect)
        tc.socket.on('message', (data) =>
          @on_message(data)
        )
        tc.socket.on('disconnect', (event) =>
          @websocket = null
          if autoReconnect
            window.setTimeout(
              (=> @connect(autoReconnect, autoReconnectTimeout)),
              autoReconnectTimeout
            )
          @on_disconnect(event)
        )

      subscribe: (channel) =>
        tc.socket.send(['__subscribe__', channel])
        return tc.socket

      unsubscribe: (channel) =>
        tc.socket.send(['__unsubscribe__', channel])
        return tc.socket
