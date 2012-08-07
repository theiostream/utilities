include theos/makefiles/common.mk

TOOL_NAME = tabquery say

tabquery_FILES = abquery.c
tabquery_FRAMEWORKS = CoreFoundation AddressBook

say_FILES = say.m
say_FRAMEWORKS = Foundation
say_PRIVATE_FRAMEWORKS = VoiceServices

include $(THEOS_MAKE_PATH)/tool.mk
