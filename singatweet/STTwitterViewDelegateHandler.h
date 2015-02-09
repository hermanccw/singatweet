//
//  STTwitterViewDelegateHandler.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <TwitterKit/TwitterKit.h>
#import "STListTweetViewController.h"

@interface STTwitterViewDelegateHandler : NSObject//<NSDataViewDelegate>
- (instancetype) initWithController:(STListTweetViewController*)controller;
@end
