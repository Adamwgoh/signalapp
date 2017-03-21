'use strict';

var watchify   = require('watchify');
var browserify = require('browserify');
var gulp       = require('gulp');
var source     = require('vinyl-source-stream');
var buffer     = require('vinyl-buffer');
var gutil      = require('gulp-util');
var sourcemaps = require('gulp-sourcemaps');
var assign     = require('lodash.assign');
var reactify   = require('reactify');
var babelify   = require('babelify');

// adding custom browserify optioins here
var customOpts = {
  entries: ['./react/app.js'], 
	transform: [
	  ["reactify", {"es6": true}]
	],
  debug: true

};

var opts = assign({}, watchify.args, customOpts);

var production = browserify(opts);
gulp.task('production', bundleProduction);
production.on('log', gutil.log); //output build logs to terminal

var development = watchify(browserify(opts));
gulp.task('development', bundleDevelopment);
development.on('update', bundleDevelopment); // on any dep update, runs the bundler
development.on('log', gutil.log); // output build logs to terminal

function bundleDevelopment(){
  return development.bundle()
	  // log errors if they happen
		.on('error', function(err){
		  console.log(err.message);	
		})
		.pipe(source('react-bundle.js'))
		//optional, remove if you don't need to buffer file contents
		.pipe(buffer())
		//optional, remove if you don't want sourcemaps
		.pipe(sourcemaps.init({loadMaps: true})) // loads map from browserify file
		// Add transformation tasks to the pipeline here.
		.pipe(sourcemaps.write('./')) //writes .map file
		.pipe(gulp.dest('./app/assets/javascripts'));
}

function bundleProduction(){
  return production.bundle()
	// log errors if they happen
	.on('error', function(err){
	  console.log(err.message);	
	})
	.pipe(source('react-bundle.js'))
	//optional, remove if you don't need to buffer file content
	.pipe(buffer())
	.pipe(uglify())
	.pipe(gulp.dest('./app/assets/javascripts'));
}
// add transformations here
// ie b.transform(coffeeify);

//gulp.task('js', bundle);
//b.on('update', bundle);
//b.on('log', gutil.log);
//
//function bundle(){
//  return b.bundle()
//    //log errors 
//    .on('error', gutil.log.bind(gutil, 'Browserify Error'))
//    .pipe(source('react-bundle.js'))
//    .pipe(sourcemaps.init({loadMaps: true}))
//    .pipe(sourcemaps.write('./'))
//    .pipe(gulp.dest('./app/assets/javascripts'));
//}

gulp.task('default', ['development']);

