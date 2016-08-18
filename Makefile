# vim: noet:

DIR = $(shell pwd)
REBAR := $(DIR)/rebar

all:
	@$(REBAR) get-deps compile
	@echo "compile finish."

quick_compile:
	@$(REBAR) compile
	@echo "compile finish."

clean:
	@rm ebin/*
	@echo "clean finish"

gen_ssl_key:
	@mkdir -p dev/ssl
	@openssl req -x509 -nodes -newkey rsa:2048 -keyout dev/ssl/server.key -out dev/ssl/server.crt
