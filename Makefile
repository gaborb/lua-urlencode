SHELL=/bin/bash
.PHONY: test

test:
	docker-compose up
	docker-compose run lua busted