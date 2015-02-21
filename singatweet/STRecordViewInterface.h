//
//  STRecordViewInterface.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import "TheAmazingAudioEngine.h"

@protocol STRecordViewInterface <NSObject>

- (void) showUIWithReferenceTweet:(TWTRTweet*)tweet
               andAudioController:(AEAudioController*)audioController
           andAudioFileRemotePath:(NSString*)audioFileRemotePath;

- (void) enableRecordButton;
- (void) disableRecordButton;

- (void) enablePlayButton;
- (void) disablePlayButton;

- (void) updateCountDownLabelWithRemainingMS:(NSInteger)remainingMS;

@end
