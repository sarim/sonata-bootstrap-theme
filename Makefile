BOOTSTRAP = ./docs/assets/css/bootstrap.css
BOOTSTRAP_LESS = ./src/bootstrap.less
BOOTSTRAP_RESPONSIVE = ./docs/assets/css/bootstrap-responsive.css
BOOTSTRAP_RESPONSIVE_LESS = ./src/responsive.less
LESS_COMPRESSOR ?= ./node_modules/less/bin/lessc
UGLIfYJS ?= ./node_modules/uglify-js/bin/uglifyjs
WATCHR ?= `which watchr`


#
# BUILD SIMPLE BOOTSTRAP DIRECTORY
# lessc & uglifyjs are required
#

bootstrap:
	mkdir -p bootstrap/img
	mkdir -p bootstrap/css
	mkdir -p bootstrap/js
	cp -v vendor/bootstrap/img/* bootstrap/img/
	eval ${LESS_COMPRESSOR} ${BOOTSTRAP_LESS} > bootstrap/css/bootstrap.css
	eval ${LESS_COMPRESSOR} --compress ${BOOTSTRAP_LESS} > bootstrap/css/bootstrap.min.css
	eval ${LESS_COMPRESSOR} ${BOOTSTRAP_RESPONSIVE_LESS} > bootstrap/css/bootstrap-responsive.css
	eval ${LESS_COMPRESSOR} --compress ${BOOTSTRAP_RESPONSIVE_LESS} > bootstrap/css/bootstrap-responsive.min.css
	cat vendor/bootstrap/js/bootstrap-transition.js vendor/bootstrap/js/bootstrap-alert.js vendor/bootstrap/js/bootstrap-button.js vendor/bootstrap/js/bootstrap-carousel.js vendor/bootstrap/js/bootstrap-collapse.js vendor/bootstrap/js/bootstrap-dropdown.js vendor/bootstrap/js/bootstrap-modal.js vendor/bootstrap/js/bootstrap-tooltip.js vendor/bootstrap/js/bootstrap-popover.js vendor/bootstrap/js/bootstrap-scrollspy.js vendor/bootstrap/js/bootstrap-tab.js vendor/bootstrap/js/bootstrap-typeahead.js > bootstrap/js/bootstrap.js
	eval ${UGLIfYJS} -nc bootstrap/js/bootstrap.js > bootstrap/js/bootstrap.min.tmp.js
	echo "/**\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > bootstrap/js/copyright.js
	cat bootstrap/js/copyright.js bootstrap/js/bootstrap.min.tmp.js > bootstrap/js/bootstrap.min.js
	rm bootstrap/js/copyright.js bootstrap/js/bootstrap.min.tmp.js

#
# WATCH LESS FILES
#

watch:
	echo "Watching less files..."; \
	watchr -e "watch('vendor/bootstrap/less/.*\.less') { system 'make' }"


# .PHONY: docs watch gh-pages