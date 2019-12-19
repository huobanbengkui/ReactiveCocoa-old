//
//  ViewController.m
//  test123
//
//  Created by guowenke on 2019/12/2.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "ViewController.h"
#import "BaseRACVC.h"
#import "RACTimerVC.h"
#import "RACSignalVC.h"
#import "RACCommandVC.h"
#import "RACFilterVC.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 参考文章：https://www.jianshu.com/p/35a28cf0a22f
    // 示例参考：https://www.jianshu.com/p/c650108264e1
    
    self.dataArray = @[@"RAC基本用法", @"RAC定时器", @"RACSignal & RACMulticastConnection", @"RACCommand", @"RAC集合",  @"RAC等待多个信号，然后执行", @"RAC过滤", @"RAC组合", @"RAC热信号&冷信号"];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44.0;
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // RAC 基本用法
        BaseRACVC *vc = [[BaseRACVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1) {
        // RAC 定时器
        RACTimerVC *vc = [[RACTimerVC alloc] init];
        [self.navigationController pushViewController:vc animated:nil];
    }else if (indexPath.row == 2) {
        // RACSignal
        RACSignalVC *vc = [[RACSignalVC alloc] init];
        [self.navigationController pushViewController:vc animated:nil];
    }else if (indexPath.row == 3) {
        // RACCommandVC
        RACCommandVC *vc = [[RACCommandVC alloc] init];
        [self.navigationController pushViewController:vc animated:nil];
    } else if (indexPath.row == 4) {
        // RAC集合
        [self testSet];
    }  else if (indexPath.row == 5) {
        // RAC rac_liftSelector
        [self rac_liftSelector];
    } else if (indexPath.row == 6) {
        // RACFilter
        RACFilterVC *vc = [[RACFilterVC alloc] init];
        [self.navigationController pushViewController:vc animated:nil];
    } else if (indexPath.row == 7) {
        // RAC组合
        [self rac_concat];
    }else {
        /*
         RAC 热信号：RACSignal RACEmptySignal  RACDyamicSignal
                RACReturnSignal RACErrorSignal RACChannelTerminal
         RAC 冷信号：RACSubject RACReplaySubject RACBehaviorSubject
                RACGroupedSignal
         冷信号转换为热信号：RACMulticastConnection
        // 参考：https://www.jianshu.com/p/21beb4c59bcc
         */
    }
}

#pragma mark - RAC集合
- (void)testSet {
    // 数组
    NSArray *array = @[@"first", @"second", @"third"];
    [array.rac_sequence.signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    // 字典
    NSDictionary *dic = @{@"key":@"密码", @"value":@"密码值", @"phone":@"电话"};
    [dic.rac_sequence.signal subscribeNext:^(RACTuple * _Nullable x) {
        RACTupleUnpack(NSString *key,id value) = x;
        NSLog(@"key - %@ value - %@",key,value);
    }];
    // 元组
    RACTuple *tuple = [RACTuple tupleWithObjectsFromArray:@[@"大",@"今"] convertNullsToNils:YES];
    id value = tuple[0];
    id value2 = tuple.first;
    NSLog(@"%@ %@",value,value2);
}

#pragma mark - 等待多个信号完成，在执行下边的方法
- (void)rac_liftSelector {
    RACSignal *signal1 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:5.0 schedule:^{
            [subscriber sendNext:@"请求完成一个"];
        }];
        return nil;
    }];
    RACSignal *signal2 = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [[RACScheduler mainThreadScheduler] afterDelay:10.0 schedule:^{
            [subscriber sendNext:@"请求完成第二个"];
        }];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(resultStr:secondStr:) withSignalsFromArray:@[signal1, signal2]];
}

- (void)resultStr:(NSString *)str secondStr:(NSString *)secondStr {
    NSLog(@"%@  %@", str, secondStr);
}

#pragma mark - RAC组合
- (void)rac_concat {
    /*
    //监听文本框输入状态，确定按钮是否可以点击
    RAC(_loginBtn,enabled) = [RACSignal combineLatest:@[_accountTF.rac_textSignal,_passwordTF.rac_textSignal] reduce:^id _Nullable(NSString * account,NSString * password){
        return @(account.length && (password.length > 5));
    }];
    */
    /**
     * concat
     * then
     * merge
     * zipWith
     * combineLatest
     * reduce
     */
}

@end
