# Rails 3.1 + coffee + jasmine

## What is this?
A little spike for getting [Coffeescript](https://github.com/jashkenas/coffee-script) and [Jasmine](http://pivotal.github.com/jasmine/) working in a modular & organised manner using the rails 3.1 asset pipeline.

### Advantages of this approach;
- write your javascript in coffee.
- split your coffee out into organised and abstracted modules in separate files.
- utilise the rails asset pipeline for compiling and managing JS load order. Love it or hate it, it's the path of least resistance and least surprise
- all external dependencies resolvable by rubygems. No need for node.js, coffee, cake or npm.
- for production; bundle all your code up into single minified, concatenated top-level files for production, cleanly wrapping up dependancies and bundling app code into a nice, namespaced out object structure and hanging it all off `window`.
- write jasmine tests for your app code using coffeescript.
- trolling justin

### What?
Write your app code in `app/assets/javascipts/application.js` and `app/assets/javascipts/application/**`

Use [coffeescript modules](https://github.com/jashkenas/coffee-script/wiki/Easy-modules-with-CoffeeScript) to make sure that your code is nicely wrapped up when compiled out. For example here are the contents of `./app/assets/javascipts/application/One.coffee`;

  @module 'tc.application', ->
    class @One
      whoami: ->
        tc.application.One'

Will end up being available at `window.tc.application.One`, and similarly all the other code for the application example will look something like this;

  - window
    - tc
      - application
        - One
        - Two
        - Three
        - ComplexClassExample

etc...which allows for fun stuff like this;

  #= require SocketIOWrapper
  module "tc.application", ->
    class @ComplexClassExample extends SocketIOWrapper
      constructor: (url, options) ->
      # etc, etc...

Write specs in `spec/javascripts`.

## Requirements
- ruby

## Setup
- `bundle`

## run the test suite from the command line
- bundle exec rspec spec/acceptance/jasmine_spec.rb

## run the test suite from the browser in dev env
- visit http://127.0.0.1:3000/jasmine
