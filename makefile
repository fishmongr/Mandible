UGLIFY=vendor/uglifyjs
REMOVE_DEBUG_CODE=bin/remove-debug-code.sh

JS_FILES=src/js/vendor/jquery.js\
src/js/vendor/underscore.js\
src/js/index.js

CSS_FILES=src/scss/index.scss\
src/scss/_mixins.scss\
src/scss/_html5boilerplate.scss\
src/scss/_base.scss\
src/scss/_page-home.scss\
src/scss/_ipad.scss\
src/scss/_iphone.scss\
src/scss/_mobile-landscape.scss\
src/scss/_mobile-portrait.scss\
src/scss/_tablet-portrait.scss

JS_OUTPUT_FILE=assets/js/index.js

# Compress source files
all: assets/js/index.js assets/css/index.css assets/index.html

# Compress version
assets/js/index.js : ${JS_FILES}
	@echo 'JS file is out of date. Compiling...'
	if [ ! -f ${JS_OUTPUT_FILE} ]; then touch ${JS_OUTPUT_FILE}; fi
	cat ${JS_FILES} > tmp
	${REMOVE_DEBUG_CODE} tmp
	cat src/js/debug.js >> tmp
	${UGLIFY} tmp > ${JS_OUTPUT_FILE}
	rm tmp;

assets/css/index.css : ${CSS_FILES}
	@echo 'CSS file is out of date. Compiling...'
	echo ${CSS_FILES}
	sass --update --style=compressed src/scss/:assets/css

assets/index.html : src/index.html
	@echo 'HTML files are out of date. Compiling...'
	cd bin; ./watch-template.sh --no-watch

# debug compressed js
debug:
	cat ${JS_FILES} > tmp
	cat tmp > ${JS_OUTPUT_FILE}
	rm tmp;