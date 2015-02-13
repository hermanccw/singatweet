//
//  STRecordPresenter.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-08.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "STRecordModuleInterface.h"
#import "STRecordInteractorIO.h"

@class STRecordWireframe;

@protocol STRecordViewInterface;


@interface STRecordPresenter : NSObject<STRecordInteractorOutput, STRecordModuleInterface>

@property (nonatomic, strong) id<STRecordInteractorInput> interactor;
@property (nonatomic, strong) STRecordWireframe *wireframe;
@property (nonatomic, strong) UIViewController<STRecordViewInterface> *userInterface;

- (void)configureUserInterfaceForPresentation:(id<STRecordViewInterface>)recordViewUserInterface
                           withReferenceTweet:(TWTRTweet*)tweet;
@end
