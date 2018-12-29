//
//  WGFriendModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/29.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGFriendModel : NSObject

@property (nonatomic, copy) NSString *uin;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *img;

+ (instancetype)firendModelWithInfoDic:(NSDictionary *)dic;
- (instancetype)initWithInfoDic:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
