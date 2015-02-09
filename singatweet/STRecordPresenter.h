//
//  STRecordPresenter.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STRecordModuleInterface.h"


@class STRecordInteractor;
@class STRecordWireframe;

@protocol STRecordViewInterface;


@interface STRecordPresenter : NSObject<STRecordModuleInterface>

@property (nonatomic, strong) STRecordInteractor *interactor;
@property (nonatomic, strong) STRecordWireframe *wireframe;
@property (nonatomic, strong) TWTRTweet *referenceTweet;

- (void)configureUserInterfaceForPresentation:(id<STRecordViewInterface>)recordViewUserInterface;
@end
