//
//  WGMainViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/27.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGHomeViewController.h"
#import "WGHomeViewModel.h"
#import "FriendTableViewCell.h"

@interface WGHomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) WGHomeViewModel *viewModel;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WGHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"首页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createView];
    
    [self bindViewModel];
}

- (void)createView{
    
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [leftButton setTitle:@"退出" forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.leftButton = leftButton;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
}

- (void)bindViewModel{
    
    @weakify(self)

    [[self.leftButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        
        [self.viewModel.logoutCommand execute:nil];
    }];
    
    [self.viewModel.logoutCommand.executing subscribeNext:^(NSNumber * _Nullable x) {
        
        @strongify(self)
        BOOL show = [x boolValue];
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = show;

        if (show) {
            [LoadingTool showTo:self.view];
        }else{
            [LoadingTool hideFrom:self.view];
        }
    }];
    
    [self.viewModel.logoutCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        
        WGResultModel *model = (WGResultModel *)x;
        
        if (model.success) {
            
            UIViewController *vc = [[WGControllerPush WGControllerPushShare] getViewControllerWithConName:@"WGNewLoginViewController" paramType:WGPushNoParam param:nil];
            UIWindow *window = [UIApplication sharedApplication].delegate.window;
            window.rootViewController = [[UINavigationController alloc] initWithRootViewController:vc];
            [window makeKeyWindow];
        }else{
            
            [LoadingTool showMessage:model.message toView:[UIApplication sharedApplication].keyWindow];
        }
    }];
    
    [RACObserve(self.viewModel, dataArray) subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.tableView reloadData];
    }];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadTableView:YES];
    }];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadTableView:NO];
    }];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
}

/**
 加载tableView
 
 @param isDown 是否为下拉加载
 */
- (void)loadTableView:(BOOL)isDown {
    @weakify(self)
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [[self.viewModel pageSignal:isDown] subscribeNext:^(WGResultModel *model) {
        @strongify(self)
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        if (model.success) {
            if (model.dataModel == nil || [(NSArray *)model.dataModel count] == 0) {
                [LoadingTool showMessage:isDown ? @"没有数据" : @"没有跟多数据" toView:self.view];
            }
        } else {
            [LoadingTool showMessage:model.message toView:self.view];
        }
        if (isDown) {
            [self.tableView.mj_header endRefreshing];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - <UITableViewDelegate, UITableViewDataSource>代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.viewModel.dataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FriendTableViewCell friendCell:tableView viewModel:[self.viewModel.dataArray objectAtIndex:indexPath.row]];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(WGHomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [WGHomeViewModel homeViewModelWithHomeModel:[WGHomeModel homeWithWGUser:self.user]];
    }
    return _viewModel;
}

@end
