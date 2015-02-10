//
//  ViewController.m
//  singatweet
//
//  Created by Herman Chan on 2015-01-15.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STRecordViewController.h"
#import "TheAmazingAudioEngine.h"
#import "AERecorder.h"
#import "TPOscilloscopeLayer.h"
#import <TwitterKit/TwitterKit.h>
#import <AudioToolbox/AudioToolbox.h>


@interface STRecordViewController ()
@property (nonatomic, strong) AEAudioController *audioController;
@property (nonatomic, strong) AERecorder *recorder;
@property (nonatomic, strong) AEAudioFilePlayer *player;
@property (nonatomic, strong) TPOscilloscopeLayer *inputOscilloscope;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger tickCount;
@property (nonatomic, assign) NSInteger recordTimeInMS;
@property (nonatomic, strong) TWTRTweet *referenceTweet;
@end

@implementation STRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAudioController];
    [self configureView];
}

- (void)viewDidLayoutSubviews {
    // layout layer here; doesn't like autolayout
    self.inputOscilloscope.frame = CGRectMake(0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
}

- (IBAction)recordPressed:(id)sender {
    if ( self.recorder ) {
        [self.recorder finishRecording];
        [self.audioController removeOutputReceiver:self.recorder];
        [self.audioController removeInputReceiver:self.recorder];
        self.recorder = nil;
        self.recordButton.selected = NO;
    } else if (self.timer == nil) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    }
}

- (IBAction)playPressed:(id)sender {
    
    if ( self.player ) {
        [self.audioController removeChannels:@[self.player]];
        self.player = nil;
        self.playButton.selected = NO;
    } else {
        NSArray *documentsFolders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *path = [documentsFolders[0] stringByAppendingPathComponent:@"Recording.aiff"];
        
        if ( ![[NSFileManager defaultManager] fileExistsAtPath:path] ) return;
        
        NSError *error = nil;
        self.player = [AEAudioFilePlayer audioFilePlayerWithURL:[NSURL fileURLWithPath:path] audioController:self.audioController error:&error];
        
        if ( !self.player ) {
            [[[UIAlertView alloc] initWithTitle:@"Error"
                                        message:[NSString stringWithFormat:@"Couldn't start playback: %@", [error localizedDescription]]
                                       delegate:nil
                              cancelButtonTitle:nil
                              otherButtonTitles:@"OK", nil] show];
            return;
        }
        
        self.player.removeUponFinish = YES;
        __weak STRecordViewController *weakSelf = self;
        self.player.completionBlock = ^{
            STRecordViewController *strongSelf = weakSelf;
            strongSelf.playButton.selected = NO;
            weakSelf.player = nil;
        };
        [self.audioController addChannels:@[self.player]];
        
        self.playButton.selected = YES;
    }
 

}

- (void) tick {
    if (self.tickCount > 0) {
        [self playTickSound];
        self.tickCount = self.tickCount - 1;
        
        
    }
    else {
        [self.timer invalidate];
        self.timer = nil;
        self.tickCount = 3;
        [self startRecording];
    }
}

- (void) playTickSound {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"tick" ofType:@"wav"];
    
    if ( ![[NSFileManager defaultManager] fileExistsAtPath:path] ) return;
    
    NSError *error = nil;
    self.player = [AEAudioFilePlayer audioFilePlayerWithURL:[NSURL fileURLWithPath:path] audioController:self.audioController error:&error];
    
    if ( !self.player ) {
        return;
    }
    
    self.player.removeUponFinish = YES;
    __weak STRecordViewController *weakSelf = self;
    self.player.completionBlock = ^{
        weakSelf.player = nil;
    };
    [self.audioController addChannels:@[self.player]];
}

- (void) startRecording {
    self.recorder = [[AERecorder alloc] initWithAudioController:self.audioController];
    NSArray *documentsFolders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documentsFolders[0] stringByAppendingPathComponent:@"Recording.aiff"];
    NSError *error = nil;
    if ( ![self.recorder beginRecordingToFileAtPath:path fileType:kAudioFileAIFFType error:&error] ) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[NSString stringWithFormat:@"Couldn't start recording: %@", [error localizedDescription]]
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        self.recorder = nil;
        return;
    }
    
    self.recordButton.selected = YES;
    
    [self.audioController addOutputReceiver:self.recorder];
    [self.audioController addInputReceiver:self.recorder];
    [self startCountDown];
    
}

- (void) stopRecording {
    if (self.countDownTimer) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
    }
    if ( self.recorder ) {
        [self.recorder finishRecording];
        [self.audioController removeOutputReceiver:self.recorder];
        [self.audioController removeInputReceiver:self.recorder];
        self.recorder = nil;
        self.recordButton.selected = NO;
    }
}

- (void) startCountDown {
    if (self.countDownTimer == nil) {
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(handleCountDownTimer) userInfo:nil repeats:YES];
    }
}

- (void) handleCountDownTimer {
    self.recordTimeInMS -= 10;
    [self updateCountDownLabel:self.recordTimeInMS];
    if (self.recordTimeInMS == 0) {
        [self stopRecording];
    }
}

- (void) updateCountDownLabel:(NSInteger)milliseconds {
    NSInteger seconds = milliseconds/1000;
    NSInteger minutes = seconds / 60;
    NSInteger hours = minutes / 60;
    
    seconds -= minutes * 60;
    minutes -= hours * 60;
    
    NSString * result = [NSString stringWithFormat:@"%01ld:%02ld.%02ld",
                            (long)minutes,
                            (long)seconds,milliseconds%1000];
    self.countDownLabel.text = result;
}

#pragma mark - Private
- (void) setupAudioController {
    // Do any additional setup after loading the view, typically from a nib.
    self.audioController = [[AEAudioController alloc]
                            initWithAudioDescription:[AEAudioController nonInterleavedFloatStereoAudioDescription]
                            inputEnabled:YES];
    NSError *error;
    [self.audioController start:&error];
}

- (void) configureView {
    self.title = NSLocalizedString(@"Sing it!", nil);
    
    // setup wave header
    self.inputOscilloscope = [[TPOscilloscopeLayer alloc] initWithAudioController:self.audioController];
    self.inputOscilloscope.frame = CGRectZero;
    self.inputOscilloscope.lineColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self.headerView.layer addSublayer:self.inputOscilloscope];
    [self.audioController addInputReceiver:self.inputOscilloscope];
    [self.inputOscilloscope start];
    
    // setup count down label
    self.tickCount = 3;
    self.recordTimeInMS = 60 * 1000;
    [self updateCountDownLabel:self.recordTimeInMS];
    
    
    // cancel and submit
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancelPressed:)];
    
//    TWTRTweetView *tweetView = [[TWTRTweetView alloc] initWithTweet:self.referenceTweet];
//    [self.tweetViewContainer addSubview:tweetView];
    [self.tweetViewContainer configureWithTweet:self.referenceTweet];
    
    
    
//    CGSize size = [tweetView sizeThatFits:CGSizeMake(self.view.frame.size.width - 20, CGFLOAT_MAX)];
//    if (size.height != self.tweetViewHeightContaints.constant) {
//        self.tweetViewHeightContaints.constant = size.height;
//        [self.view setNeedsUpdateConstraints];
//        [UIView animateWithDuration:0.25f animations:^{
//            [self.view layoutIfNeeded];
//        }];
//    }
}

- (void) cancelPressed:(UIBarButtonItem *)sender {
    [self.eventHandler cancelRecordAudioForTweet];
}

#pragma mark - STRecordViewInterface
- (void)showUIWithReferenceTweet:(TWTRTweet *)tweet {
    self.referenceTweet = tweet;
}

@end
