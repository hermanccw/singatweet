//
//  TWTRTweetTableViewCell.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWTRTweet;
@class TWTRTweetView;

/**
 *  A table view cell subclass which displays a tweet.
 */
@interface TWTRTweetTableViewCell : UITableViewCell

/**
 *  The tweet view inside this cell. Holds all relevant text and images.
 */
@property (nonatomic, strong) TWTRTweetView *tweetView;

/**
 *  Configures the existing tweet view with a tweet. Updates labels, images, and thumbnails.
 *
 *  @param tweet The TWTRTweet model object for the tweet to display.
 */
- (void)configureWithTweet:(TWTRTweet*)tweet;

/**
 *  Returns the height calculated using autolayout. Generally just for use with prototype cells.
 *
 *  @param width The table view cell width.
 */
- (CGFloat)calculatedHeightForWidth:(CGFloat)width;

@end
