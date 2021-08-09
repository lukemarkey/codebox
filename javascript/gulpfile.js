var gulp  = require('gulp'),
gutil = require('gulp-util');
concat = require('gulp-concat')

var vendor_javascript = [
	'node_modules/store/dist/store.everything.min.js',
	'node_modules/noty/lib/noty.min.js',
	'node_modules/vue/dist/vue.js'
];

var vendor_css = [
	'node_modules/noty/lib/noty.css'
]

gulp.task('vendor', function() {
	gulp.start('javascript', 'css')
});

gulp.task('javascript', function() {
	return gulp
	.src(vendor_javascript).pipe(concat('vendor.js'))
	.pipe(gulp.dest('website/static/website/custom'))
});

gulp.task('css', function() {
	return gulp
	.src(vendor_css).pipe(concat('vendor.css'))
	.pipe(gulp.dest('website/static/website/custom'))
});
