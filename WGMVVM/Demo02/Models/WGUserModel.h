//
//  WGUserModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGUserModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, assign) BOOL logined;


+ (instancetype)userModelWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined;
- (instancetype)initWithUsername:(NSString *)username password:(NSString *)password logined:(BOOL)logined;

@end

NS_ASSUME_NONNULL_END
