# --------------------------------------------------------------------
# Copyright (c) 2019 LINKIT, The Netherlands. All Rights Reserved.
# Author(s): Anthony Potappel
# 
# This software may be modified and distributed under the terms of the
# MIT license. See the LICENSE file for details.
# --------------------------------------------------------------------
# There should be no need to change this,
# if you do you'll also need to update docker-compose.yml
SERVICE_TARGET := pyshipper

# If you see pwd_unknown showing up, this is why. Re-calibrate your system.
PWD ?= pwd_unknown

# retrieve NAME from /variables file
SLUG_MODULE_NAME = \
	$(shell awk -F= '/^SLUG\ ?=/{gsub(/\47|"/, "", $$NF);print $$NF;exit}' variables)
MODULE_NAME = \
	$(shell awk -F= '/^NAME\ ?=/{gsub(/\47|"/, "", $$NF);print $$NF;exit}' variables)
MODULE_VERSION = \
	$(shell awk -F= '/^VERSION\ ?=/{gsub(/\47|"/, "", $$NF);print $$NF;exit}' variables)

# if vars not set specifially: try default to environment, else fixed value.
# strip to ensure spaces are removed in future editorial mistakes.
# tested to work consistently on popular Linux flavors and Mac.

# allow override by adding user= and/ or uid=  (lowercase!).
# uid= defaults to 0 if user= set (i.e. root).
HOST_USER = nodummy
HOST_UID = $(strip $(if $(uid),$(uid),0))


# cli prefix for commands to run in container
RUN_DOCK = \
docker-compose -p $(SLUG_MODULE_NAME)_$(HOST_UID) up --build && docker-compose run --rm $(SERVICE_TARGET) sh -l -c
#	docker-compose -p $(SLUG_MODULE_NAME)_$(HOST_UID) build  && docker-compose up --rm $(SERVICE_TARGET) sh -l -c
#	docker-compose build && docker-compose up && docker-compose -p $(MODULE_NAME)_$(HOST_UID) run --rm $(SERVICE_TARGET) sh -l -c

# export such that its passed to shell functions for Docker to pick up.
export SLUG_MODULE_NAME
export MODULE_NAME
export HOST_USER
export HOST_UID



.PHONY: install shell test help 

default: help 
help:
	@echo "Available commands:"
	@sed -n '/^[a-zA-Z0-9_.]*:/s/:.*//p' <Makefile | sort

install:
	pip install -e .

test:
	py.test -v

shell:
	$(RUN_DOCK) "cd ~/$(MODULE_NAME) \
		&& ([ -d "$(MODULE_NAME)" ] || ln -sf module "$(MODULE_NAME)") \
		&& bash"
