//
//  STListInteractorIO.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

@protocol STListTweetInteractorInput <NSObject>
- (void) findPopularTweets;
@end


@protocol STListTweetInteractorOutput <NSObject>
- (void) foundPopularTweets:(NSArray*)tweets;
@end