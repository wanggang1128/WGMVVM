//
//  WGRACViewController.m
//  WGMVVM
//
//  Created by wanggang on 2018/12/19.
//  Copyright © 2018 wanggang. All rights reserved.
//

#import "WGRACViewController.h"
#import <ReactiveObjC.h>
#import "WGRACTwoViewController.h"

@interface WGRACViewController ()

@property (nonatomic, strong) RACCommand *command;

@property (nonatomic, strong) UIView *redView;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UITextField *textField;

@end

@implementation WGRACViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WGRACViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.btn];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.textField];
    
//    [self learn01];
//    [self learn02];
//    [self learn03];
//    [self learn04];
//    [self learn05];
//    [self learn06];
    [self learn07];
}


- (void)butnClick{
    NSLog(@"butnClick");
}

- (void)learn07{
    
    // 1.代替代理
    // 需求：自定义redView,监听红色view中按钮点击
    // 之前都是需要通过代理监听，给红色View添加一个代理属性，点击按钮的时候，通知代理做事情
    // rac_signalForSelector:把调用某个对象的方法的信息转换成信号，就要调用这个方法，就会发送信号。
    // 这里表示只要redV调用btnClick:,就会发出信号，订阅就好了。
    [[self rac_signalForSelector:@selector(butnClick)] subscribeNext:^(RACTuple * _Nullable x) {
        
        NSLog(@"点击黄色按钮");
    }];
}

//RACMulticastConnection简单使用
- (void)learn06{
    
    /*
    // 1.创建请求信号
    RACSignal *singal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        NSLog(@"发送请求");
        return nil;
    }];
    
    // 2.订阅信号
    [singal subscribeNext:^(id  _Nullable x) {
        
         NSLog(@"接收数据");
    }];
    
    [singal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"接收数据");
    }];
    
    // 3.运行结果，会执行两遍发送请求，也就是每次订阅都会发送一次请求
    */
    
    // RACMulticastConnection使用步骤:
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.创建连接 RACMulticastConnection *connect = [signal publish];
    // 3.订阅信号,注意：订阅的不在是之前的信号，而是连接的信号。 [connect.signal subscribeNext:nextBlock]
    // 4.连接 [connect connect]
    
    // RACMulticastConnection底层原理:
    // 1.创建connect，connect.sourceSignal -> RACSignal(原始信号)  connect.signal -> RACSubject
    // 2.订阅connect.signal，会调用RACSubject的subscribeNext，创建订阅者，而且把订阅者保存起来，不会执行block。
    // 3.[connect connect]内部会订阅RACSignal(原始信号)，并且订阅者是RACSubject
    // 3.1.订阅原始信号，就会调用原始信号中的didSubscribe
    // 3.2 didSubscribe，拿到订阅者调用sendNext，其实是调用RACSubject的sendNext
    // 4.RACSubject的sendNext,会遍历RACSubject所有订阅者发送信号。
    // 4.1 因为刚刚第二步，都是在订阅RACSubject，因此会拿到第二步所有的订阅者，调用他们的nextBlock
    
    
    // 需求：假设在一个信号中发送请求，每次订阅一次都会发送请求，这样就会导致多次请求。
    // 解决：使用RACMulticastConnection就能解决.
    
    // RACMulticastConnection:解决重复请求问题
    // 1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
         NSLog(@"发送请求");
        [subscriber sendNext:@"1111"];
        return nil;
    }];
    
    //2.建立连接
    RACMulticastConnection *connect = [signal publish];
    
    // 3.订阅信号，
    // 注意：订阅信号，也不能激活信号，只是保存订阅者到数组，必须通过连接,当调用连接，就会一次性调用所有订阅者的sendNext:
    [connect.signal subscribeNext:^(id  _Nullable x) {
        
        NSLog(@"订阅者一信号");
    }];
    
    [connect.signal subscribeNext:^(id x) {
        
        NSLog(@"订阅者二信号");
        
    }];
    
    // 4.连接,激活信号
    [connect connect];
}

