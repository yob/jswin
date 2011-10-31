require ['lib/module', 'reader/Foo'], ->

  describe 'tc.reader.Foo:', ->
    describe 'meaningOfLife()', ->
      fooClass = new tc.reader.Foo()
      it 'should calculate and return the Meaning of Life', ->
        expect(fooClass.meaningOfLife()).toEqual 42

    describe 'fibonacci()', ->
      fooClass = new tc.reader.Foo()
      it 'should calculate the numbers correctly up to fib(16)', ->
        fib = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610, 987]
        expect(fooClass.fibonacci(i)).toEqual fib[i] for i in [0..16]
