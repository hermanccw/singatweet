//
//  TwitterKit.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#if __has_feature(modules)
@import Accounts;
@import Foundation;
@import Social;
@import UIKit;
#else
#import <Accounts/Accounts.h>
#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <UIKit/UIKit.h>
#endif

#import "Twitter.h"
#import "TWTRAPIClient.h"
#import "TWTRAPIErrorCode.h"
#import "TWTRConstants.h"
#import "TWTRSession.h"
#import "TWTRTweetTheme.h"
#import "TWTRTweet.h"
#import "TWTRTweetTableViewCell.h"
#import "TWTRTweetTableViewCell.h"
#import "TWTRTweetView.h"
#import "TWTRTweetViewDelegate.h"
#import "TWTRUser.h"

/**
 *  `TwitterKit` can be used as an element in the array passed to the `with:` API of the SDK.
 */
#define TwitterKit [[Twitter alloc] init]
