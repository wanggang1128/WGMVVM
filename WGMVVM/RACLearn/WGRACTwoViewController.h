//
//  WGRACTwoViewController.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC.h>

NS_ASSUME_NONNULL_BEGIN

@interface WGRACTwoViewController : UIViewController

@property (nonatomic, strong) RACSubject *delegateSub;

@end

NS_ASSUME_NONNULL_END
