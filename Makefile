#!/usr/bin/make -f
# Makefile for DISTRHO Plugins #
# ---------------------------- #
# Created by falkTX, Christopher Arndt, and Patrick Desaulniers
#

include dpf/Makefile.base.mk


all: libs plugins gen

# --------------------------------------------------------------

submodules:
	git submodule update --init --recursive

libs:

plugins: libs
	$(MAKE) all -C plugins/diodeladder
	$(MAKE) all -C plugins/korg35lpf
	$(MAKE) all -C plugins/moogladder
	$(MAKE) all -C plugins/mooghalfladder

ifneq ($(CROSS_COMPILING),true)
gen: plugins dpf/utils/lv2_ttl_generator
	@$(CURDIR)/dpf/utils/generate-ttl.sh
ifeq ($(MACOS),true)
	@$(CURDIR)/dpf/utils/generate-vst-bundles.sh
endif

dpf/utils/lv2_ttl_generator:
	$(MAKE) -C dpf/utils/lv2-ttl-generator
else
gen: plugins dpf/utils/lv2_ttl_generator.exe
	@$(CURDIR)/dpf/utils/generate-ttl.sh

dpf/utils/lv2_ttl_generator.exe:
	$(MAKE) -C dpf/utils/lv2-ttl-generator WINDOWS=true
endif

# --------------------------------------------------------------

lv2lint:
	$(MAKE) lv2lint -C plugins/diodeladder
	$(MAKE) lv2lint -C plugins/korg35lpf
	$(MAKE) lv2lint -C plugins/moogladder
	$(MAKE) lv2lint -C plugins/mooghalfladder

# --------------------------------------------------------------

clean:
	$(MAKE) clean -C dpf/utils/lv2-ttl-generator
	$(MAKE) clean -C plugins/diodeladder
	$(MAKE) clean -C plugins/korg35lpf
	$(MAKE) clean -C plugins/moogladder
	$(MAKE) clean -C plugins/mooghalfladder
	rm -rf bin build

install: all
	$(MAKE) install -C plugins/diodeladder
	$(MAKE) install -C plugins/korg35lpf
	$(MAKE) install -C plugins/moogladder
	$(MAKE) install -C plugins/mooghalfladder

install-user: all
	$(MAKE) install-user -C plugins/diodeladder
	$(MAKE) install-user -C plugins/korg35lpf
	$(MAKE) install-user -C plugins/moogladder
	$(MAKE) install-user -C plugins/mooghalfladder

# --------------------------------------------------------------

.PHONY: all clean faust install install-user lv2lint submodule libs plugins gen
