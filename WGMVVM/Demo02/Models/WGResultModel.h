//
//  WGResultModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGResultModel : NSObject

@property (nonatomic, assign) BOOL success;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) id dataModel;

+ (instancetype)resultWithSuccess:(BOOL)success message:(NSString *)message dataModel:(id)dataModel;
- (instancetype)initWithSuccess:(BOOL)success message:(NSString *)message dataModel:(id)dataModel;

@end

NS_ASSUME_NONNULL_END
