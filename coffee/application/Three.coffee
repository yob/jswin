@module 'tc', ->
  @module 'application', ->
    class @Three
      whoami: ->
        'application.Three'
