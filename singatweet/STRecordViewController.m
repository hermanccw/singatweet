//
//  ViewController.m
//  singatweet
//
//  Created by Herman Chan on 2015-01-15.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STRecordViewController.h"
#import "TPOscilloscopeLayer.h"
#import <TwitterKit/TwitterKit.h>


@interface STRecordViewController ()
@property (nonatomic, strong) TPOscilloscopeLayer *inputOscilloscope;
@property (nonatomic, strong) TWTRTweet *referenceTweet;
@property (nonatomic, strong) AEAudioController *audioController;
@end

@implementation STRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)viewDidLayoutSubviews {
    // layout layer here; doesn't like autolayout
    self.inputOscilloscope.frame = CGRectMake(0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
}

- (IBAction)recordPressed:(id)sender {
   
    if (self.recordButton.selected) {
        [self.eventHandler stopRecordingTweet];
    }
    else {
        [self.eventHandler startRecordingTweet];
    }
}

- (IBAction)playPressed:(id)sender {
    if (self.playButton.selected) {
    }
    else {
        [self.eventHandler playRecordedTweet];
    }
}

#pragma mark - Private
- (void) configureView {
    self.title = NSLocalizedString(@"Sing it!", nil);
    
    // setup wave header
    self.inputOscilloscope = [[TPOscilloscopeLayer alloc] initWithAudioController:self.audioController];
    self.inputOscilloscope.frame = CGRectZero;
    self.inputOscilloscope.lineColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self.headerView.layer addSublayer:self.inputOscilloscope];
    [self.audioController addInputReceiver:self.inputOscilloscope];
    [self.inputOscilloscope start];
    
    // cancel and submit
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelPressed:)];
    
    [self.tweetViewContainer configureWithTweet:self.referenceTweet];
}

- (void) cancelPressed:(UIBarButtonItem *)sender {
    [self.eventHandler cancelRecordAudioForTweet];
}

#pragma mark - STRecordViewInterface
- (void)showUIWithReferenceTweet:(TWTRTweet *)tweet andAudioController:(AEAudioController *)audioController {
    self.referenceTweet = tweet;
    self.audioController = audioController;
}

- (void) enableRecordButton {
    self.recordButton.selected = NO;
    
}
- (void) disableRecordButton {
    self.recordButton.selected = YES;
}

- (void) enablePlayButton {
    self.playButton.selected = NO;
    
}
- (void) disablePlayButton {
    self.playButton.selected = YES;
}

- (void)updateCountDownLabelWithRemainingMS:(NSInteger)remainingMS {
    NSInteger seconds = remainingMS/1000;
    NSInteger minutes = seconds / 60;
    NSInteger hours = minutes / 60;
    
    seconds -= minutes * 60;
    minutes -= hours * 60;
    
    NSString * result = [NSString stringWithFormat:@"%01ld:%02ld.%02ld",
                         (long)minutes,
                         (long)seconds,remainingMS%1000];
    self.countDownLabel.text = result;
}

@end
