//
//  WGBaseViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/11/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^WGSuccessBlock)(id data);
typedef void(^WGFailBlock)(id data);

@interface WGBaseViewModel : NSObject

@property (nonatomic, copy) WGSuccessBlock successBlock;
@property (nonatomic, copy) WGFailBlock failBlock;

- (void)initWithSuccess:(WGSuccessBlock)successBlock failBlock:(WGFailBlock)failBlock;

@end

NS_ASSUME_NONNULL_END
