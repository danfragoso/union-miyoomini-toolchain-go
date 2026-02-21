.PHONY: shell
.PHONY: clean
	
TOOLCHAIN_NAME=miyoomini-toolchain-go
WORKSPACE_DIR := $(shell pwd)/workspace
INCLUDE_DIR := $(shell pwd)/include
LIB_DIR := $(shell pwd)/lib

.build: Dockerfile
	mkdir -p ./workspace
	docker build --platform linux/amd64 -t $(TOOLCHAIN_NAME) .
	touch .build

shell: .build
	docker run --platform linux/amd64 -it --rm -v "$(WORKSPACE_DIR)":/root/workspace -v "$(INCLUDE_DIR)":/root/include -v "$(LIB_DIR)":/root/lib $(TOOLCHAIN_NAME) /bin/bash

clean:
	docker rmi $(TOOLCHAIN_NAME)
	rm -f .build
