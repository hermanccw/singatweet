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

#import "STRecordInteractor.h"
#import "STRecordPresenter.h"
#import "STRecordWireframe.h"

@interface STAppDependencies ()


@property (nonatomic, strong) STListTweetWireframe *listTweetWireframe;
@property (nonatomic, strong) STRecordWireframe *recordWireframe;

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
    
    listInteractor.output = listPresenter;
    
    listPresenter.interactor = listInteractor;
    listPresenter.listWireframe = listWireframe;
    
    listWireframe.listPresenter = listPresenter;
    listWireframe.rootWireframe = rootWireframe;
    self.listTweetWireframe = listWireframe;
    
    
    // Record Modules Classes
    STRecordWireframe *recordWireframe = [[STRecordWireframe alloc] init];
    STRecordPresenter *recordPresenter = [[STRecordPresenter alloc] init];
    STRecordInteractor *recordInteractor = [[STRecordInteractor alloc] init];
    
    recordPresenter.interactor = recordInteractor;
    recordPresenter.wireframe = recordWireframe;
    recordWireframe.recordPresenter = recordPresenter;
    
    self.recordWireframe = recordWireframe;
    
    self.listTweetWireframe.recordWireframe = self.recordWireframe;
}

@end
