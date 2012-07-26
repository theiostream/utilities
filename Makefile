include theos/makefiles/common.mk

TOOL_NAME = tabquery
tabquery_FILES = abquery.c
tabquery_FRAMEWORKS = CoreFoundation AddressBook

include $(THEOS_MAKE_PATH)/tool.mk
