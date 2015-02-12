//
//  ViewController.h
//  singatweet
//
//  Created by Herman Chan on 2015-01-15.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STRecordingTweetView.h"
#import "STRecordViewInterface.h"
#import "STRecordModuleInterface.h"

@interface STRecordViewController : UIViewController<STRecordViewInterface>

@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) IBOutlet UIButton *recordButton;
@property (nonatomic, weak) IBOutlet UIButton *tweetButton;
@property (nonatomic, weak) IBOutlet UIView *headerView;
@property (nonatomic, weak) IBOutlet TWTRTweetView *tweetViewContainer;
@property (nonatomic, weak) IBOutlet UILabel *countDownLabel;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint *tweetViewHeightContaints;

@property (nonatomic, strong) id<STRecordModuleInterface> eventHandler;
@end

