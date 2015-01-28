//
//  TWTRTweetTheme.h
//  TwitterKit
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Theme object to be applied to tweet views for styling
 */
@interface TWTRTweetTheme : NSObject

/**
 *  Background for tweet views, login view controller, etc
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/**
 *  Link & button text color (share button, tweet text links, etc)
 */
@property (nonatomic, strong) UIColor *accentColor;

/**
 *  Primary text color (Full Name, Tweet text, etc)
 */
@property (nonatomic, strong) UIColor *primaryTextColor;

/**
 *  Secondary text color (username, timestamp, etc)
 */
@property (nonatomic, strong) UIColor *secondaryTextColor;

/**
 *  Official dark theme.
 *
 *  @return TWTRTweetTheme
 */
+ (instancetype)darkTheme;

/**
 *  Official light theme.
 *
 *  @return TWTRTweetTheme
 */
+ (instancetype)lightTheme;

@end
