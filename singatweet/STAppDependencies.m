//
//  STAppDependencies.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STAppDependencies.h"
#import "STRootViewWireframe.h"


#import "STListTweetDataManager.h"
#import "STListTweetInteractor.h"
#import "STListTweetPresenter.h"
#import "STListTweetWireframe.h"

@interface STAppDependencies ()

@property (nonatomic, strong) STListTweetWireframe *listTweetWireframe;

@end

@implementation STAppDependencies

- (instancetype) init {
   self = [super init];
    if (self) {
        [self configureDependencies];
    }
    return self;
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window {
    [self.listTweetWireframe presentListInterfaceFromWindow:window];
}

- (void)configureDependencies {
    // Root Level Classes
    STRootViewWireframe *rootWireframe = [[STRootViewWireframe alloc] init];
    
    // List Modules Classes
    STListTweetWireframe *listWireframe = [[STListTweetWireframe alloc] init];
    STListTweetPresenter *listPresenter = [[STListTweetPresenter alloc] init];
    
    STListTweetDataManager *listDataManager = [[STListTweetDataManager alloc] init];
    STListTweetInteractor *listInteractor = [[STListTweetInteractor alloc] initWithDataManager:listDataManager];
    
    // ListTweet Module Classes
    listInteractor.output = listPresenter;
    
    listPresenter.interactor = listInteractor;
    listPresenter.listWireframe = listWireframe;
    
    listWireframe.listPresenter = listPresenter;
    listWireframe.rootWireframe = rootWireframe;
    self.listTweetWireframe = listWireframe;
    
}

@end
