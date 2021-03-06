path = require 'path'
fs = require 'fs-extra'
gulp = require 'gulp'
r = require 'request'
_ = require 'lodash'

browserSync = require 'browser-sync'

browserify = require 'browserify'
watchify = require 'watchify'
coffeeify = require 'coffeeify'

source = require('vinyl-source-stream')

jade = require 'gulp-jade'
less = require 'gulp-less'
clean = require 'gulp-clean'
rename = require 'gulp-rename'
runSequence = require 'run-sequence'

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
    sha: 'app'
  gulp.src("templates/*.jade")
    .pipe jade(locals: data)
    .pipe gulp.dest("./public/")
  return

gulp.task 'copy', ->
  gulp.src('./images/**')
    .pipe gulp.dest('./public/images/')

gulp.task 'static', ->
  gulp.src('./static/**')
    .pipe gulp.dest('./public/')

gulp.task 'static-js', ->
  gulp.src('./static/scripts/*.js')
    .pipe gulp.dest('./public/scripts/')
gulp.task 'static-template', ->
  gulp.src('./static/templates/**')
    .pipe gulp.dest('./public/templates/')

gulp.task 'styles', ->
  gulp.src(["styles/app.less", 'styles/print.less', 'styles/iefix.less', 'styles/static.less', 'styles/whenloading.less'])
    .pipe less(paths: [path.join(__dirname, "less", "includes")])
    .pipe gulp.dest("./public")

gulp.task 'compile', ->
  opts = watchify.args
  opts.extensions = ['.coffee', '.json']
  w = watchify(browserify('./app/index.coffee', opts))
  w.transform coffeeify
  bundle = () ->
    w.bundle()
      .pipe(source('app.js'))
      .pipe(gulp.dest('./public/'))
  w.on('update', bundle)
  bundle()
  return

gulp.task 'compileMenu', ->
  opts = watchify.args
  opts.extensions = ['.coffee', '.json']
  w = watchify(browserify('./app/indexMenu.coffee', opts))
  w.transform [coffeeify]
  bundle = () ->
    w.bundle()
      .pipe(source('appMenu.js'))
      .pipe(gulp.dest('./public/'))
  w.on('update', bundle)
  bundle()
  return

gulp.task "default", ['compile', 'compileMenu', 'styles', 'templates', 'browser-sync', 'copy'], ->
  gulp.watch "templates/*.jade", ["templates"]
  gulp.watch "styles/*.less", ["styles"]
  gulp.watch 'images/**', ['copy']
  gulp.watch 'static/about/*.html', ['static']
  gulp.watch 'static/contact/*.html', ['static']
  gulp.watch 'static/scripts/*.js', ['static-js']
  gulp.watch 'static/templates/**', ['static-template']
  return

gulp.task 'dataContent', ->
  r('https://r_g.cape.io/_view/md_pages/display')
    .pipe source('content.json')
    .pipe gulp.dest('./app/models/')

gulp.task 'dataItems', ['dataContent'], ->
  r('https://db.delanyandlong.com/rg/items.json')
    .pipe source('data.json')
    .pipe gulp.dest('./app/models/')

gulp.task 'data', ['dataItems'], ->
  items = fs.readJsonSync './app/models/data.json'
  items = _.groupBy items, 'patternNumber'
  items = _.mapValues items, (itemList) ->
    _.pluck itemList, 'color_id'
  fs.outputJson './app/models/pattern_colors.json', items
# gulp.task 'static_dl', ->
#   r('')

# - - - - prod - - - -

gulp.task 'set_sha', (cb) ->
  r_ops =
    uri: 'https://api.github.com/repos/ookb/rg-client-app/branches/master'
    json: true
    headers:
      'user-agent': 'request.js'
  r r_ops, (err, response, body) ->
    if err then throw err
    global.sha = body.commit.sha+Math.floor(Date.now() / 1000)
    cb()
  return

# Remove contents from prod directory.
gulp.task 'prod_clean', ->
  gulp.src('./prod', read: false)
    .pipe(clean())

gulp.task 'prod_compile', (cb) ->
  # Javascript bundle
  opts =
    debug: true
    extensions: ['.coffee', '.json']
  bundler = browserify opts
  bundler.transform coffeeify
  bundler.add('./app/index.coffee')
  bundler.plugin 'minifyify',
    map: 'script.map.json'
    output: './prod/script.map.json'
  bundler.bundle debug: true
    .pipe(source(global.sha+'.js'))
    .pipe(gulp.dest('./prod/'))
    .on('end', cb)
  return

gulp.task 'prod_menu_compile', (cb) ->
  # Javascript bundle
  opts =
    debug: true
    extensions: ['.coffee', '.json']
  bundler = browserify opts
  bundler.transform coffeeify
  bundler.add('./app/indexMenu.coffee')
  bundler.plugin 'minifyify',
    map: 'script.map.json'
    output: './prod/script.map.json'
  bundler.bundle debug: true
    .pipe(source('appMenu.js'))
    .pipe(gulp.dest('./prod/'))
    .on('end', cb)
  return

gulp.task 'prod_template', ->
  # Templates
  data =
    title: 'Fancy Title!'
    sha: global.sha
  gulp.src("templates/*.jade")
    .pipe jade(locals: data)
    .pipe gulp.dest("./prod/")

gulp.task 'copy_css', ['styles'], ->
  gulp.src('./public/app.css')
    .pipe(rename(global.sha+'.css'))
    .pipe(gulp.dest('./prod'))
  gulp.src(['./public/print.css', './public/iefix.css', './public/static.css', './public/whenloading.css'])
    .pipe(gulp.dest('./prod'))
  gulp.src('./images/**')
    .pipe gulp.dest('./prod/images/')
  gulp.src('./static/**')
    .pipe gulp.dest('./prod/')
gulp.task 'copy_data', ->
  gulp.src('./app/models/*.json')
    .pipe(gulp.dest('./prod'))
# gulp.task 'compress', ->
#   gulp.src("./prod/*.{js,css,html,json}")
#     .pipe(zopfli())
#     .pipe(gulp.dest("./prod"))

gulp.task 'deploy', (cb) ->
  runSequence ['set_sha', 'data'],
    ['prod_template', 'copy_css', 'copy_data', 'prod_compile', 'prod_menu_compile'],
    cb
  return
