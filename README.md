# Require.js + jasmine + cakefiles

Testcase for getting Coffeescript & Jasmine working in a modular & organised manner.
Heavily inspired by https://github.com/hornairs/muffin and Shopify's Batman.js cakefile.

Check out the `./coffee` and `./spec` dirs for the sweet action.

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

`cake` accepts a `-w` flag for all tasks to tell it to watch the files, handy for developemnt so you don’t spend time waiting on compile.

- build coffeescript:
	- `cake build`
	- compiles code from `./coffee` into `./public/javascript`
	- accepts `-d` flag to have require.js process code and compile js for production.

- run the test suite:
	- `cake test`

- get stats on the code:
	- `cake stats`

- build the HTML documentation:
	- `cake docs` (generates HTML docs in `./docs`)
