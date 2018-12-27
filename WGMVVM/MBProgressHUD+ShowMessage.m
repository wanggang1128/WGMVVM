//
//  MBProgressHUD+ShowMessage.m
//  zhangshangyiwu
//
//  Created by  陈方雷 on 15/3/9.
//  Copyright (c) 2015年  陈方雷. All rights reserved.
//

#import "MBProgressHUD+ShowMessage.h"

@implementation MBProgressHUD (ShowMessage)

+ (void)showSuccess:(NSString *)title view:(UIView *)view {
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mbp_success"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    HUD.detailsLabelText = title;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+ (void)showSuccess:(NSString *)title {
    [self showSuccess:title view:[UIApplication sharedApplication].keyWindow];
}

//TODO:换一个x图案
+ (void)showError:(NSString *)title {
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mbp_error"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    HUD.detailsLabelText = title;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}
+ (void)displayMessage:(NSString *)Message
{
    MBProgressHUD * HUD;
    if (!HUD) {
        HUD=[MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
        HUD.mode = MBProgressHUDModeText;
        HUD.userInteractionEnabled = NO;
        HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
        HUD.detailsLabelText = Message;
        HUD.margin=10.0f;
        HUD.removeFromSuperViewOnHide = YES;
        [HUD show:YES];
        [HUD hide:YES afterDelay:2];
    }
    
}


+ (void)showMessage:(NSString *)title {
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.userInteractionEnabled = NO;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    HUD.detailsLabelText = title;
    HUD.yOffset = -30.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+ (void)showMessage:(NSString *)title view:(UIView *)view {
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.userInteractionEnabled = NO;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    HUD.detailsLabelText = title;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+ (void)showMessageInCurrentWindow:(NSString *)title {
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].windows[[UIApplication sharedApplication].windows.count - 1] addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.userInteractionEnabled = NO;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    HUD.detailsLabelText = title;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}

+ (instancetype)progressWithRequest:(UIView *)view title:(NSString *)title {
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.removeFromSuperViewOnHide = YES;
    HUD.labelText = title ? title : @"加载中";
    return HUD;
}
+ (void)showVideoPlayMessage:(NSString *)message{
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    HUD.mode = MBProgressHUDModeText;
    HUD.userInteractionEnabled = NO;
    HUD.detailsLabelFont = [UIFont systemFontOfSize:15];
    HUD.detailsLabelText = message;
    HUD.yOffset = -30.f;
    HUD.removeFromSuperViewOnHide = YES;
    [HUD show:YES];
    [HUD hide:YES afterDelay:1.5];
}
@end
