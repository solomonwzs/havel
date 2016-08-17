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
