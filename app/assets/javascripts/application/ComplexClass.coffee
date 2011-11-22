#= require SocketIOWrapper

@module "tc.application", ->
  class @ComplexClassExample extends SocketIOWrapper
    constructor: (url, options) ->
      super url, options
      @connect()

    on_connecting: =>
      # console.log 'SocketIOClass.on_connecting'

    on_connect: =>
      # console.log 'SocketIOClass.on_connect'

    on_message: (data) =>
      # console.log 'SocketIOClass.on_message'

    on_disconnect: (event) =>
      # console.log 'SocketIOClass.on_disconnect'
