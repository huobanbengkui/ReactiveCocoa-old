//
//  RACTimerVC.m
//  test123
//
//  Created by guowenke on 2019/12/18.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "RACTimerVC.h"

@interface RACTimerVC ()

@property (nonatomic, assign)NSInteger timeNumber;
@property (nonatomic, strong)RACDisposable *disposable;

@end

@implementation RACTimerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    [button setTitle:@"发送验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0];
    button.frame = CGRectMake(20, 84, 80, 40);
    [self.view addSubview:button];
    @weakify(self);
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        // 禁止按钮点击
        x.enabled = false;
        self.timeNumber = 20;
        [button setTitle:[NSString stringWithFormat:@"%@秒", @(self.timeNumber)] forState:UIControlStateNormal];
        // RAC Timer事件
        self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
            self.timeNumber--;
            if (self.timeNumber > 0) {
                [button setTitle:[NSString stringWithFormat:@"%@秒", @(self.timeNumber)] forState:UIControlStateNormal];
            }else {
                [button setTitle:@"发送验证码" forState:UIControlStateNormal];
                button.enabled = YES;
            }
            if (self.timeNumber == 0) {
                [self.disposable dispose];
            }
        }];
    }];
    /**
     RACScheduler：RAC 基于NSTread，GCD，NSOperation,进行的封装，主要用来进行多线程相关操作；
     更多内容参考：https://www.jianshu.com/p/320e231aca52
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
