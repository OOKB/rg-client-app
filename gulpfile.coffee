path = require 'path'

gulp = require 'gulp'

browserSync = require 'browser-sync'

browserify = require 'browserify'
watchify = require 'watchify'
reactify = require 'reactify'

source = require('vinyl-source-stream')

jade = require 'gulp-jade'
less = require 'gulp-less'
react = require 'gulp-react'

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

  gulp.src("templates/*.jade")
    .pipe jade(locals: data)
    .pipe gulp.dest("./public/")
    # .pipe browserSync.reload({stream:true, once: true})
  return

gulp.task 'styles', ->
  gulp.src("styles/*.less")
    .pipe less(paths: [path.join(__dirname, "less", "includes")])
    .pipe gulp.dest("./public")
  return

gulp.task 'copy', ->
  gulp.src('js/**').pipe(gulp.dest('public'));

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

gulp.task 'jsx', ->
  gulp.src('templates/*.jsx')
    .pipe(react())
    .pipe(gulp.dest('dist'))
