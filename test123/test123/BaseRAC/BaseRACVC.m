//
//  BaseRACVC.m
//  test123
//
//  Created by guowenke on 2019/12/18.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "BaseRACVC.h"
#import "RACDelegate.h"

@interface BaseRACVC ()

@end

@implementation BaseRACVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Button点击绑定
    @weakify(self);
    UIButton *button = [self creatButton:CGRectMake(20, 84, 100, 44) title:@"RAC点击绑定"];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        button.backgroundColor = [UIColor orangeColor];
    }];
    // KVO监听
    UIButton *kvoButton = [self creatButton:CGRectMake(140, 84, 100, 44) title:@"KVO监听"];
    [[kvoButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        self.view.backgroundColor = [UIColor yellowColor];
    }];
    [[RACObserve(self.view, backgroundColor) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        // 该方法在程序运行的时候，就可以监听到
        NSLog(@"监听到背景色发生了改变");
    }];
    // 通知的使用 注册通知
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"sendNotification" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        NSLog(@"%@", x);
    }];
    UIButton *notificationButton = [self creatButton:CGRectMake(20, 148, 100, 44) title:@"发送通知"];
    [[notificationButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"sendNotification" object:nil];
    }];
    // 监听textField输入
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(140, 148, 100, 44)];
    textField.placeholder = @"监听输入框内容的变化";
    textField.backgroundColor = [UIColor redColor];
    [self.view addSubview:textField];
    [textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        NSLog(@"%@", x);
        // 赋值
        // RAC(_label,text) = _textField.rac_textSignal;
    }];
    // 代替代理 
    RACDelegate *delegate = [[RACDelegate alloc] initWithFrame:CGRectMake(20, 212, 100, 44)];
    delegate.backgroundColor = [UIColor redColor];
    [self.view addSubview:delegate];
    [delegate.clickSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    /**
     RACSubject：RACSignal的子类，对父类RACSignal进行封装，将销毁信号的管理，放在内部进行自动管理
     基本用法：必须先订阅，在发送信号
     // 1.创建信号
     RACSubject *subject = [RACSubject subject];
     // 2.订阅信号
     [subject subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
     }];
     // 3.发送信号
     [subject sendNext:@"this is a RACSubject"];
     详情：https://www.jianshu.com/p/5f51ac4885b4
     
     RACReplaySubject：可以先发送信号，在订阅
     参考：https://www.jianshu.com/p/5d891caa033d
     */

}

- (UIButton *)creatButton:(CGRect)frame title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    return button;
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
