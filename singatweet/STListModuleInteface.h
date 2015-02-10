//
//  STListModuleInteface.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-05.
//  Copyright (c) 2015 ironark. All rights reserved.
//

@class TWTRTweet;

@protocol STListModuleInteface <NSObject>

- (void) updateTweets;
- (void) startToRecordTweet:(TWTRTweet*)tweet;

@end