//
//  WGHomeViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/28.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGHomeViewModel.h"

@implementation WGHomeViewModel

+ (instancetype)homeViewModelWithHomeModel:(WGHomeModel *)homeModel{
    
    return [[self alloc] initWithHomeModel:homeModel];
}

- (instancetype)initWithHomeModel:(WGHomeModel *)homeModel;{
    
    self = [super init];
    if (self) {
        
        self.title = @"首页";
        self.page = 0;
        self.pageCount = 20;
        self.homeModel = homeModel;
        
        self.logoutCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [[self.homeModel.user logoutSignal] logAll];
        }];
    }
    return self;
}

-(RACSignal *)pageSignal:(BOOL)isFirst{
    
    return [[[self.homeModel friendSignalWithPage:isFirst?0:self.page count:self.pageCount] map:^id _Nullable(WGResultModel *model) {
        
        return [WGResultModel resultWithSuccess:model.success message:model.message dataModel:[model.dataModel linq_select:^id(id item) {
            //转换为WGFriendCellViewModel数据
            return [WGFriendCellViewModel friendCellViewModel:item];
        }]];
    }] doNext:^(WGResultModel *model) {
        if (isFirst) {
            self.dataArray = model.dataModel;
            self.page = 1;
        } else {
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.dataArray];
            [mArr addObjectsFromArray:model.dataModel];
            self.dataArray = [NSArray arrayWithArray:mArr];
            self.page++;
        }
    }];
}

@end
