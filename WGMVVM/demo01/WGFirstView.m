//
//  WGFirstView.m
//  WGMVVM
//
//  Created by wanggang on 2018/11/20.
//  Copyright © 2018 wanggang. All rights reserved.
//

#define WGWidth [UIScreen mainScreen].bounds.size.width
#define WGHeight [UIScreen mainScreen].bounds.size.height
#define OneWidth WGWidth/4.0

#import "WGFirstView.h"

@implementation WGFirstView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    
    _array = array;
    
    for (int i= 0; i<array.count; i++) {
        
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(OneWidth*(i%4), 30*(i/4), OneWidth, 30)];
        lable.text = [array objectAtIndex:i];
        lable.textColor = [UIColor whiteColor];
        lable.backgroundColor = [UIColor blackColor];
        [self addSubview:lable];
    }
}

@end