//RACCommand简单使用
- (void)learn05{
    
    // 一、RACCommand使用步骤:
    // 1.创建命令 initWithSignalBlock:(RACSignal * (^)(id input))signalBlock
    // 2.在signalBlock中，创建RACSignal，并且作为signalBlock的返回值
    // 3.执行命令 - (RACSignal *)execute:(id)input
    
    // 二、RACCommand使用注意:
    // 1.signalBlock必须要返回一个信号，不能传nil.
    // 2.如果不想要传递信号，直接创建空的信号[RACSignal empty];
    // 3.RACCommand中信号如果数据传递完，必须调用[subscriber sendCompleted]，这时命令才会执行完毕，否则永远处于执行中。
    // 4.RACCommand需要被强引用，否则接收不到RACCommand中的信号，因此RACCommand中的信号是延迟发送的。
    
    // 三、RACCommand设计思想：内部signalBlock为什么要返回一个信号，这个信号有什么用。
    // 1.在RAC开发中，通常会把网络请求封装到RACCommand，直接执行某个RACCommand就能发送请求。
    // 2.当RACCommand内部请求到数据的时候，需要把请求的数据传递给外界，这时候就需要通过signalBlock返回的信号传递了。
    
    // 四、如何拿到RACCommand中返回信号发出的数据。
    // 1.RACCommand有个执行信号源executionSignals，这个是signal of signals(信号的信号),意思是信号发出的数据是信号，不是普通的类型。
    // 2.订阅executionSignals就能拿到RACCommand中返回的信号，然后订阅signalBlock返回的信号，就能获取发出的值。
    
    // 五、监听当前命令是否正在执行executing
    
    // 六、使用场景,监听按钮点击，网络请求

    // 1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        
        NSLog(@"执行命令");
        // 如果不想要传递信号，直接创建空的信号
        //return [RACSignal empty];
        
        // 2.创建信号,用来传递数据
        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            
            [subscriber sendNext:@"请求数据"];
            // 注意：数据传递完，最好调用sendCompleted，这时命令才执行完毕。
            [subscriber sendCompleted];
            
            return nil;
        }];
        return signal;
    }];
    
    _command = command;
    
    // 3.订阅RACCommand中的信号
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        
        [x subscribeNext:^(id x) {
            
            NSLog(@"executionSignals:%@",x);
        }];
    }];
    
    // RAC高级用法
    // switchToLatest:用于signal of signals，获取signal of signals发出的最新信号,也就是可以直接拿到RACCommand中的信号
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        
        NSLog(@"switchToLatest:%@",x);
    }];
    
    // 4.监听命令是否执行完毕,默认会来一次，可以直接跳过，skip表示跳过第一次信号。
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        
        if ([x boolValue] == YES) {
            // 正在执行
            NSLog(@"正在执行");
            
        }else{
            // 执行完成
            NSLog(@"执行完成");
        }
    }];
    
    // 5.执行命令
    [self.command execute:@1];
}

//RACSequence和RACTuple简单使用
- (void)learn04{
    
    // 1.遍历数组
    NSArray *numbers = @[@1,@2,@3,@4];
    
    // 这里其实是三步
    // 第一步: 把数组转换成集合RACSequence numbers.rac_sequence
    // 第二步: 把集合RACSequence转换RACSignal信号类,numbers.rac_sequence.signal
    // 第三步: 订阅信号，激活信号，会自动把集合中的所有值，遍历出来。
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 2.遍历字典,遍历出来的键值对会包装成RACTuple(元组对象)
    NSDictionary *dict = @{@"name":@"寒江",@"age":@18};
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
        // 解包元组，会把元组的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString *key,NSString *value) = x;
        
        // 相当于以下写法
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        
        NSLog(@"%@ %@",key,value);
        
    }];
}

