#!/usr/bin/make -f
# Makefile for DISTRHO Plugins #
# ---------------------------- #
# Created by falkTX, Christopher Arndt, and Patrick Desaulniers
#

# --------------------------------------------------------------
# Installation directories

DISTRHO_PLUGIN_URI = $(shell grep DISTRHO_PLUGIN_URI DistrhoPluginInfo.h | cut -d '"' -f 2)
FAUST_DSP_DIR ?= ../../faust
FAUST_ARCH_DIR ?= $(FAUST_DSP_DIR)/arch

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
LIBDIR ?= $(PREFIX)/lib
DSSI_DIR ?= $(LIBDIR)/dssi
LADSPA_DIR ?= $(LIBDIR)/ladspa
ifneq ($(MACOS_OR_WINDOWS),true)
LV2_DIR ?= $(LIBDIR)/lv2
VST_DIR ?= $(LIBDIR)/vst
endif
ifeq ($(MACOS),true)
LV2_DIR ?= /Library/Audio/Plug-Ins/LV2
VST_DIR ?= /Library/Audio/Plug-Ins/VST
endif
ifeq ($(WINDOWS),true)
LV2_DIR ?= $(COMMONPROGRAMFILES)/LV2
VST_DIR ?= $(COMMONPROGRAMFILES)/VST2
endif

USER_DSSI_DIR ?= $(HOME)/.dssi
USER_LADSPA_DIR ?= $(HOME)/.ladspa
ifneq ($(MACOS_OR_WINDOWS),true)
USER_LV2_DIR ?= $(HOME)/.lv2
USER_VST_DIR ?= $(HOME)/.vst
endif
ifeq ($(MACOS),true)
USER_LV2_DIR ?= $(HOME)/Library/Audio/Plug-Ins/LV2
USER_VST_DIR ?= $(HOME)/Library/Audio/Plug-Ins/VST
endif
ifeq ($(WINDOWS),true)
USER_LV2_DIR ?= $(APPDATA)/LV2
USER_VST_DIR ?= $(APPDATA)/VST
endif

# --------------------------------------------------------------
# Project name, used for binaries

NAME = korg35hpf

# --------------------------------------------------------------
# FAUST DSP source
FAUST_DSP_SOURCE = $(FAUST_DSP_DIR)/$(NAME).dsp
FAUST_IDENTIFIER := $(shell grep 'declare name' $(FAUST_DSP_SOURCE) | cut -f 2 -d '"')

# --------------------------------------------------------------
# Plugin types to build

BUILD_LV2 ?= true
BUILD_VST2 ?= true
BUILD_JACK ?= false
BUILD_DSSI ?= false
BUILD_LADSPA ?= true

# --------------------------------------------------------------
# Files to build

FILES_DSP = \
	$(FAUST_IDENTIFIER).cpp \
	PluginKorg35HPF.cpp

# --------------------------------------------------------------
# Do some magic

include ../../dpf/Makefile.plugins.mk

# --------------------------------------------------------------
# Enable all selected plugin types

ifeq ($(BUILD_LV2),true)
ifeq ($(HAVE_DGL),true)
TARGETS += lv2_sep
else
TARGETS += lv2_dsp
endif
endif

ifeq ($(BUILD_VST2),true)
TARGETS += vst
endif

ifeq ($(BUILD_JACK),true)
ifeq ($(HAVE_JACK),true)
TARGETS += jack
endif
endif

ifeq ($(BUILD_DSSI),true)
ifneq ($(MACOS_OR_WINDOWS),true)
ifeq ($(HAVE_DGL),true)
ifeq ($(HAVE_LIBLO),true)
TARGETS += dssi
endif
endif
endif
endif

ifeq ($(BUILD_LADSPA),true)
TARGETS += ladspa
endif

# --------------------------------------------------------------
# Make targets

all: $(TARGETS)

# --------------------------------------------------------------
# Generate C++ source & header from FAUST DSP source

$(BUILD_DIR)/$(FAUST_IDENTIFIER).cpp.o: $(FAUST_IDENTIFIER).hpp $(FAUST_IDENTIFIER).cpp

