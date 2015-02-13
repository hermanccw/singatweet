//
//  STRecordViewInterface.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwitterKit/TwitterKit.h>

@protocol STRecordViewInterface <NSObject>

- (void) showUIWithReferenceTweet:(TWTRTweet*)tweet;

- (void) enableRecordButton;
- (void) disableRecordButton;

- (void) enablePlayButton;
- (void) disablePlayButton;


@end
