@module 'tc', ->
  @module 'reader', ->
    class @Bar
      whoami: ->
        'bar'
