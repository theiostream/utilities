/*%%%%%
%% notify_post.c
%% Created by theiostream in 30/08/2012
%% Original tool by BigBoss, inside 'bigbosshackertools'
%%
%% notify_post -- post a darwin notification from the command-line
%% theiostream utilities
%%%%%*/

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <notify.h>

int main(int argc, char **argv) {
	if (argc <= 1) {
		fprintf(stderr, "Usage: notify_post [notification]\n");
		return 1;
	}
	
	size_t len = 0;
	
	int i;
	for (i=1; i<argc; i++)
		len += strlen(argv[i]);
	
	char *not = (char *)malloc(len+(argc-1)*sizeof(char));
	if (not == NULL) {
		fprintf(stderr, "Memory error.\n");
		return 2;
	}
	not[0] = '\0';
	
	for (i=1; i<argc; i++) {
		strcat(not, argv[i]);
		if (i+1 < argc) strcat(not, " ");
	}
	
	notify_post(not);
	
	free(not);
	return 0;
}