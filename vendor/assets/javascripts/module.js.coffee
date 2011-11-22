# a simple and effective namespacing technique. Modules are
# attached to window to avoid polluting the global namespace.
#
# Source originally from
#
# https://github.com/jashkenas/coffee-script/wiki/Easy-modules-with-CoffeeScript
#
# Use like this:
#
# @module 'app', ->
#   class @Calculator
#
#     constructor: ->
#       foo

@module = (names, fn) ->
  names = names.split '.' if typeof names is 'string'
  space = @[names.shift()] ||= {}
  space.module ||= @module
  if names.length
    space.module names, fn
  else
    fn.call space

