//
//  MBProgressHUD+ShowMessage.h
//  zhangshangyiwu
//
//  Created by  陈方雷 on 15/3/9.
//  Copyright (c) 2015年  陈方雷. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (ShowMessage)

+ (void)showSuccess:(NSString *)title view:(UIView *)view;

+ (void)showSuccess:(NSString *)title;

+ (void)showError:(NSString *)title;

+ (void)showMessage:(NSString *)title;

+ (void)displayMessage:(NSString *)Message;

+ (void)showMessage:(NSString *)title view:(UIView *)view;

+ (void)showMessageInCurrentWindow:(NSString *)title;

+ (instancetype)progressWithRequest:(UIView *)view title:(NSString *)title;

+ (void)showVideoPlayMessage:(NSString *)message;

@end
