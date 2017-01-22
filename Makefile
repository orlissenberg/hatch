.PHONY:  default run build docs test install clean

GO_EXECUTABLE ?= go
CURRENT_DIR := $(shell pwd)
TMP_DIR := $(CURRENT_DIR)/tmp
MKDOCS_BIN := $(shell which mkdocs)

default: run

build:
	@go build -o ./bin/hatch ./src/hatch.go

test:
	@echo "[running tests]"

install:
	@echo "[installing]"

docs:
	@echo "building docs"
	@mkdocs build

clean:
	@rm -R ./bin
	@rm -R ./site
	@mkdir ./bin -p
	@touch ./bin/.gitkeep

run: build
	@./bin/hatch

.PHONY: install-tools
install-tools: install-glide install-mkdoc

.PHONY: install-glide
# https://glide.sh/
install-glide:
ifeq ("$(wildcard ${CURRENT_DIR}/bin/glide)","")
	@echo "[installing glide]"
	@git clone https://github.com/Masterminds/glide.git ${TMP_DIR}/src/github.com/Masterminds/glide 2> /dev/null; true
	@export GOPATH=${TMP_DIR} && cd ${TMP_DIR}/src/github.com/Masterminds/glide && make build && cp ./glide ${CURRENT_DIR}/bin/glide
	@rm -Rf ${TMP_DIR}
else
	@echo "[glide already installed]"
endif

.PHONY: install-mkdoc
# http://www.mkdocs.org/
install-mkdoc:
ifeq ("${MKDOCS_BIN}","")
	@sudo apt-get install python-pip
	@sudo pip install mkdocs
	@mkdocs --version
else 
	@echo "[mkdocs already installed]"
endif

.PHONY: mkdocs-start
mkdocs-start:
	@./scripts/mkdocs.sh start

.PHONY: mkdocs-stop
mkdocs-stop:
	@./scripts/mkdocs.sh stop

.PHONY: godoc-http-start
godoc-http-start:
	@./scripts/godoc.sh start

.PHONY: godoc-http-stop
godoc-http-stop:
	@./scripts/godoc.sh stop