$(FAUST_IDENTIFIER).cpp: $(FAUST_DSP_SOURCE)
	faustpp -DIdentifier=$(FAUST_IDENTIFIER) -a $(FAUST_ARCH_DIR)/generic.cpp $< > $@

$(FAUST_IDENTIFIER).hpp: $(FAUST_DSP_SOURCE)
	faustpp -DIdentifier=$(FAUST_IDENTIFIER) -a $(FAUST_ARCH_DIR)/generic.hpp $< > $@

# --------------------------------------------------------------
# Installation

install: all
ifeq ($(BUILD_DSSI),true)
ifneq ($(MACOS_OR_WINDOWS),true)
ifeq ($(HAVE_DGL),true)
ifeq ($(HAVE_LIBLO),true)
	@mkdir -p -m755 $(DESTDIR)$(DSSI_DIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)-dssi$(LIB_EXT) $(DESTDIR)$(DSSI_DIR)
endif
endif
endif
endif
ifeq ($(BUILD_LADSPA),true)
	@mkdir -p -m755 $(DESTDIR)$(LADSPA_DIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)-ladspa$(LIB_EXT) $(DESTDIR)$(LADSPA_DIR)
endif
ifeq ($(BUILD_VST2),true)
	@mkdir -p -m755 $(DESTDIR)$(VST_DIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)-vst$(LIB_EXT) $(DESTDIR)$(VST_DIR)
endif
ifeq ($(BUILD_LV2),true)
	@mkdir -p -m755 $(DESTDIR)$(LV2_DIR)/$(NAME).lv2 && \
	  install -m755 $(TARGET_DIR)/$(NAME).lv2/*$(LIB_EXT) $(DESTDIR)$(LV2_DIR)/$(NAME).lv2 && \
	  install -m644 $(TARGET_DIR)/$(NAME).lv2/*.ttl $(DESTDIR)$(LV2_DIR)/$(NAME).lv2
endif
ifeq ($(BUILD_JACK),true)
ifeq ($(HAVE_JACK),true)
	@mkdir -p -m755 $(DESTDIR)$(BINDIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)$(APP_EXT) $(DESTDIR)$(BINDIR)
endif
endif

install-user: all
ifeq ($(BUILD_DSSI),true)
ifneq ($(MACOS_OR_WINDOWS),true)
ifeq ($(HAVE_DGL),true)
ifeq ($(HAVE_LIBLO),true)
	@mkdir -p -m755 $(USER_DSSI_DIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)-dssi$(LIB_EXT) $(USER_DSSI_DIR)
endif
endif
endif
endif
ifeq ($(BUILD_LADSPA),true)
	@mkdir -p -m755 $(USER_LADSPA_DIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)-ladspa$(LIB_EXT) $(USER_LADSPA_DIR)
endif
ifeq ($(BUILD_VST2),true)
	@mkdir -p -m755 $(USER_VST_DIR) && \
	  install -m755 $(TARGET_DIR)/$(NAME)-vst$(LIB_EXT) $(USER_VST_DIR)
endif
ifeq ($(BUILD_LV2),true)
	@mkdir -p -m755 $(USER_LV2_DIR)/$(NAME).lv2 && \
	  install -m755 $(TARGET_DIR)/$(NAME).lv2/*$(LIB_EXT) $(USER_LV2_DIR)/$(NAME).lv2 && \
	  install -m644 $(TARGET_DIR)/$(NAME).lv2/*.ttl $(USER_LV2_DIR)/$(NAME).lv2
endif
ifeq ($(BUILD_JACK),true)
ifeq ($(HAVE_JACK),true)
	@mkdir -p -m755 $(HOME)/bin && \
	  install -m755 $(TARGET_DIR)/$(NAME)$(APP_EXT) $(HOME)/bin
endif
endif

# --------------------------------------------------------------

lv2lint:
	@echo "Please make sure you have the https://github.com/KXStudio/LV2-Extensions bundles"
	@echo "installed somewhere on your LV2_PATH."
	lv2lint -s lv2_generate_ttl $(DISTRHO_PLUGIN_URI)

# --------------------------------------------------------------

.PHONY: all install install-user lv2lint
