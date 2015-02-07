//
//  STListTweetDataManager.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-05.
//  Copyright (c) 2015 ironark. All rights reserved.
//


#import "STListTweetDataManager.h"

@implementation STListTweetDataManager


- (void) popularTweets:(void (^)(NSArray *tweets))completionBlock {
    NSArray *tweetIDs = @[@1, @2, @3];
    [[[Twitter sharedInstance] APIClient]
     loadTweetsWithIDs:tweetIDs
     completion:^(NSArray *tweets, NSError *error) {
         if (tweets) {
             completionBlock(tweets);
         } else {
             NSLog(@"Failed to load tweet: %@", [error localizedDescription]);
         }
     }];
}

@end
