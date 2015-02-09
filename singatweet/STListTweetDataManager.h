//
//  STListTweetDataManager.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-05.
//  Copyright (c) 2015 ironark. All rights reserved.
//


#import <Foundation/Foundation.h>
//#import <TwitterKit/TwitterKit.h>

@interface STListTweetDataManager : NSObject
- (void) popularTweets:(void (^)(NSArray *tweets))completionBlock;
@end
