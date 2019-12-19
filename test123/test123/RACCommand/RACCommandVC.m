//
//  RACCommandVC.m
//  test123
//
//  Created by guowenke on 2019/12/19.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "RACCommandVC.h"
#import "CommandViewModel.h"

@interface RACCommandVC ()

@property (nonatomic, strong)CommandViewModel *viewModel;
@property (nonatomic, strong)UILabel *titleLabel;

@end

@implementation RACCommandVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 示例
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
        // 拿到订阅时，输入的信息
        NSLog(@"%@", input);
        
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            // 发送信息
            [subscriber sendNext:@"发送信息"];
            
            return [RACDisposable disposableWithBlock:^{
                
            }];
        }];
    }];
    // 订阅发送的信息
//    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
    [command.executionSignals subscribeNext:^(id  _Nullable x) {
        // 开始执行
        [x subscribeNext:^(id  _Nullable x) {
            // 拿到"发送信息"信号
        }];
    }];
    // 监听运行状态
    [[command.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
        if ([x boolValue]) {
            NSLog(@"还在执行");
        }else {
            NSLog(@"执行结束了");
        }
    }];
    // 订阅
    [command execute:@"订阅信息"];
    
    /**
     switchToLatest：获取最新信号
     skip：忽略的次数
     */
    
    // 应用场景 伪代码
    _viewModel = [[CommandViewModel alloc] init];
    @weakify(self);
    [[RACObserve(self.viewModel, requestStatus) skip:1] subscribeNext:^(id  _Nullable x) {
        switch ([x intValue]) {
            case HTTPRequestStatusBegin:
                break;
            case HTTPRequestStatusEnd:
                break;
            case HTTPRequestStatusError:
                break;
            default:
                break;
        }
    }];
    [[RACObserve(self.viewModel, data) skip:1] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 注意self.titleLabel不能为nil，否则方法不执行；
    RAC(self.titleLabel, text) = [[RACObserve(self.viewModel, data) skip:1] map:^id _Nullable(id  _Nullable value) {
        NSLog(@"valeu值=%@", value);
        return @"123444";
    }];
    //    _button.rac_command = _viewModel.requestData;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.backgroundColor = [UIColor redColor];
    button.frame = CGRectMake(20, 84, 100, 40);
    [self.view addSubview:button];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel.requestData execute:@"96671e1a812e46dfa4264b9b39f3e225"];
    }];
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
