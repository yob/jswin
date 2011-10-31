muffin = require 'muffin'
fs     = require 'fs'
glob   = require 'glob'
path   = require 'path'
{spawn} = require 'child_process'

option '-w', '--watch',     'continue to watch the files and rebuild them when they change'
option '-s', '--coverage',  'run jscoverage during tests and report coverage (test task only)'
option '-c', '--commit',    'operate on the git index instead of the working tree'
option '-m', '--compare',   'compare across git refs, stats task only.'
option '-d', '--dist',      'process the built coffee with requrirejs and concat/minify the result for production use.'


task 'doc', 'build the Docco documentation', (options) ->
  muffin.run
    files: './coffee/**/*.coffee'
    options: options
    map:
      "./coffee/(.+)\.coffee": (matches) ->
        muffin.doccoFile matches[0], options


buildAppJS = (options, output_dir="./public/javascripts") ->
  files = glob.globSync('./coffee/**/*.coffee')
  muffin.run
    files: files
    options: options
    map:
      "./coffee/(.+)\.coffee": (matches) ->
        muffin.compileScript matches[0], "#{output_dir}/#{matches[1]}.js", options
    after: ->
      if options.dist
        requirejs = require 'requirejs'
        dist_targets = glob.globSync("#{output_dir}/*.js")
        for target in dist_targets
          matches = /.*\/(.+)\.js/.exec(target)
          config = {
            baseUrl: output_dir,
            name: matches[1],
            out: "#{output_dir}/build/#{matches[1]}.js"
          }
          requirejs.optimize config, (buildResponse) ->
            contents = fs.readFileSync config.out, 'utf8'


task 'build', 'compile javascript', (options) ->
  buildAppJS(options)


task 'test', 'compile specs and code, run the test suite', (options) ->
  temp              = require 'temp'
  spec_output_dir   = temp.mkdirSync()
  buildAppJS(options, spec_output_dir)

  files             = glob.globSync './spec/**/*.coffee'

  muffin.run
    files: files
    options: options
    map:
      # compile specs and helpers
      "./spec/.+/(.+)_(spec|helper)\.coffee": (matches) ->
        muffin.compileScript matches[0], "#{spec_output_dir}/spec/#{matches[1]}_#{matches[2]}.js", options
    after: ->
      requirejs = require 'requirejs'
      targets = glob.globSync("#{spec_output_dir}/*.js")

      for target in targets
        matches = /.*\/(.+)\.js/.exec(target)
        config = {
          baseUrl: spec_output_dir,
          name: matches[1],
          out: "./spec/compiled/#{matches[1]}.js"
        }
        requirejs.optimize config, (buildResponse) ->
          contents = fs.readFileSync config.out, 'utf8'

      runner = spawn "jasmine-headless-webkit", ["-c"]
      runner.stdout.on 'data', (data) ->
        console.log data.toString().trim()
