//
//  STListTweetInteractor.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STListTweetInteractor.h"
#import "EXTScope.h"

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
    @weakify(self)
    [self.dataManager popularTweets:^(NSArray *tweets) {
        @strongify(self)
        [self.output foundPopularTweets:tweets];
    }];
}

@end
