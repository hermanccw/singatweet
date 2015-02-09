//
//  STListTweetViewController.m
//  singatweet
//
//  Created by Herman Chan on 2015-02-05.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "STListTweetViewController.h"
//#import <TwitterKit/TwitterKit.h>
#import "STTwitterViewDelegateHandler.h"

static NSString * const TweetTableReuseIdentifier = @"TwitterCell";

@interface STListTweetViewController()
@property (nonatomic, strong) NSArray *tweets;
//@property (nonatomic, strong) NSDataTableViewCell *prototypeCell;
@property (nonatomic, strong) STTwitterViewDelegateHandler *twitterViewHandler;
@end

@implementation STListTweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.eventHandler updateTweets];
}


#pragma mark - STListTweetViewInterface
- (void)reloadEntries {
    [self.tableView reloadData];
}

- (void)showDisplayTweets:(NSArray *)tweets {
    self.tweets = [NSArray arrayWithArray:tweets];
    [self reloadEntries];
}

#pragma mark - UITableViewDelegate and DataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweets.count;
}

// Calculate the height of each row
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSData *tweet = self.tweets[indexPath.row];
//    [self.prototypeCell configureWithTweet:tweet];
//    return [NSDataTableViewCell heightForTweet:tweet width:CGRectGetWidth(self.view.bounds)];
//}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSData *tweet = self.tweets[indexPath.row];
//    NSDataTableViewCell *cell = (NSDataTableViewCell *) [tableView dequeueReusableCellWithIdentifier:TweetTableReuseIdentifier
//                                                                                                   forIndexPath:indexPath];
//    [cell configureWithTweet:tweet];
//    cell.tweetView.delegate = self.twitterViewHandler;
//    return cell;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"did selected");
}

#pragma mark - Private
- (void) configureView {
//    self.tableView.estimatedRowHeight = 150;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.allowsSelection = NO;
//    [self.tableView registerClass:
//     [NSDataTableViewCell class]
//           forCellReuseIdentifier:TweetTableReuseIdentifier];
//    
//    // Create a single prototype cell for height calculations
//    self.prototypeCell = [[NSDataTableViewCell alloc] init];
}

#pragma mark - lazy props
- (STTwitterViewDelegateHandler*) twitterViewHandler {
    if (!_twitterViewHandler) {
        _twitterViewHandler = [[STTwitterViewDelegateHandler alloc] initWithController:self];
    }
    return _twitterViewHandler;
}


@end
