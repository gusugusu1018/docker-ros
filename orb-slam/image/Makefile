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
	@docker build --tag=minaki/ros:core core/.
	@docker build --tag=minaki/orb-slam:base base/.
	@docker build --tag=minaki/orb-slam:full full/.

pull:
	@docker pull minaki/ros:core
	@docker pull minaki/orb-slam:base
	@docker pull minaki/orb-slam:full

clean:
	@docker rmi -f minaki/ros:core
	@docker rmi -f minaki/orb-slam:base
	@docker rmi -f minaki/orb-slam:full
