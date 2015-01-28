//
//  TWTRTweetView.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWTRTweetViewDelegate.h"

@class TWTRTweet;
@class TWTRTweetTheme;

/**
 *  The style for tweet views.
 */
typedef NS_ENUM(NSUInteger, TWTRTweetViewStyle) {
    /**
     *  A full-size tweet view showing images as well.
     */
    TWTRTweetViewStyleRegular,
    /**
     *  A small tweet view showing no images, primarily designed
     *  to be placed inside table views.
     */
    TWTRTweetViewStyleCompact
};

/**
 `TWTRTweetView` displays a single tweet to the user. It handles background taps and other actions displayed to the user.
 
    [[[Twitter sharedInstance] APIClient] loadTweetWithID:@"20" completion:^(TWTRTweet *tweet, NSError *error) {
        if (tweet) {
            TWTRTweetView *tweetView = [[TWTRTweetView alloc] initWithTweet:tweet];
            [self.view addSubview:tweetView];
        } else {
            NSLog(@"Error loading tweet: %@", [error localizedDescription]);
        }
    }];

 ## Interaction
 
 To allow the tweet view to present new views to the user, the `delegate` property must be set. Generally this will be set to `self` inside the `UIViewController` subclass which implements the TWTRTweetViewDelegate protocol.
 
    - (UIViewController *)viewControllerForPresentation {
        return self;
    }
 
 ## Usage in UITableView
 
 To allow for usage in `UITableView`s, the `configureWithTweet:` method allows configuration of an existing `TWTRTweetView` without having to create a new instance.
 
 ## Sizing
 
 When using autolayout, feel free to set a width or margin on the tweet view. The height will be calculated automatically. For old-fashioned frame based layout you may use the standard `sizeThatFits:` method to calculate the appropriate height for a given width:
 
    // Find the height for a given width (20pts on either side)
    CGFloat desiredSize = [tweetView sizeThatFits:CGSizeMake(self.view.frame.size.width - 40, CGFLOAT_MAX);
 
 ## UIAppearance
 
 You may use UIAppearance proxy objects to style certain aspects of tweet views (or whole themes) before those views are added to the view hierarchy.
 
     // Using UIAppearance Proxy
     [TWTRTweetView appearance].theme = [TWTRTweetTheme darkTheme];
 
     // Setting theme directly
     TWTRTweetTheme *blueYellowTheme = [TWTRTweetTheme lightTheme];
     blueYellowTheme.primaryTextColor = [UIColor yellowColor];
     blueYellowTheme.backgroundColor = [UIColor blueColor];
     [TWTRTweetView appearance].theme = blueYellowTheme;
 
 _Note:_ You can't change the theme through an appearance proxy after the view has already been added to the view hierarchy. Direct `theme` property access will work though.
 */
@interface TWTRTweetView : UIView <UIAppearanceContainer>

/**
 *  Background color of the tweet view and all text labels (fullname, username, tweet text, timestamp).
 */
@property (nonatomic, strong) UIColor *backgroundColor UI_APPEARANCE_SELECTOR;

/**
 *  Color of tweet text and full name.
 */
@property (nonatomic, strong) UIColor *primaryTextColor UI_APPEARANCE_SELECTOR;

/**
 *  Color of tweet username and timestamp colors.
 */
@property (nonatomic, strong) UIColor *secondaryTextColor UI_APPEARANCE_SELECTOR;

/**
 *  Color of links in tweet text.
 */
@property (nonatomic, strong) UIColor *linkTextColor UI_APPEARANCE_SELECTOR;

/**
 *  Set whether the border should be shown.
 */
@property (nonatomic, assign) BOOL showBorder UI_APPEARANCE_SELECTOR;

/**
 *  Theme of this tweet.
 *
 *  Set to [TWTRTweetTheme lightTheme] by default.
 */
@property (nonatomic, strong) TWTRTweetTheme *theme UI_APPEARANCE_SELECTOR;

/**
 *  The style of the tweet. i.e. TWTRTweetViewStyleRegular or TWTRTweetViewStyleCompact.
 */
@property (nonatomic, assign) TWTRTweetViewStyle style;

/**
 *  The optional delegate to allow presenting a webview with tweet details.
 */
@property (nonatomic, weak) IBOutlet id<TWTRTweetViewDelegate> delegate;

/**
 *  Convenience initializer to configure a compact style tweet view.
 *
 *  @param tweet The tweet to display.
 *
 *  @return The fully-configured tweet view.
 */
- (instancetype)initWithTweet:(TWTRTweet *)tweet;

/**
 *  Designated initializer. Initializes view with both tweet and style.
 *
 *  @param tweet The tweet to display.
 *  @param style The style of tweetview (regular or compact).
 *
 *  @return The fully configured tweet view.
 */
- (instancetype)initWithTweet:(TWTRTweet *)tweet style:(TWTRTweetViewStyle)style;

/**
 *  Update all images and label text to fully represent the given tweet.
 *
 *  @param tweet The tweet to display.
 */
- (void)configureWithTweet:(TWTRTweet *)tweet;

@end
