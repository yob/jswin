require [
  'vendor/jquery.1.6.4',
  'vendor/minpubsub',
  'lib/module',
  'application/One',
  'application/Two',
  'application/Three',
  'application/ComplexClass'
], ->

  class Application
    constructor: ->
      @one = new tc.application.One()
      @two = new tc.application.Two()
      @three = new tc.application.Three()
      @log = $('body > div')

    sayHello: =>
      @log.append "<p><code>#{@one.whoami()}</code> is present and reporting for duty!</p>"
      @log.append "<p><code>#{@two.whoami()}</code> is present and reporting for duty!</p>"
      @log.append "<p><code>#{@three.whoami()}</code> is present and reporting for duty!</p>"

    testComplexClass: =>
      @complexClass = new tc.application.SocketIOClass("google.com")

  $ ->
    application = new Application()
    application.sayHello()
    application.testComplexClass()
