@module 'tc', ->
  @module 'application', ->
    class @One
      whoami: ->
        'application.One'
