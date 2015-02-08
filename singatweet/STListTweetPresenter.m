//
//  STListTweetPresenter.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STListTweetPresenter.h"
#import "STListTweetViewInterface.h"

@implementation STListTweetPresenter

#pragma mark - STListModuleInteface
- (void)updateTweets {
    [self.interactor findPopularTweets];
}

#pragma mark - STListTweetInteractorOutput
- (void)foundPopularTweets:(NSArray *)tweets {
    [self.userInterface showDisplayTweets:tweets];
}

@end
