# Copyright (C) 2024 Project Flare
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ANDROID_VERSION := 15
FLAREVERSION := 1.0-BETA

FLARE_BUILD_TYPE ?= UNOFFICIAL
FLARE_MAINTAINER ?= UNKNOWN
FLARE_DATE_YEAR := $(shell date -u +%Y)
FLARE_DATE_MONTH := $(shell date -u +%m)
FLARE_DATE_DAY := $(shell date -u +%d)
FLARE_DATE_HOUR := $(shell date -u +%H)
FLARE_DATE_MINUTE := $(shell date -u +%M)
FLARE_BUILD_DATE := $(FLARE_DATE_YEAR)$(FLARE_DATE_MONTH)$(FLARE_DATE_DAY)-$(FLARE_DATE_HOUR)$(FLARE_DATE_MINUTE)
TARGET_PRODUCT_SHORT := $(subst flare_,,$(FLARE_BUILD))

# OFFICIAL_DEVICES
ifeq ($(FLARE_BUILD_TYPE), OFFICIAL)
  LIST = $(shell cat vendor/flare/config/flare.devices)
    ifeq ($(filter $(FLARE_BUILD), $(LIST)), $(FLARE_BUILD))
      IS_OFFICIAL=true
      FLARE_BUILD_TYPE := OFFICIAL
    endif
    ifneq ($(IS_OFFICIAL), true)
      FLARE_BUILD_TYPE := UNOFFICIAL
      $(error Device is not official "$(FLARE_BUILD)")
    endif
endif

FLARE_VERSION := $(FLAREVERSION)-$(FLARE_BUILD)-$(FLARE_BUILD_DATE)-VANILLA-$(FLARE_BUILD_TYPE)
ifeq ($(WITH_GAPPS), true)
FLARE_VERSION := $(FLAREVERSION)-$(FLARE_BUILD)-$(FLARE_BUILD_DATE)-GAPPS-$(FLARE_BUILD_TYPE)
endif
FLARE_MOD_VERSION :=$(ANDROID_VERSION)-$(FLAREVERSION)
FLARE_DISPLAY_VERSION := ProjectFlare-$(FLAREVERSION)-$(FLARE_BUILD_TYPE)
FLARE_DISPLAY_BUILDTYPE := $(FLARE_BUILD_TYPE)
FLARE_FINGERPRINT := ProjectFlare/$(FLARE_MOD_VERSION)/$(TARGET_PRODUCT_SHORT)/$(FLARE_BUILD_DATE)

# FLARE System Version
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
  ro.flare.version=$(FLARE_DISPLAY_VERSION) \
  ro.flare.build.status=$(FLARE_BUILD_TYPE) \
  ro.modversion=$(FLARE_MOD_VERSION) \
  ro.flare.build.date=$(FLARE_BUILD_DATE) \
  ro.flare.buildtype=$(FLARE_BUILD_TYPE) \
  ro.flare.fingerprint=$(FLARE_FINGERPRINT) \
  ro.flare.device=$(FLARE_BUILD) \
  org.flare.version=$(FLAREVERSION) \
  ro.flare.maintainer=$(FLARE_MAINTAINER)
