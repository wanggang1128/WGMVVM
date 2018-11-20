//
//  WGFirstViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/11/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#define WGWidth [UIScreen mainScreen].bounds.size.width
#define WGHeight [UIScreen mainScreen].bounds.size.height
#define OneWidth WGWidth/4.0

#import "WGFirstViewController.h"
#import "WGFirstViewModel.h"
#import "WGFirstView.h"

@interface WGFirstViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) WGFirstView *headView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) WGFirstViewModel *viewModel;

@end

@implementation WGFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WGFirstViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    __weak typeof(self) weakSelf = self;
    self.viewModel = [[WGFirstViewModel alloc] init];
    [self.viewModel initWithSuccess:^(id  _Nonnull data) {
        
        [weakSelf.dataArray removeAllObjects];
        [weakSelf.dataArray addObjectsFromArray:data];
        
        weakSelf.headView = [[WGFirstView alloc] initWithFrame:CGRectMake(0, 0, WGWidth, 30*(weakSelf.dataArray.count/4+1))];
        weakSelf.tableView.tableHeaderView = weakSelf.headView;
        weakSelf.headView.array = weakSelf.dataArray;
        
        [weakSelf.tableView reloadData];
        
    } failBlock:^(id  _Nonnull data) {
        
    }];
    
    [self.viewModel loadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"UITableViewCell"];
    }
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", (indexPath.row+1)];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.viewModel.name = self.dataArray[indexPath.row];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
