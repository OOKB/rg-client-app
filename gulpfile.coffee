path = require 'path'

gulp = require 'gulp'
r = require 'request'

browserSync = require 'browser-sync'

browserify = require 'browserify'
watchify = require 'watchify'

source = require('vinyl-source-stream')

jade = require 'gulp-jade'
less = require 'gulp-less'
zopfli = require 'gulp-zopfli'

gulp.task "browser-sync", ->
  browserSync.init "public/**",
    server:
      baseDir: "public" # Change this to your web root dir
    injectChanges: false
    logConnections: true
    ghostMode:
      clicks: true
      scroll: true
      location: true
  return

gulp.task "templates", ->
  data =
    title: 'Fancy Title!'
    sha: 'script'
  gulp.src("templates/*.jade")
    .pipe jade(locals: data)
    .pipe gulp.dest("./public/")
  return

gulp.task 'styles', ->
  gulp.src("styles/*.less")
    .pipe less(paths: [path.join(__dirname, "less", "includes")])
    .pipe gulp.dest("./public")
  return

gulp.task 'compile', ->
  w = watchify(browserify('./app/index.js', watchify.args))
  bundle = () ->
    w.bundle()
      .pipe(source('script.js'))
      .pipe(gulp.dest('./public/'))
  w.on('update', bundle)
  bundle()
  return

gulp.task "default", ['compile', 'styles', 'templates', 'browser-sync'], ->
  gulp.watch "templates/*.jade", ["templates"]
  gulp.watch "styles/*.less", ["styles"]
  gulp.watch 'js/**', ['copy']
  return

# - - - - prod - - - -

gulp.task 'set_sha', (cb) ->
  r_ops =
    uri: 'https://api.github.com/repos/ookb/rg-client-app/branches/master'
    json: true
    headers:
      'user-agent': 'request.js'
  r r_ops, (err, response, body) ->
    if err then throw err
    global.sha = body.commit.sha
    cb()
  return

gulp.task 'prod_compile', ['set_sha'], (cb) ->
  # Javascript bundle
  bundler = browserify debug: true
  bundler.add('./app/index.js')
  bundler.plugin 'minifyify',
    map: 'script.map.json'
    output: './prod/script.map.json'
  bundler.bundle debug: true
    .pipe(source(global.sha+'.js'))
    .pipe(gulp.dest('./prod/'))
    .on('end', cb)

  # Templates
  data =
    title: 'Fancy Title!'
    sha: global.sha
  gulp.src("templates/*.jade")
    .pipe jade(locals: data)
    .pipe gulp.dest("./prod/")
  return

gulp.task 'compress', ['prod_compile'], ->
  gulp.src("./prod/"+global.sha+".js")
    .pipe(zopfli())
    .pipe(gulp.dest("./prod"))

gulp.task 'prod', ['compress'], ->
  return
