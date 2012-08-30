include theos/makefiles/common.mk

TOOL_NAME = tabquery tsay tnotify_post

tabquery_FILES = abquery.c
tabquery_FRAMEWORKS = CoreFoundation AddressBook

tsay_FILES = say.m
tsay_FRAMEWORKS = Foundation
tsay_PRIVATE_FRAMEWORKS = VoiceServices

tnotify_post_FILES = notify_post.c

include $(THEOS_MAKE_PATH)/tool.mk
