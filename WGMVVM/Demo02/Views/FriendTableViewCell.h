//
//  FriendTableViewCell.h
//  MVVMExample
//
//  Created by QSP on 2018/3/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGFriendCellViewModel.h"

@interface FriendTableViewCell : UITableViewCell

@property (strong, nonatomic) WGFriendCellViewModel *viewModel;

+ (instancetype)friendCell:(UITableView *)tableView viewModel:(WGFriendCellViewModel *)viewModel;

@end
