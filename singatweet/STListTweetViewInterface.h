//
//  STListTweetViewInteface.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-05.
//  Copyright (c) 2015 ironark. All rights reserved.
//

@protocol STListTweetViewInterface <NSObject>

- (void) showDisplayTweets:(NSData*)data;
- (void) reloadEntries;

@end