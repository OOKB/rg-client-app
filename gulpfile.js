(function() {
  var browserSync, browserify, gulp, jade, less, path, r, source, watchify, zopfli;

  path = require('path');

  gulp = require('gulp');

  r = require('request');

  browserSync = require('browser-sync');

  browserify = require('browserify');

  watchify = require('watchify');

  source = require('vinyl-source-stream');

  jade = require('gulp-jade');

  less = require('gulp-less');

  zopfli = require('gulp-zopfli');

  gulp.task("browser-sync", function() {
    browserSync.init("public/**", {
      server: {
        baseDir: "public"
      },
      injectChanges: false,
      logConnections: true,
      ghostMode: {
        clicks: true,
        scroll: true,
        location: true
      }
    });
  });

  gulp.task("templates", function() {
    var data;
    data = {
      title: 'Fancy Title!',
      sha: 'script'
    };
    gulp.src("templates/*.jade").pipe(jade({
      locals: data
    })).pipe(gulp.dest("./public/"));
  });

  gulp.task('styles', function() {
    gulp.src("styles/*.less").pipe(less({
      paths: [path.join(__dirname, "less", "includes")]
    })).pipe(gulp.dest("./public"));
  });

  gulp.task('compile', function() {
    var bundle, w;
    w = watchify(browserify('./app/index.js', watchify.args));
    bundle = function() {
      return w.bundle().pipe(source('script.js')).pipe(gulp.dest('./public/'));
    };
    w.on('update', bundle);
    bundle();
  });

  gulp.task("default", ['compile', 'styles', 'templates', 'browser-sync'], function() {
    gulp.watch("templates/*.jade", ["templates"]);
    gulp.watch("styles/*.less", ["styles"]);
    gulp.watch('js/**', ['copy']);
  });

  gulp.task('set_sha', function(cb) {
    var r_ops;
    r_ops = {
      uri: 'https://api.github.com/repos/ookb/rg-client-app/branches/master',
      json: true,
      headers: {
        'user-agent': 'request.js'
      }
    };
    r(r_ops, function(err, response, body) {
      if (err) {
        throw err;
      }
      global.sha = body.commit.sha;
      return cb();
    });
  });

  gulp.task('prod_compile', ['set_sha'], function(cb) {
    var bundler, data;
    bundler = browserify({
      debug: true
    });
    bundler.add('./app/index.js');
    bundler.plugin('minifyify', {
      map: 'script.map.json',
      output: './prod/script.map.json'
    });
    bundler.bundle({
      debug: true
    }).pipe(source(global.sha + '.js')).pipe(gulp.dest('./prod/')).on('end', cb);
    data = {
      title: 'Fancy Title!',
      sha: global.sha
    };
    gulp.src("templates/*.jade").pipe(jade({
      locals: data
    })).pipe(gulp.dest("./prod/"));
  });

  gulp.task('compress', ['prod_compile'], function() {
    return gulp.src("./prod/" + global.sha + ".js").pipe(zopfli()).pipe(gulp.dest("./prod"));
  });

  gulp.task('prod', ['compress'], function() {});

}).call(this);
