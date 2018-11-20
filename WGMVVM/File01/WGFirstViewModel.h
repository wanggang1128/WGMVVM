//
//  WGFirstViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/11/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGFirstViewModel : WGBaseViewModel

@property (nonatomic, copy) NSString *name;

- (void)loadData;

@end

NS_ASSUME_NONNULL_END
