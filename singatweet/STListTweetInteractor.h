//
//  STListTweetInteractor.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-07.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STListTweetInteractorIO.h"
#import "STListTweetDataManager.h"

@interface STListTweetInteractor : NSObject<STListTweetInteractorInput>

@property (nonatomic, weak) id<STListTweetInteractorOutput> output;

- (instancetype) initWithDataManager:(STListTweetDataManager*)dataManager;

@end
