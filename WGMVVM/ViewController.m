//
//  ViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/10/12.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.row) {
        case 0:{
            
            [[WGControllerPush WGControllerPushShare] pushFromController:self toCon:@"WGFirstViewController"];
            break;
        }case 1:{
            
            [[WGControllerPush WGControllerPushShare] pushFromController:self toCon:@"WGRACViewController"];
            
            break;
        }case 2:{
            
            [[WGControllerPush WGControllerPushShare] pushFromController:self toCon:@"WGLoginViewController"];
            break;
        }
        case 3:{
            
            [[WGControllerPush WGControllerPushShare] pushFromController:self toCon:@"WGNewLoginViewController"];
            
            break;
        }
        default:
            break;
    }
}

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithObjects:@"Demo01", @"RACLearn",@"LoginFile", @"Demo02", nil];
    }
    return _dataArray;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}

@end
