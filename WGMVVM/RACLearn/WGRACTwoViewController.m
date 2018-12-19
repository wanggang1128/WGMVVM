//
//  WGRACTwoViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGRACTwoViewController.h"

@interface WGRACTwoViewController ()

@end

@implementation WGRACTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"WGRACTwoViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    btn.backgroundColor = [UIColor yellowColor];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick{
    
    if (self.delegateSub) {
        [self.delegateSub sendNext:@"WGRACTwoViewController"];
    }
}

@end
