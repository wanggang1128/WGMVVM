//
//  WGHomeViewModel.h
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGHomeModel.h"
#import "WGFriendModel.h"
#import "WGFriendCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface WGHomeViewModel : NSObject

@property (nonatomic, strong) WGHomeModel *homeModel;
@property (nonatomic, strong) RACCommand *logoutCommand;

//标题
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pageCount;

@property (nonatomic, strong) NSArray<WGFriendCellViewModel *> *dataArray;


+ (instancetype)homeViewModelWithHomeModel:(WGHomeModel *)homeModel;
- (instancetype)initWithHomeModel:(WGHomeModel *)homeModel;

- (RACSignal *)pageSignal:(BOOL)isFirst;

@end

NS_ASSUME_NONNULL_END
