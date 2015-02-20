//
//  STRecordPresenter.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STRecordPresenter.h"
#import "STRecordWireframe.h"
#import "STRecordInteractor.h"
#import "STRecordViewInterface.h"


@implementation STRecordPresenter

#pragma mark - STRecordModuleInterface


- (void) startComposingTweet {
  // start saving audio to server
    [self.interactor saveAudioFile];
}

- (void) associatedWithNewTweet:(TWTRTweet*)tweet withReferenceTweet:(TWTRTweet*)referenceTweet {
    
}

- (void)startRecordingTweet {
    [self.interactor startRecordingTweet];
}

- (void)pauseRecordingTweet {
    
}

- (void)stopRecordingTweet {
    [self.interactor stopRecordingTweet];
    
}

- (void)playRecordedTweet {
    [self.interactor playRecordedTweet];
}

- (void)cancelRecordAudioForTweet {
    [self.wireframe dismissRecordInterface];
}


- (void)configureUserInterfaceForPresentation:(id<STRecordViewInterface>)recordViewUserInterface
                           withReferenceTweet:(TWTRTweet*)tweet{
    self.userInterface = recordViewUserInterface;
    [recordViewUserInterface showUIWithReferenceTweet:tweet andAudioController:self.interactor.audioController];
}

#pragma mark - STRecordInteractorOutput

- (void)startedRecording {
    [self.userInterface disableRecordButton];
}

- (void)pausedRecording {
    
}

- (void)stoppedRecording {
    [self.userInterface enableRecordButton];
    
}

- (void)startedToPlayRecording {
    [self.userInterface disablePlayButton];
}

- (void)stoppedPlayingRecording {
    [self.userInterface enablePlayButton];
}

- (void)updatedRemainingMS:(NSInteger)remainingMS {
    [self.userInterface updateCountDownLabelWithRemainingMS:remainingMS];
}


- (void)uploadingAudioWithPath:(NSString*)path {
    NSLog(@"uploading to audio path: %@", path);
}

@end
