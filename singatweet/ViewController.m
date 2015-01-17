//
//  ViewController.m
//  singatweet
//
//  Created by Herman Chan on 2015-01-15.
//  Copyright (c) 2015 ironark. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)recordPressed:(id)sender {
    UIButton *button = (UIButton*)sender;
    [button setTitle:@"Recording" forState:UIControlStateNormal];
}

@end
