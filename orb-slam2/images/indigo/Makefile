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
	@docker build --tag=minaki/orb-slam2-indigo:core core/.
#	@docker build --tag=minaki/orb-slam2:base base/.

pull:
	@docker pull minaki/orb-slam2-indigo:core
#	@docker pull minaki/orb-slam2:base

clean:
	@docker rmi -f minaki/orb-slam2-indigo:core
#	@docker rmi -f minaki/orb-slam2:base
