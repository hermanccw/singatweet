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

@interface STRecordViewController ()
@property (nonatomic, strong) AEAudioController *audioController;
@property (nonatomic, strong) AERecorder *recorder;
@property (nonatomic, strong) AEAudioFilePlayer *player;
@property (nonatomic, strong) TPOscilloscopeLayer *inputOscilloscope;
@end

@implementation STRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.audioController = [[AEAudioController alloc]
                            initWithAudioDescription:[AEAudioController nonInterleavedFloatStereoAudioDescription]
                            inputEnabled:YES];
    //************************
    // This is the crucial bit of code that was missing
    NSError *error;
    [self.audioController start:&error];
    
    self.inputOscilloscope = [[TPOscilloscopeLayer alloc] initWithAudioController:self.audioController];
    self.inputOscilloscope.frame = CGRectZero;
    self.inputOscilloscope.lineColor = [UIColor colorWithWhite:0.0 alpha:0.3];
    [self.headerView.layer addSublayer:self.inputOscilloscope];
    [self.audioController addInputReceiver:self.inputOscilloscope];
    [self.inputOscilloscope start];
//    self.headerView.layer.borderColor = [UIColor redColor].CGColor;
//    self.headerView.layer.borderWidth = 1.0f;
}

- (void)viewDidLayoutSubviews {
    // layout layer here; doesn't like autolayout
    self.inputOscilloscope.frame = CGRectMake(0, 0, self.headerView.frame.size.width, self.headerView.frame.size.height);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordPressed:(id)sender {
    if ( self.recorder ) {
        [self.recorder finishRecording];
        [self.audioController removeOutputReceiver:self.recorder];
        [self.audioController removeInputReceiver:self.recorder];
        self.recorder = nil;
        self.recordButton.selected = NO;
    } else {
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

@end
