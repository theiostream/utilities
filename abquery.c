/*%%%%%
%% abquery.c
%% Created by theiostream in 24/07/2012
%% Original tool by Erica Sadun, from 'Erica Utilities'
%%
%% abquery -- Search your address book by (a relatively innacurate) name.
%% theiostream utilities
%%%%%*/

#include <stdio.h>
#import <AddressBook/AddressBook.h>
#import <CoreFoundation/CoreFoundation.h>

static void printmv(ABRecordRef person, ABPropertyID property) {
	ABMultiValueRef valueRef = ABRecordCopyValue(person, property);
	CFIndex count = ABMultiValueGetCount(valueRef);
	if (!valueRef || count <= 0) {
		if (valueRef) CFRelease(valueRef);
		return;
	}

	int i;
	for (i=0; i<count; i++) {
		CFStringRef val = (CFStringRef)ABMultiValueCopyValueAtIndex(valueRef, i);
		if (!val || CFStringGetLength(val)==0) {
			if (val) CFRelease(val);
			continue;
		}
		
		char vl[1024];
		CFStringGetCString(val, vl, sizeof(vl), kCFStringEncodingUTF8);
		printf("  %s\n", vl);
		
		CFRelease(val);
	}
}

int main(int argc, char **argv) {
	int i;
	
	if (argc <= 1) {
		// TODO: Man page?
		fprintf(stderr, "Usage: abquery <name>\n"
						"The <name> parameter accepts similarities: \"dan fer\" matches \"Däniel Ferrêira\".\n"
						"Details on /usr/share/tiutils/abquery-ex.txt\n");
		return 1;
	}
	
	CFMutableArrayRef args = CFArrayCreateMutable(NULL, 0, &kCFTypeArrayCallBacks);
	for (i=1; i<argc; i++) {
		CFStringRef str = CFStringCreateWithCString(NULL, argv[i], kCFStringEncodingUTF8);
		CFArrayAppendValue(args, str);
		CFRelease(str);
	}
	
	ABAddressBookRef ab = ABAddressBookCreate();
	CFIndex count = ABAddressBookGetPersonCount(ab);
	if (count == 0) {
		CFRelease(ab);
		
		puts("No entries on the address book database.");
		return 0;
	}
	else
		printf("Total name matches: %lu\n", count);
	
	CFArrayRef people = ABAddressBookCopyArrayOfAllPeople(ab);
	if (!people || CFArrayGetCount(people)==0) {
		if (people) CFRelease(people);
		CFRelease(ab);
		
		fprintf(stderr, "[Error] Inconsistency: ABAddressBookCopyArrayOfAllPeople returned NULL or contains no people, but address book people count is bigger than zero.\n");
		return 2;
	}
	
	for (i=0; i<count; i++) {
		ABRecordRef dude = (ABRecordRef)CFArrayGetValueAtIndex(people, i);
		if (!dude) {
			fprintf(stderr, "[Error] Null entry at index %d. Skipping.\n", i);
			continue;
		}
		
		CFStringRef name = ABRecordCopyCompositeName(dude);
		if (!name || CFStringGetLength(name)==0)
			continue;
		
		Boolean found = false;
		CFIndex j, cnt=CFArrayGetCount(args);
		for (j=0; j<cnt; j++) {
			CFStringRef str = (CFStringRef)CFArrayGetValueAtIndex(args, j);
			found = CFStringFindWithOptions(name, str, CFRangeMake(0, CFStringGetLength(name)), kCFCompareCaseInsensitive|kCFCompareDiacriticInsensitive, NULL);
			
			if (!found) break;
		}
		
		if (found) {
			// NOTE: We can have a lot more here.
			// But for now let's stick with what Erica did originally
			char nm[1024];
			CFStringGetCString(name, nm, sizeof(nm), kCFStringEncodingUTF8);
			printf("%s\n", nm);
			printmv(dude, kABPersonPhoneProperty);
			printmv(dude, kABPersonEmailProperty);
		}
	}
	
	CFRelease(people);
	CFRelease(ab);
	
	return 0;
}