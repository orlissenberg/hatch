GO_EXECUTABLE ?= go
CURRENT_DIR := $(shell pwd)
TMP_DIR := $(CURRENT_DIR)/tmp

default: run

build:
	@go build -o ./bin/hatch ./src/hatch.go

test:
	echo '...'

install:
	echo '...'

clean:
	rm -R ./bin

run: build
	./bin/hatch

install-tools: install-glide

install-glide:
ifeq ("$(wildcard ${CURRENT_DIR}/bin/glide)","")
	@echo "[installing glide]"
	@git clone https://github.com/Masterminds/glide.git ${TMP_DIR}/src/github.com/Masterminds/glide 2> /dev/null; true
	@export GOPATH=${TMP_DIR} && cd ${TMP_DIR}/src/github.com/Masterminds/glide && make build && cp ./glide ${CURRENT_DIR}/bin/glide
	@rm -Rf ${TMP_DIR}
else
	@echo "[glide already installed]"
endif

.PHONY: install-glide install-tools run build test install clean default
