//
//  STRecordingTweetView.h
//  singatweet
//
//  Created by Herman Chan on 2015-01-26.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STRecordingTweetView : UIView

@property (nonatomic, weak) IBOutlet UILabel *twitterHandle;
@property (nonatomic, weak) IBOutlet UILabel *tweetText;
@property (nonatomic, weak) IBOutlet UIImageView *avatar;

@end
