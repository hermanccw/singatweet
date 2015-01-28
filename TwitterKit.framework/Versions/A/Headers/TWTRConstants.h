//
//  TWTRConstants.h
//
//  Copyright (c) 2014 Twitter. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Error messages

FOUNDATION_EXPORT NSString * const TWTRErrorDomain;

/**
 *  The NSError domain of errors surfaced by the Twitter SDK.
 */
typedef NS_ENUM(NSInteger, TWTRErrorCode) {
    /**
     *  Unknown error.
     */
    TWTRErrorCodeUnknown = -1,
    /**
     *  Authentication has not been set up yet. You must call [Twitter logInWithCompletion:] or [Twitter logInGuestWithCompletion:]
     */
    TWTRErrorCodeNoAuthentication  = 0
};
