//
//  RACSignalVC.m
//  test123
//
//  Created by guowenke on 2019/12/18.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "RACSignalVC.h"

@interface RACSignalVC ()

@end

@implementation RACSignalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // 示例
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"12dd");
        // 发布信息
        [subscriber sendNext:@""];
        
        // 表示信息已经发送完成，内部会自动调用[RACDisposable disposable]取消订阅信号
        [subscriber sendCompleted];
        
        return [RACDisposable disposableWithBlock:^{
            // 订阅者被销毁，或者主动取消订阅
        }];
    }];
    // RACMulticastConnection 一个信号被多次订阅，信号仅仅触发一次
    RACMulticastConnection *connect = [signal publish];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"33333333333");
    }];
    [connect.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"4444444444");
    }];
    [connect connect];
    /*
    // 订阅信号
    RACDisposable *disposable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"111111111");
    }];
    [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"222222222222");
    }];
    // 取消订阅
    [disposable dispose];
     */
    /**
     RACSubscriber：协议类，拿到订阅信号的Block，然后发送出去；
     RACDisposable：这个类描述的是对订阅关系的取消，和相关资源的清理；
     */
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
