.PHONY: init up down validate status
init:
	git submodule update --init --recursive

up: init
	docker compose up --build

down:
	docker compose down --remove-orphans

validate:
	docker compose config --quiet
	./scripts/check-pins.sh

status:
	git submodule status --recursive
