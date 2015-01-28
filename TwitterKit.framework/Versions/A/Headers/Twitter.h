//
//  Twitter.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import "TwitterKit.h"
#import "TWTRAPIClient.h"
#import "TWTRSession.h"

/**
 *  The central class of the Twitter kit.
 */
@interface Twitter : NSObject

/**
 *  Returns the Twitter singleton.
 *
 *  @return The Twitter singleton.
 */
+ (Twitter *)sharedInstance;

/**
 *  Initialize Twitter with your consumer key and secret. These will override any credentials
 *  present in your applications Info.plist.
 *
 *  You do not need to call this method unless you wish to provide credentials other than those
 *  in your Info.plist.
 *
 *  @param consumerKey    Your Twitter application's consumer key.
 *  @param consumerSecret Your Twitter application's consumer secret.
 *
 *  @return The shared Twitter object.
 */
- (instancetype)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;

/**
 *  Client for consuming the Twitter REST API.
 *
 *  This API client is configured with your consumer key and secret if they are available to the Twitter
 *  object (either via initialization of the Twitter instance or your application's Info.plist).
 *
 *  @warning To make authenticated requests, you need to call `loginWithCompletion:` or `loginGuestWithCompletion:`.
 */
@property (nonatomic, strong, readonly) TWTRAPIClient *APIClient;

/**
 *  The current version of this kit.
 */
@property (nonatomic, copy, readonly) NSString *version;

/**
 *  The Twitter application consumer key.
 */
@property (nonatomic, copy, readonly) NSString *consumerKey;

/**
 *  The Twitter application consumer secret.
 */
@property (nonatomic, copy, readonly) NSString *consumerSecret;

/**
 *  @name Authentication
 */

/**
 *  Triggers user authentication with Twitter.
 *
 *  This method will present UI to allow the user to log in if there are no saved Twitter login credentials.
 *
 *  @param completion The completion block will be called after authentication is successful or if there is an error.
 *  @warning This method requires that you have set up your `consumerKey` and `consumerSecret`.
 */
- (void)logInWithCompletion:(TWTRLoginCompletion)completion;

/**
 *  Triggers user authentication with Twitter. Allows the developer to specify the presenting view controller.
 *
 *  This method will present UI to allow the user to log in if there are no saved Twitter login credentials.
 *
 *  @param viewController The view controller that will be used to present the authentication view.
 *  @param completion The completion block will be called after authentication is successful or if there is an error.
 *  @warning This method requires that you have set up your `consumerKey` and `consumerSecret`.
 */
- (void)logInWithViewController:(UIViewController*)viewController completion:(TWTRLoginCompletion)completion;

/**
 *  Log in a guest user. This can be used when the user is not a Twitter user.
 *
 *  This method will not present any UI to the user.
 *
 *  @param completion The completion block will be called after authentication is successful or if there is an error.
 *  @warning This method requires that you have set up your `consumerKey` and `consumerSecret`.
 */
- (void)logInGuestWithCompletion:(TWTRGuestLoginCompletion)completion;

/**
 *  Returns the current user session or nil if there is no logged in user.
 *
 *  @return Returns the current user session or nil if there is no logged in user.
 */
- (TWTRSession *)session;

/**
 *  Returns the current guest session or nil if there is no logged in guest.
 *
 *  @return Returns the current guest session or nil if there is no logged in guest.
 */
- (TWTRGuestSession *)guestSession;

/**
 *  Logs out and clears the user session.
 */
- (void)logout;

/**
 *  Logs out and clears the guest session.
 */
- (void)logoutGuest;

@end
