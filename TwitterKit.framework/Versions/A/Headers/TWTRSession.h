//
//  TWTRSession.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  Authorization configuration details. Ecapsulates credentials required to authenticate a Twitter application. You can obtain your credentials at https://apps.twitter.com/.
 */
@interface TWTRAuthConfig : NSObject

/**
 *  The consumer key of the Twitter application.
 */
@property (nonatomic, copy, readonly) NSString *consumerKey;
/**
 *  The consumer secret of the Twitter application.
 */
@property (nonatomic, copy, readonly) NSString *consumerSecret;

/**
 *  Returns an `TWTRAuthConfig` object initialized by copying the values from the consumer key and consumer secret.
 *
 *  @param consumerKey The consumer key.
 *  @param consumerSecret The consumer secret.
 *  @warning Raises an exception if consumer key or consumer secret is nil.
 */
- (instancetype)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;

/**
 *  Use `initWithConsumerKey:consumerSecret:` instead.
 */
- (instancetype)init __unavailable;

@end

/**
 *  TWTRSession represents a user's session authenticated with the Twitter API.
 */
@interface TWTRSession : NSObject

/**
 *  The authorization token.
 */
@property (nonatomic, copy, readonly) NSString *authToken;
/**
 *  The authorization token secret.
 */
@property (nonatomic, copy, readonly) NSString *authTokenSecret;
/**
 *  The username associated with the access token.
 */
@property (nonatomic, copy, readonly) NSString *userName;
/**
 *  The user ID associated with the access token.
 */
@property (nonatomic, copy, readonly) NSString *userID;

/**
 *  Returns an `TWTRSession` object initialized by copying the values from the dictionary.
 *
 *  @param sessionDictionary The dictionary receieved after successfull authentication from Twitter OAuth.
 *  @warning Raises an exception if `sessionDictionary` is nil.
 */
- (instancetype)initWithSessionDictionary:(NSDictionary *)sessionDictionary;

/**
 *  Use `initWithSessionDictionary:` instead.
 */
- (instancetype)init __unavailable;

@end

/**
 *  TWTRSession represents a guest session authenticated with the Twitter API. See TWTRSession for user sessions.
 */
@interface TWTRGuestSession : NSObject
/**
 *  The bearer access token for guest auth.
 */
@property (nonatomic, copy, readonly) NSString *accessToken;
/**
 *  The guest access token.
 */
@property (nonatomic, copy, readonly) NSString *guestToken;

/**
 *  Returns an `TWTRGuestSession` object initialized by copying the values from the dictionary.
 *
 *  @param sessionDictionary The dictionary receieved after successfull authentication from Twitter guest-only authentication.
 *  @important Raises an exception if `sessionDictionary` is nil.
 */
- (instancetype)initWithSessionDictionary:(NSDictionary *)sessionDictionary;

/**
 *  Use `initWithSessionDictionary:` instead.
 */
- (instancetype)init __unavailable;

@end

/**
 *  Completion block for user authentication.
 *
 *  @param session contains the OAuth tokens and minimal information associated with the logged in user or nil.
 *  @param error error that will be non nil if the authentication request failed.
 */
typedef void (^TWTRLoginCompletion)(TWTRSession *session, NSError *error);

/**
 *  Completion block for guest authentication.
 *
 *  @param guestSession A TWTRGuestSession containing the OAuth tokens or nil.
 *  @param error Error that will be non nil if the authentication request failed.
 */
typedef void (^TWTRGuestLoginCompletion)(TWTRGuestSession *guestSession, NSError *error);
