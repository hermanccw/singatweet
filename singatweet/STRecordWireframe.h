//
//  STRecordWireframe.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <TwitterKit/TwitterKit.h>
@import UIKit;

@class STRecordPresenter;
@class STRecordViewController;
@class STRootViewWireframe;

@interface STRecordWireframe : NSObject

@property (nonatomic, strong) STRecordPresenter *recordPresenter;

- (void)presentRecordInterfaceFromViewController:(UIViewController *)viewController withTweet:(NSData*)tweet;
- (void)dismissRecordInterface;

@end
