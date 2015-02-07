//
//  STListTweetInteractor.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STListTweetInteractor.h"
@interface STListTweetInteractor()
@property (nonatomic, strong) STListTweetDataManager *dataManager;
@end
    

@implementation STListTweetInteractor

- (instancetype)initWithDataManager:(STListTweetDataManager *)dataManager {
    self = [super init];
    if (self) {
        self.dataManager = dataManager;
    }
    return self;
}

- (void)findPopularTweets {
    [self.dataManager popularTweets:^(NSArray *tweets) {
        [self.output foundPopularTweets:tweets];
    }];
}

@end
