//
//  STRecordModuleInterface.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <TwitterKit/TwitterKit.h>

@protocol STRecordModuleInterface <NSObject>

- (void) startComposingTweet;

- (void) associatedWithNewTweet:(TWTRTweet*)tweet withReferenceTweet:(TWTRTweet*)referenceTweet;

- (void) startRecordingTweet;

- (void) pauseRecordingTweet;

- (void) stopRecordingTweet;

- (void) playRecordedTweet;

- (void) cancelRecordAudioForTweet;
@end