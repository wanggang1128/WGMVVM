//
//  WGResult.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGResult : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id responseObject;

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject;
- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message responseObject:(id)responseObject;

@end

NS_ASSUME_NONNULL_END
