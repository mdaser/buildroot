################################################################################
#
# Linux Magazin Kern Technik Series
# (https://www.linux-magazin.de/ausgaben/2023/11/kern-technik/)
#
################################################################################

KERN_TECHNIK_VERSION = 1.0
KERN_TECHNIK_SITE = board/pine64/pine64plus/source
KERN_TECHNIK_SITE_METHOD = local

_ISYSTEM_DIR = $(BUILD_DIR)/linux-headers-$(LINUX_VERSION)/tools/include/nolibc
KERN_TECHNIK_FLAGS = -isystem $(_ISYSTEM_DIR) -nostdlib -nolibc -no-pie -fno-stack-protector -fno-asynchronous-unwind-tables -Os

define KERN_TECHNIK_BUILD_CMDS
	$(TARGET_CC) $(KERN_TECHNIK_FLAGS) $(@D)/map/maps.c -o $(@D)/map/maps
	$(TARGET_CC) $(KERN_TECHNIK_FLAGS) $(@D)/map/smaps.c -o $(@D)/map/smaps
endef

define KERN_TECHNIK_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/map/maps $(TARGET_DIR)/root/map/maps
	$(INSTALL) -D -m 0755 $(@D)/map/maps $(TARGET_DIR)/root/map/smaps
endef

$(eval $(generic-package))
