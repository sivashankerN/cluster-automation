#SHELL := /bin/bash

CODE_DIR=build/code
DOC_DIR=build/docs
PWD=$(shell pwd)
LINT_FILE=${PWD}/${CODE_DIR}/lint_output
EXIT_FILE=${PWD}/exit.txt
STATUS=0

all: build

init: 
	./init.sh

build: init
	make -f tangle-make -k all
	cp -r src/imp/ ${CODE_DIR}/imp
#	cp -r src/images ${DOC_DIR}/images
install-pep:
	sudo pip install pep8


clean:	
	make -f tangle-make clean

