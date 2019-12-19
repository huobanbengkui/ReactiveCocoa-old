//
//  RACFilterVC.m
//  test123
//
//  Created by guowenke on 2019/12/19.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "RACFilterVC.h"

@interface RACFilterVC ()

@end

@implementation RACFilterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    /**
     1: fillter 过滤
     [[self.textField.rac_textSignal filter:^BOOL(NSString * _Nullable value) {
            return value.length > 5;
        }] subscribeNext:^(NSString * _Nullable x) {
            NSLog(@"%@",x);
        }];
     */
    /**
     2：ignore 忽略
     RACSubject * subject = [RACSubject subject];
     [[subject ignore:@"a"] subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
     }];
     [subject sendNext:@"a"]; // 不能通过
     [subject sendNext:@"a1"]; // 可以通过
     */
    /**
     3：take 指定哪些信号 正序 | takeLast 倒序 在使用takeLast的使用一定要告诉系统，发送完成了，不然就没效果
     RACSubject * subject = [RACSubject subject];
     [[subject take:1] subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
     }];
     [subject sendNext:@"aaa"];  // 不可通过
     [subject sendNext:@"bbb"];  // 可以通过
     [subject sendNext:@"cccc"]; // 可以通过
     */
    
    /**
     4：takeUntil 需要一个信号作为标记，当标记的信号发送数据，就停止
     RACSubject * subject = [RACSubject subject];
     RACSubject * subject1 = [RACSubject subject];

     [[subject takeUntil:subject1] subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
     }];
     [subject1 subscribeNext:^(id  _Nullable x) {
            NSLog(@"%@",x);
     }];
     [subject sendNext:@"1"];
     
     [subject1 sendNext:@"Stop"];
     [subject sendNext:@"4"];
     */
    
    /**
     5：distinctUntilChanged 剔除一样的信号
     RACSubject * subject = [RACSubject subject];
     [[subject distinctUntilChanged] subscribeNext:^(id  _Nullable x) {
         NSLog(@"%@",x);
     }];
     [subject sendNext:@"x"];
     [subject sendNext:@"x"];
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
