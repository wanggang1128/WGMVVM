//
//  FriendTableViewCell.m
//  MVVMExample
//
//  Created by QSP on 2018/3/21.
//  Copyright © 2018年 QSP. All rights reserved.
//

#import "FriendTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define K_Spcing            8.0

@interface FriendTableViewCell ()
@end

@implementation FriendTableViewCell

+ (instancetype)friendCell:(UITableView *)tableView viewModel:(WGFriendCellViewModel *)viewModel {
    static NSString *identifier = @"FriendTableViewCell";
    FriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    [cell bindViewModel:viewModel];
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseIdentifier]) {
    }
    
    return self;
}
- (void)bindViewModel:(WGFriendCellViewModel *)viewModel {
    self.viewModel = viewModel;
    
    self.textLabel.text = self.viewModel.friendModel.name;
    self.detailTextLabel.text = self.viewModel.friendModel.uin;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.viewModel.friendModel.img] placeholderImage:[UIImage imageNamed:@"50"]];
}


@end
