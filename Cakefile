muffin  = require 'muffin'
fs      = require 'fs'
glob    = require 'glob'
path    = require 'path'
{spawn} = require 'child_process'

option '-w', '--watch',       'continue to watch the files and rebuild them when they change'
option '-s', '--coverage',    'run jscoverage during tests and report coverage (test task only)'
option '-c', '--commit',      'operate on the git index instead of the working tree'
option '-m', '--compare',     'compare across git refs, stats task only.'
option '-p', '--production',  'process the built coffee with requrirejs and concat/minify the result for production use.'


task 'doc', 'build the Docco documentation', (options) ->
  muffin.run
    files: './coffee/**/*.coffee'
    options: options
    map:
      "./coffee/(.+)\.coffee": (matches) -> muffin.doccoFile matches[0], options


task 'stats', 'compile the files and report on their final size', (options) ->
  stat = (files) ->
    muffin.statFiles(
      files,
      {fields:['filename', 'filetype', 'sloc', 'blank', 'comment', 'size', 'modified']}
    )
  stat glob.globSync('./coffee/**/*.coffee')
  stat glob.globSync('./public/javascripts/**/*.js')


buildAppJS = (options, output_dir="./public/javascripts") ->
  muffin.run
    files: glob.globSync './coffee/**/*.coffee'
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
  temp       = require 'temp'
  temp_dir   = temp.mkdirSync()

  # make sure the application js is freshly built into the temp dir
  buildAppJS options, temp_dir

  # move and vendor scripts into place inside the temp folder
  muffin.run
    files: glob.globSync './public/javascripts/vendor/*.js'
    options: options
    map:
      "./public/javascripts/(.*\.js)": (matches) ->
        muffin.copyFile matches[0], "#{temp_dir}/#{matches[1]}", options

    after: ->
      # compile the coffeescript specs into the temp folder and then run requirejs
      muffin.run
        files: glob.globSync './spec/coffee/**/*.coffee'
        options: options
        map:
          # compile specs and helpers
          "./spec/coffee/.+/(.+)_(spec|helper)\.coffee": (matches) ->
            muffin.compileScript matches[0], "#{temp_dir}/spec/#{matches[1]}_#{matches[2]}.js", options

        after: ->
          requirejs = require 'requirejs'
          targets = glob.globSync "#{temp_dir}/*.js"

          for target in targets
            matches = /.*\/(.+)\.js/.exec target
            config = {
              baseUrl: temp_dir,
              name: matches[1],
              out: "./spec/compiled/#{matches[1]}.js"
            }
            requirejs.optimize config, (buildResponse) ->
              contents = fs.readFileSync config.out, 'utf8'

          runner = spawn "jasmine-headless-webkit", ["-c"]
          runner.stdout.on 'data', (data) ->
            console.log data.toString().trim()
