//
//  STRecordInteractor.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@interface STRecordInteractor : NSObject
- (void) saveAudioFile:(NSData*)audio;
- (void) saveTweet:(TWTRTweet*)tweet withAudioURL:(NSString*)audioURL andReferenceTweet:(TWTRTweet*)referenceTweet;

@end
