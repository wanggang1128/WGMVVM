//
//  WGFirstViewModel.m
//  WGMVVM
//
//  Created by wanggang on 2018/11/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGFirstViewModel.h"
#import <ReactiveObjC.h>

@interface WGFirstViewModel()

@end

@implementation WGFirstViewModel

-(instancetype)init{
    self = [super init];
    if (self) {
        
//        [self addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
        
        
        //使用rac
        [RACObserve(self, name) subscribeNext:^(id  _Nullable x) {
            
            NSLog(@"11%@", x);
        
            NSArray *arr = @[@"name1",@"name2",@"name3",@"name4",@"name5",@"name6"];
            NSMutableArray *array = [[NSMutableArray alloc] initWithArray:arr];
            @synchronized (self) {
                [array removeObject:x];
            }
            if (self.successBlock) {
                self.successBlock(array);
            }
            
        }];
        
    }
    return self;
}

//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//
//    NSLog(@"11%@", change[NSKeyValueChangeNewKey]);
//
//    NSArray *arr = @[@"name1",@"name2",@"name3",@"name4",@"name5",@"name6"];
//    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:arr];
//    @synchronized (self) {
//        [array removeObject:change[NSKeyValueChangeNewKey]];
//    }
//    if (self.successBlock) {
//        self.successBlock(array);
//    }
//}

-(void)loadData{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        sleep(3);
        NSArray *arr = @[@"name1",@"name2",@"name3",@"name4",@"name5",@"name6"];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.successBlock) {
                self.successBlock(arr);
            }
        });
    });
}

//-(void)dealloc{
//    [self removeObserver:self forKeyPath:@"name"];
//}

@end
