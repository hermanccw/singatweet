//
//  STRecordInteractor.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STRecordInteractor.h"
#import "EXTScope.h"
#import "STSongUploadService.h"
#import "STS3SongUploadService.h"


@interface STRecordInteractor()
@property (nonatomic, strong) AERecorder *recorder;
@property (nonatomic, strong) AEAudioFilePlayer *player;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSInteger tickCount;
@property (nonatomic, assign) NSInteger recordTimeInMS;
@property (nonatomic, copy) NSString *localAudioFileName;
@end

@implementation STRecordInteractor

- (instancetype) init {
    [super doesNotRecognizeSelector:_cmd];
    return nil;
}

- (instancetype) initWithAudioController:(AEAudioController*)audioController {
    self = [super init];
    if (self) {
        self.tickCount = 3;
        self.recordTimeInMS = 60 * 1000;
        self.localAudioFileName = [NSString stringWithFormat:@"%@.m4a", [[NSUUID UUID] UUIDString]];
        // Do any additional setup after loading the view, typically from a nib.
        self.audioController = audioController;
        NSError *error;
        [self.audioController start:&error];
    
    }
    return self;
    
}

- (NSString *)audioFileRemotePath {
    return [NSString stringWithFormat:@"%@%@", [[self songUploadService] uploadBasePath], self.localAudioFileName];
}

- (void)startRecordingTweet {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    [self.output startedRecording];
}

- (void)pauseRecordingTweet {
    
}

- (void)stopRecordingTweet {
    [self stopRecording];
}

- (void)playRecordedTweet {
    NSString *path = self.localAudioFileName;
    
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
    @weakify(self)
    self.player.completionBlock = ^{
        @strongify(self)
        [self.output stoppedPlayingRecording];
        self.player = nil;
    };
    [self.audioController addChannels:@[self.player]];
    [self.output startedToPlayRecording];
}

/**
 *  Save audio file for recording of a tweet
 */
- (void)saveAudioFile {
    // save this to s3
    [[self songUploadService] uploadSongAtLocalPath:[self localAudioPath]];
    [self.output uploadingAudioWithPath:[self localAudioPath]];
}

/**
 *  Save tweet and reference tweet to the server and link to a audioURL created earlier
 *
 *  @param tweet          new tweet with audio
 *  @param audioURL       audio url for sang tweet
 *  @param referenceTweet reference tweet for this audio
 */
- (void)saveTweet:(TWTRTweet *)tweet withAudioURL:(NSString *)audioURL andReferenceTweet:(TWTRTweet *)referenceTweet {
    
}

#pragma mark - Private methods
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
    @weakify(self)
    self.player.completionBlock = ^{
        @strongify(self)
        self.player = nil;
    };
    [self.audioController addChannels:@[self.player]];
}

- (void) startRecording {
    self.recorder = [[AERecorder alloc] initWithAudioController:self.audioController];
    NSString *path = [self localAudioPath];
    NSError *error = nil;
    if ( ![self.recorder beginRecordingToFileAtPath:path fileType:kAudioFileM4AType error:&error] ) {
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:[NSString stringWithFormat:@"Couldn't start recording: %@", [error localizedDescription]]
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"OK", nil] show];
        self.recorder = nil;
        return;
    }
    
    [self.audioController addOutputReceiver:self.recorder];
    [self.audioController addInputReceiver:self.recorder];
    [self startCountDown];
    
}

- (void) startCountDown {
    if (self.countDownTimer == nil) {
        self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(handleCountDownTimer) userInfo:nil repeats:YES];
    }
}

- (void) handleCountDownTimer {
    self.recordTimeInMS -= 10;
    [self.output updatedRemainingMS:self.recordTimeInMS];
    if (self.recordTimeInMS == 0) {
        [self stopRecording];
    }
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
        [self.output stoppedRecording];
    }
}

#pragma mark - private
- (NSString*)localAudioPath {
    NSArray *documentsFolders = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [documentsFolders[0] stringByAppendingPathComponent:self.localAudioFileName];
    return path;
}

- (id<STSongUploadService>) songUploadService {
    return [[STS3SongUploadService alloc] init];
}

@end
