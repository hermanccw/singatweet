//
//  STRecordWireframe.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STRecordWireframe.h"
#import "STRecordPresenter.h"
#import "STRecordViewController.h"


static NSString *RecordViewController = @"STRecordViewController";

@interface STRecordWireframe()
@property (nonatomic, weak) UIViewController *presentedViewController;
@end

@implementation STRecordWireframe

- (void)presentRecordInterfaceFromViewController:(UIViewController *)viewController withTweet:(TWTRTweet*)tweet
{
    STRecordViewController *recordViewController = [self recordViewController];
    [self.recordPresenter configureUserInterfaceForPresentation:recordViewController withReferenceTweet:tweet];
    self.recordPresenter.userInterface = recordViewController;
    recordViewController.eventHandler = self.recordPresenter;
    self.presentedViewController = viewController;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:recordViewController];
    [self.presentedViewController presentViewController:nav animated:YES completion:nil];
}


- (void)dismissRecordInterface
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
}

- (STRecordViewController *)recordViewController
{
    UIStoryboard *storyboard = [self mainStoryboard];
    STRecordViewController *recordViewController = [storyboard instantiateViewControllerWithIdentifier:RecordViewController];
    return recordViewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}
@end
