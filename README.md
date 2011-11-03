# Require.js + jasmine + cakefiles

## What is this?
A little spike for getting [Coffeescript](https://github.com/jashkenas/coffee-script) & [Jasmine](http://pivotal.github.com/jasmine/) working in a modular & organised manner using [require.js](http://requirejs.org/).
Heavily inspired by [muffin](https://github.com/hornairs/muffin) and Shopify’s Batman.js cakefile.

### Advantages of this approach;
- write your javascript in coffee.
- split your coffee out into organised and abstracted modules.
- use require.js to manage dependancies between modules.
- for production; bundle all your code up into single minified, concatenated top-level files for production, cleanly wrapping up dependancies and bundling app code into a nice, namespaced out object structure and hanging it all off `window`.
- write jasmine tests for your app code using coffeescript.

### What?
Write your app code in `./coffee` — see `./coffee/application.coffee` and `./coffee/application/**` for an example of how you can start to structure your coffee.

Use [coffeescript modules](https://github.com/jashkenas/coffee-script/wiki/Easy-modules-with-CoffeeScript) to make sure that your code is nicely wrapped up when compiled out. For example here are the contents of `./coffee/application/One.coffee`;

	@module 'tc.application', ->
  		class @One
    		whoami: ->
      			'tc.application.One'

Will end up being available at `window.tc.application.One`, and similarly all the other code for the application example will look something like this;

	- window
		- tc
			- application
				- One
				- Two
				- Three
				- ComplexClassExample
			- lib
				- SocketIOWrapper

etc...which allows for fun stuff like this;

	require ['lib/SocketIOWrapper'], ->
		@module "tc.application", ->
			class @ComplexClassExample extends tc.lib.SocketIOWrapper
				constructor: (url, options) ->
					# etc, etc...

## Requirements
- ruby
- node & npm
- npm dependancies;
	- requirejs
	- muffin
	- glob
	- temp
	- docco (requires pygments)

## Setup
- `bundle`
- `npm install requirejs muffin glob temp docco`
- `sudo easy_install Pygments` (for docco)

## Usage
### build coffeescript
- `cake build`
- compiles code from `./coffee` into `./public/javascript`
- accepts `-p` flag to have require.js process code and compile js for production.

### run the test suite
- `cake test`

### get stats on the code
- `cake stats`

### build the HTML documentation
- `cake docs` (generates HTML docs in `./docs`)
