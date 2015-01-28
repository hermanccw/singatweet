//
//  TWTRAPIClient.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

@class TWTRUser;
@class TWTRTweet;

/**
 *  Client for consuming the Twitter REST API.
 */
@interface TWTRAPIClient : NSObject

/**
 *  @name Initialization
 */

/**
 *  Designated initializer.
 *
 *  @param consumerKey    The consumer key of the Twitter application.
 *  @param consumerSecret The consumer secret of the Twitter application.
 */
- (instancetype)initWithConsumerKey:(NSString *)consumerKey consumerSecret:(NSString *)consumerSecret;

/**
 *  @name Completions
 */

/**
 *  A block object to be executed when the load user request is completed.
 *
 *  @param user  The Twitter User.
 *  @param error Error that will be set if the API request failed.
 */
typedef void (^TWTRLoadUserCompletion)(TWTRUser *user, NSError *error);

/**
 *  A block object to be executed when the load Tweet request is completed.
 *
 *  @param tweet The Twitter Tweet.
 *  @param error Error that will be set if the API request failed.
 */
typedef void (^TWTRLoadTweetCompletion)(TWTRTweet *tweet, NSError *error);

/**
 *  A block object to be executed when the load Tweets request is completed.
 *
 *  @param tweets Tweets that were successfully retrieved.
 *  @param error  Error that will be set if the API request failed.
 */
typedef void (^TWTRLoadTweetsCompletion)(NSArray *tweets, NSError *error);

/**
 *  A block object to be executed when the network request is completed.
 *
 *  @param response        Metadata associated with the response to a URL load request.
 *  @param data            Content data of the response.
 *  @param connectionError Error object describing the network error that occurred.
 */
typedef void (^TWTRNetworkCompletion)(NSURLResponse *response, NSData *data, NSError *connectionError);

/**
 *  @name Making Requests
 */

/**
 *  Returns a signed URL request.
 *
 *  @param method     Request method, GET, POST, PUT, DELETE, etc.
 *  @param URLString  Request URL.
 *  @param parameters Request parameters.
 *  @param error      Error that will be set if there was an error signing the request.
 */
- (NSURLRequest*)URLRequestWithMethod:(NSString *)method URL:(NSString *)URLString parameters:(NSDictionary *)parameters error:(NSError **)error;

/**
 *  Sends a twitter request.
 *
 *  @param request    The twitter user ID of the desired user.
 *  @param completion Completion block to be called on response.
 */
- (void)sendTwitterRequest:(NSURLRequest *)request completion:(TWTRNetworkCompletion)completion;

/**
 *  @name Common API Actions
 */

/**
 *  Loads a Twitter User.
 *
 *  @param userIDString The Twitter user ID of the desired user.
 *  @param completion   Completion block to be called on response.
 */
- (void)loadUserWithID:(NSString *)userIDString completion:(TWTRLoadUserCompletion)completion;

/**
 *  Loads a single Tweet from the network or cache.
 *
 *  @param tweetIDString The ID of the desired Tweet.
 *  @param completion    Completion bock to be called on response.
 */
- (void)loadTweetWithID:(NSString *)tweetIDString completion:(TWTRLoadTweetCompletion)completion;

/**
 *  Loads a series of Tweets in a batch.
 *
 *  @param tweetIDStrings An array of Tweet IDs in an array.
 *  @param completion     Completion block to be called on response. Called on main queue.
 */
- (void)loadTweetsWithIDs:(NSArray *)tweetIDStrings completion:(TWTRLoadTweetsCompletion)completion;

@end
