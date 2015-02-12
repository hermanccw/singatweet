//
//  STRecordModuleInterface.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <TwitterKit/TwitterKit.h>

@protocol STRecordModuleInterface <NSObject>

- (void) saveAudio:(NSData*)audio forTweet:(TWTRTweet*)referenceTweet;

- (void) associatedNewTweet:(TWTRTweet*)tweet withAudioURL:(NSString*)audioURL;

- (void) startRecordingTweet;

- (void) pauseRecordingTweet;

- (void) stopRecordingTweet;

- (void) playRecordedTweet;

- (void) cancelRecordAudioForTweet;
@end