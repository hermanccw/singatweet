//
//  STListTweetWireframe.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STListTweetWireframe.h"
#import "STListTweetViewController.h"
#import "STListTweetPresenter.h"
#import "STRootViewWireframe.h"
#import "STRecordWireframe.h"

static NSString *ListTweetViewControllerIdentifier = @"STListTweetViewController";

@interface STListTweetWireframe ()

@property (nonatomic, strong) STListTweetViewController *listTweetViewController;

@end

@implementation STListTweetWireframe

- (void)presentListInterfaceFromWindow:(UIWindow *)window
{
    STListTweetViewController *listViewController = [self listViewControllerFromStoryboard];
    listViewController.eventHandler = self.listPresenter;
    self.listPresenter.userInterface = listViewController;
    self.listTweetViewController = listViewController;
    
    [self.rootWireframe showRootViewController:listViewController
                                      inWindow:window];
}


- (void)presentRecordInterfaceWithTweet:(TWTRTweet*)tweet {
    [self.recordWireframe presentRecordInterfaceFromViewController:self.listTweetViewController withTweet:tweet];
}


- (STListTweetViewController *)listViewControllerFromStoryboard
{
    UIStoryboard *storyboard = [self mainStoryboard];
    STListTweetViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:ListTweetViewControllerIdentifier];
    return viewController;
}


- (UIStoryboard *)mainStoryboard
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:[NSBundle mainBundle]];
    
    return storyboard;
}

@end
