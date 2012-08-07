/**
 * Name: say
 * Description: example text-to-speech command for iPhone OS,
 *              using built-in TTS engine of iPhone 3GS
 * Author: Lance Fetters (aka. ashikase)
 * Last-modified: 2012-05-22 22:52:39 (by theiostream)
 */

/**
 * Copyright (C) 2009  Lance Fetters (aka. ashikase)
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 *
 * 3. The name of the author may not be used to endorse or promote
 *    products derived from this software without specific prior
 *    written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS
 * OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING
 * IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>
#import <VoiceServices/VSSpeechSynthesizer.h>
#include <stdio.h>
#include <unistd.h>

static void wait_for_end(int slp) {
	while ([VSSpeechSynthesizer isSystemSpeaking])
		usleep(slp);
}

int main(int argc, char **argv) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    NSArray *args = [NSArray arrayWithArray:[[NSProcessInfo processInfo] arguments]];
    NSString *cmd = [args objectAtIndex:0];
    
    NSArray *qry = [args subarrayWithRange:NSMakeRange(1, [args count]-1)];
    NSString *string = [qry componentsJoinedByString:@" "];
    if (![string isEqualToString:@""]) {
        wait_for_end(1000);
        
        VSSpeechSynthesizer *speechSynth = [[[VSSpeechSynthesizer alloc] init] autorelease];
        [speechSynth startSpeakingString:string toURL:nil withLanguageCode:@"en-US"];
    	
    	wait_for_end(100);
    }
    
    else
        fprintf(stderr, "Usage: %s <string to speak>\n", [cmd UTF8String]);

    [pool drain];
    return 0;
}