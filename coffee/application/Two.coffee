@module 'tc', ->
  @module 'application', ->
    class @Two
      whoami: ->
        'application.Two'
