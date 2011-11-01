require ['reader/Bar']

@module 'tc', ->
  @module 'reader', ->
    class @Foo
      meaningOfLife: ->
        42

      fibonacci: (n) =>
        s = 0
        return s if n == 0
        if n == 1
          s += 1
        else
          @fibonacci(n - 1) + @fibonacci(n - 2)

      failingTest: =>
        false
