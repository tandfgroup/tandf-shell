#!/usr/bin/env bash
#
# Node/NPM Aliases

alias node-update='(cd;npm cache clean -g -f;if type "brew" &> /dev/null;then;brew update node --without-npm;else;sudo npm i -g n;sudo n stable;fi;npm cache clean -g -f)'
alias npm-update='(cd;npm cache clean -g -f;npm i -g npm@latest;npm update -g;npm cache clean -g -f)'
