all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build            - build image"
	@echo "   2. make pull             - pull image"
	@echo "   3. make clean            - remove image"
	@echo ""

build:
	@docker build --tag=minaki/lsd-slam:core core/.
	@docker build --tag=minaki/lsd-slam:base base/.

pull:
	@docker pull minaki/lsd-slam:core
	@docker pull minaki/lsd-slam:base

clean:
	@docker rmi -f minaki/lsd-slam:core
	@docker rmi -f minaki/lsd-slam:base
