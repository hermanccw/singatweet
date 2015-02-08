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
    NSArray *tweetIDs = @[@"440322224407314432", @"426859986715553793", @"481533752477495300"];
    
    [[Twitter sharedInstance] logInGuestWithCompletion:^
     (TWTRGuestSession *session, NSError *error) {
         if (session) {
             // make API calls that do not require user auth
             [[[Twitter sharedInstance] APIClient]
              loadTweetsWithIDs:tweetIDs
              completion:^(NSArray *tweets, NSError *error) {
                  if (tweets) {
                      completionBlock(tweets);
                  }
                  else {
                      NSLog(@"Failed to load tweet: %@", [error localizedDescription]);
                  }
              }];
             
         }
         else {
             NSLog(@"error: %@", [error localizedDescription]);
         }
     }];
}

@end
