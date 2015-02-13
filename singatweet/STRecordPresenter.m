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
- (void)saveAudio:(NSData*)audio forTweet:(TWTRTweet*)referenceTweet {
    
}

- (void)associatedNewTweet:(TWTRTweet*)tweet withAudioURL:(NSString*)audioURL {
    
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
    [recordViewUserInterface showUIWithReferenceTweet:tweet];
}

#pragma mark - STRecordInteractorOutput

- (void)startedRecording {
    
}

- (void)pausedRecording {
    
}

- (void)stoppedRecording {
    
}

- (void)startedToPlayRecording {
    
}

- (void)stoppedPlayingRecording {
    
}

- (void)updatedRemainingMS:(NSInteger)remainingMS {
    
}

@end
