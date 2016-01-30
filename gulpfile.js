var del = require('del'),
	gulp = require('gulp'),
	concat = require('gulp-concat'),
	cssnano = require('gulp-cssnano'),
	react = require('gulp-react'),
	uglify = require('gulp-uglify'),
    webserver = require('gulp-webserver');
	package = require('./package.json');

/**
 * Clean build files
 */
gulp.task('clean', function() {
	del(package.paths.dest.html);
});

/**
 * Transform jsx
 */
gulp.task('jsx', function() {
	gulp.src(package.paths.src.jsx)
		.pipe(react())
/* 		.pipe(uglify()) */
		.pipe(gulp.dest(package.paths.dest.js));
});

/**
 * Copy html
 */
gulp.task('html', function() {
	gulp.src(package.paths.src.html)
		.pipe(gulp.dest(package.paths.dest.html));
});

/**
 * Copy images
 */
gulp.task('images', function() {
	gulp.src(package.paths.src.images)
		.pipe(gulp.dest(package.paths.dest.images));
});

/**
 * Minify CSS
 */
gulp.task('css', function() {
	gulp.src(package.paths.src.css)
		.pipe(cssnano())
		.pipe(gulp.dest(package.paths.dest.css));
});

/**
 * Copy libraries
 */
gulp.task('libs', function() {
	gulp.src(package.paths.libs)
		.pipe(gulp.dest(package.paths.dest.libs));
});

/**
 * Copy fonts
 */
gulp.task('fonts', function() {
	gulp.src(package.paths.fonts)
		.pipe(gulp.dest(package.paths.dest.fonts));
});

/**
 * Uglify JS
 */
gulp.task('js', function() {
	gulp.src(package.paths.src.js)
		.pipe(uglify())
		.pipe(gulp.dest(package.paths.dest.js));
});

/**
 * Build
 */
gulp.task('build', [
	'html',
	'images',
	'css',
	'libs',
	'fonts',
	'js',
	'jsx'
]);
gulp.task('build:clean', [
	'clean',
	'html',
	'images',
	'css',
	'libs',
	'fonts',
	'js',
	'jsx'
]);

/**
 * Web server
 */
gulp.task('webserver', function() {
	gulp.src('./build')
	.pipe(webserver({
		host: '127.0.0.1',
		port: 8000,
		livereload: true
	}));
});

/**
 * Watch
 */
gulp.task('watch', function() {
	gulp.watch([
		package.paths.src.css,
		package.paths.src.js,
		package.paths.src.jsx,
		package.paths.src.html
	], ['build']);
});
gulp.task('watch:clean', function() {
	gulp.watch([
		package.paths.src.css,
		package.paths.src.js,
		package.paths.src.jsx,
		package.paths.src.html
	], ['build:clean']);
});

/**
 * Default
 */
gulp.task('default', [
	'build',
	'watch',
	'webserver'
]);

/**/
