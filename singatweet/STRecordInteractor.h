//
//  STRecordInteractor.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>
#import "STRecordInteractorIO.h"
#import "TheAmazingAudioEngine.h"
#import "AERecorder.h"
#import <AudioToolbox/AudioToolbox.h>


@interface STRecordInteractor : NSObject<STRecordInteractorInput>

@property (nonatomic, weak) id<STRecordInteractorOutput> output;
@property (nonatomic, strong) AEAudioController *audioController;
@property (nonatomic, copy, readonly) NSString *audioFileRemotePath;


- (instancetype) initWithAudioController:(AEAudioController*)audioController;
@end
