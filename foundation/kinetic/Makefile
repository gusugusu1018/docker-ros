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
	@docker build --tag=minaki/ros-kinetic:core core/.
	@docker build --tag=minaki/ros-kinetic:core base/.

pull:
	@docker pull minaki/ros-kinetic:core
	@docker pull minaki/ros-kinetic:base

clean:
	@docker rmi -f minaki/ros-kinetic:core
	@docker rmi -f minaki/ros-kinetic:base
