//
//  STListTweetWireframe.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@class STListTweetPresenter;
@class STListTweetViewController;
@class STRootViewWireframe;
@class STRecordWireframe;
@class TWTRTweet;

@interface STListTweetWireframe : NSObject

@property (nonatomic, strong) STListTweetPresenter *listPresenter;
@property (nonatomic, strong) STRecordWireframe *recordWireframe;
@property (nonatomic, strong) STRootViewWireframe *rootWireframe;

- (void)presentListInterfaceFromWindow:(UIWindow *)window;
- (void)presentRecordInterfaceWithTweet:(TWTRTweet*)tweet;

@end
