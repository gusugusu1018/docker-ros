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
	@docker build --tag=minaki/orb-slam:core core/.
	@docker build --tag=minaki/orb-slam:base base/.

pull:
	@docker pull minaki/orb-slam:core
	@docker pull minaki/orb-slam:base

clean:
	@docker rmi -f minaki/orb-slam:core
	@docker rmi -f minaki/orb-slam:base
