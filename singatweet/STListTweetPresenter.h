//
//  STListTweetPresenter.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

@import UIKit;
#import <Foundation/Foundation.h>
#import "STListModuleInteface.h"
#import "STListTweetInteractorIO.h"
#import "STListTweetWireframe.h"

@protocol STListTweetViewInterface;

@interface STListTweetPresenter : NSObject<STListTweetInteractorOutput, STListModuleInteface>

@property (nonatomic, strong) id<STListTweetInteractorInput> interactor;
@property (nonatomic, strong) UIViewController<STListTweetViewInterface> *userInterface;
@property (nonatomic, strong) STListTweetWireframe *listWireframe;

@end
