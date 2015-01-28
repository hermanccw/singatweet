//
//  TWTRTweetViewDelegate.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TWTRTweetView;
@class TWTRTweet;

/**
 *  Delegate for TWTRTweetView to determine which view controller is used to present new view controllers. Used for things like tapping on the background, on the profile thumbnail, and potential on action buttons in the future.
 */
@protocol TWTRTweetViewDelegate <NSObject>

/**
 *  Asks the delegate for the UIViewController used to present webviews.
 * 
 *  @return The UIViewController used to present webviews.
 */
- (UIViewController*)viewControllerForPresentation;

@optional

- (void)didTapTweetView:(TWTRTweetView *)tweetView showingTweet:(TWTRTweet *)tweet;

- (void)didTapURL:(NSURL *)url fromTweet:(TWTRTweet *)tweet;

- (void)didTapShareForTweet:(TWTRTweet *)tweet;

- (void)didCompleteActivity:(NSString *)activityType forTweet:(TWTRTweet *)tweet;

@end
