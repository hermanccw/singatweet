//
//  STTwitterViewDelegateHandler.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STTwitterViewDelegateHandler.h"

@interface STTwitterViewDelegateHandler()
@property (nonatomic, strong) STListTweetViewController *controller;
@end

@implementation STTwitterViewDelegateHandler

- (instancetype) initWithController:(STListTweetViewController*)controller {
    self = [super init];
    if (self) {
        self.controller = controller;
    }
    return self;
}

#pragma mark - NSDataViewDelegate


//- (void)tweetView:(NSDataView *)tweetView didSelectTweet:(NSData *)tweet {
//    NSLog(@"here");
//}



@end
