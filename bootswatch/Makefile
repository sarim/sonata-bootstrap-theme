BOOTSTRAP = ../docs/assets/css/bootstrap.css
BOOTSTRAP_LESS = ./src/bootstrap.less
BOOTSTRAP_RESPONSIVE = ../docs/assets/css/bootstrap-responsive.css
BOOTSTRAP_RESPONSIVE_LESS = ./src/responsive.less
LESS_COMPRESSOR ?= ./src/node_modules/less/bin/lessc
UGLIfYJS ?= uglifyjs
WATCHR ?= `which watchr`
THEMES = amelia cerulean cosmo cyborg flatly journal readable simplex slate spacelab spruce superhero united

#
# BUILD SIMPLE BOOTSTRAP DIRECTORY
# lessc & uglifyjs are required
#

${THEMES}: .FORCE
	mkdir -p $@/img
	mkdir -p $@/css
	mkdir -p $@/js
	cp -v ../vendor/bootstrap/img/* $@/img/
	cp ./src/bootstrap.less bootstrap.back.less
	echo >> ./src/bootstrap.less
	echo @import\ \"./vendor/bootswatch/2/$@/{variables,bootswatch}.less\"\; >> ./src/bootstrap.less
	eval ${LESS_COMPRESSOR} ${BOOTSTRAP_LESS} > $@/css/bootstrap.css
	eval ${LESS_COMPRESSOR} --compress ${BOOTSTRAP_LESS} > $@/css/bootstrap.min.css
	eval ${LESS_COMPRESSOR} ${BOOTSTRAP_RESPONSIVE_LESS} > $@/css/bootstrap-responsive.css
	eval ${LESS_COMPRESSOR} --compress ${BOOTSTRAP_RESPONSIVE_LESS} > $@/css/bootstrap-responsive.min.css
	cat vendor/bootstrap/js/bootstrap-transition.js vendor/bootstrap/js/bootstrap-alert.js vendor/bootstrap/js/bootstrap-button.js vendor/bootstrap/js/bootstrap-carousel.js vendor/bootstrap/js/bootstrap-collapse.js vendor/bootstrap/js/bootstrap-dropdown.js vendor/bootstrap/js/bootstrap-modal.js vendor/bootstrap/js/bootstrap-tooltip.js vendor/bootstrap/js/bootstrap-popover.js vendor/bootstrap/js/bootstrap-scrollspy.js vendor/bootstrap/js/bootstrap-tab.js vendor/bootstrap/js/bootstrap-typeahead.js > $@/js/bootstrap.js
	eval ${UGLIfYJS} $@/js/bootstrap.js > $@/js/bootstrap.min.tmp.js
	echo "/**\n* Bootstrap.js by @fat & @mdo\n* Copyright 2012 Twitter, Inc.\n* http://www.apache.org/licenses/LICENSE-2.0.txt\n*/" > $@/js/copyright.js
	cat $@/js/copyright.js $@/js/bootstrap.min.tmp.js > $@/js/bootstrap.min.js
	rm $@/js/copyright.js $@/js/bootstrap.min.tmp.js
	mv bootstrap.back.less ./src/bootstrap.less

clean:
	cd build && rm -rf ${THEMES}

all: ${THEMES}
	rm -rf build
	mkdir -p build
	mv ${THEMES} build/
	echo "Done"

.PHONY: docs watch gh-pages .FORCE