// 需求:
// 1.给当前控制器添加一个按钮，push到另一个控制器界面
// 2.另一个控制器view中有个按钮，点击按钮，通知当前控制器
- (void)btnClick{
    WGRACTwoViewController *vc = [[WGRACTwoViewController alloc] init];
    // 设置代理信号
    vc.delegateSub = [RACSubject subject];
    // 订阅代理信号
    [vc.delegateSub subscribeNext:^(id  _Nullable x) {
        NSLog(@"点击了通知按钮:%@", x);
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

//RACReplaySubject简单使用
- (void)learn03{
    
    // RACReplaySubject使用步骤:
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.可以先订阅信号，也可以先发送信号。
    // 2.1 订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 2.2 发送信号 sendNext:(id)value
    
    // RACReplaySubject:底层实现和RACSubject不一样。
    // 1.调用sendNext发送信号，把值保存起来，然后遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    // 2.调用subscribeNext订阅信号，遍历保存的所有值，一个一个调用订阅者的nextBlock
    
    // 如果想当一个信号被订阅，就重复播放之前所有值，需要先发送信号，在订阅信号。
    // 也就是先保存值，在订阅值。
    
    RACReplaySubject *replaySubject = [RACReplaySubject subject];
    // 2.发送信号
    [replaySubject sendNext:@1];
    [replaySubject sendNext:@2];
    
    // 3.订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"learn03第一个订阅者接收到的数据%@",x);
    }];
    
    // 订阅信号
    [replaySubject subscribeNext:^(id x) {
        
        NSLog(@"learn03第二个订阅者接收到的数据%@",x);
    }];
}

//RACSubject简单使用:
- (void)learn02{
    
    // RACSubject使用步骤
    // 1.创建信号 [RACSubject subject]，跟RACSiganl不一样，创建信号时没有block。
    // 2.订阅信号 - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 sendNext:(id)value
    
    // RACSubject:底层实现和RACSignal不一样。
    // 1.调用subscribeNext订阅信号，只是把订阅者保存起来，并且订阅者的nextBlock已经赋值了。
    // 2.调用sendNext发送信号，遍历刚刚保存的所有订阅者，一个一个调用订阅者的nextBlock。
    
    //1.创建信号
    RACSubject *subject = [RACSubject subject];
    //2.订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"learn02第一个订阅者%@",x);
    }];
    [subject subscribeNext:^(id  _Nullable x) {
        // block调用时刻：当信号发出新值，就会调用.
        NSLog(@"learn02第二个订阅者%@",x);
    }];
    //3.发送信号
    [subject sendNext:@"1"];
}

//RACSiganl简单使用:
- (void)learn01{
    
    // RACSignal使用步骤：
    // 1.创建信号 + (RACSignal *)createSignal:(RACDisposable * (^)(id<RACSubscriber> subscriber))didSubscribe
    // 2.订阅信号,才会激活信号. - (RACDisposable *)subscribeNext:(void (^)(id x))nextBlock
    // 3.发送信号 - (void)sendNext:(id)value
    
    
    // RACSignal底层实现：
    // 1.创建信号，首先把didSubscribe保存到信号中，还不会触发。
    // 2.当信号被订阅，也就是调用signal的subscribeNext:nextBlock
    // 2.2 subscribeNext内部会创建订阅者subscriber，并且把nextBlock保存到subscriber中。
    // 2.1 subscribeNext内部会调用siganl的didSubscribe
    // 3.siganl的didSubscribe中调用[subscriber sendNext:@1];
    // 3.1 sendNext底层其实就是执行subscriber的nextBlock
    
    //1.创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        // block调用时刻：每当有订阅者订阅信号，就会调用block。
        // 2.发送信号
        [subscriber sendNext:@(111)];
        
        // 如果不在发送数据，最好发送信号完成，内部会自动调用[RACDisposable disposable]取消订阅信号。
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            
            // block调用时刻：当信号发送完成或者发送错误，就会自动执行这个block,取消订阅信号。
            
            // 执行完Block后，当前信号就不在被订阅了。
            
            NSLog(@"信号被销毁");
        }];
    }];
    
    // 3.订阅信号,才会激活信号.
    [signal subscribeNext:^(id  _Nullable x) {
        
        // block调用时刻：每当有信号发出数据，就会调用block.
        NSLog(@"接收到数据:%@",x);
    }];
}

-(UIButton *)btn{
    if (!_btn) {
        
        _btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
        _btn.backgroundColor = [UIColor greenColor];
        [_btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}

-(UIView *)redView{
    if (!_redView) {
        _redView = [[UIView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
        _redView.backgroundColor = [UIColor redColor];
        
        UIButton *butn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        butn.backgroundColor = [UIColor greenColor];
        [butn addTarget:self action:@selector(butnClick) forControlEvents:UIControlEventTouchUpInside];
        butn.backgroundColor = [UIColor yellowColor];
        [_redView addSubview:butn];
    }
    return _redView;
}

-(UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 250, 200, 30)];
        _textField.backgroundColor = [UIColor lightGrayColor];
    }
    return _textField;
}

@end
