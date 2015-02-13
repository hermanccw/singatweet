//
//  STRecordInteractorIO.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-12.
//  Copyright (c) 2015 ironark. All rights reserved.
//

@protocol STRecordInteractorInput <NSObject>
- (void)startRecordingTweet;

- (void)pauseRecordingTweet;

- (void)stopRecordingTweet;

- (void)playRecordedTweet;

- (void)saveAudioFile:(NSData*)audio;
- (void)saveTweet:(TWTRTweet*)tweet withAudioURL:(NSString*)audioURL andReferenceTweet:(TWTRTweet*)referenceTweet;
@end


@protocol STRecordInteractorOutput <NSObject>
- (void)startedRecording;

- (void)pausedRecording;

- (void)stoppedRecording;

- (void)startedToPlayRecording;

- (void)stoppedPlayingRecording;

- (void)updatedRemainingMS:(NSInteger)remainingMS;

@end
