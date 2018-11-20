//
//  WGBaseViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/11/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGBaseViewModel.h"

@implementation WGBaseViewModel

- (void)initWithSuccess:(WGSuccessBlock)successBlock failBlock:(WGFailBlock)failBlock{
    
    self.successBlock = successBlock;
    self.failBlock = failBlock;
}

@end
