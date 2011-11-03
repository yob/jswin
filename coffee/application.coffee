require [
  'vendor/jquery.1.6.4',
  'vendor/minpubsub',
  'lib/module',
  'application/One',
  'application/Two',
  'application/Three',
  'application/ComplexClass'
], ->

  $ ->
    one = new tc.application.One()
    two = new tc.application.Two()
    three = new tc.application.Three()

    sayHello = ->
      log = $('body > div')
      log.append "<p><code>#{one.whoami()}</code> is present and reporting for duty!</p>"
      log.append "<p><code>#{two.whoami()}</code> is present and reporting for duty!</p>"
      log.append "<p><code>#{three.whoami()}</code> is present and reporting for duty!</p>"

    sayHello()
