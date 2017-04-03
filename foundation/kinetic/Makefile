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

pull:
	@docker pull minaki/ros-kinetic:core

clean:
	@docker rmi -f minaki/ros-kinetic:core
