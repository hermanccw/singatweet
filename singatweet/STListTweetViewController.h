//
//  STListTweetViewController.h
//  singatweet
//
//  Created by Herman Chan on 2015-02-05.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STListModuleInteface.h"
#import "STListTweetViewInterface.h"


@interface STListTweetViewController : UITableViewController<STListTweetViewInterface>

@property (nonatomic, strong) id<STListModuleInteface> eventHandler;
@end
