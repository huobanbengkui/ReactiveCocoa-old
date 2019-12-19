//
//  CommandViewModel.m
//  test123
//
//  Created by guowenke on 2019/12/19.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "CommandViewModel.h"

@implementation CommandViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self subcribeCommandSignals];
    }
    return self;
}

- (RACCommand *)requestData {
    if (!_requestData) {
        @weakify(self);
        _requestData = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self);
            NSDictionary *parame = @{@"key": input};
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                [self postWithParame:parame success:^(NSDictionary *successDic) {
                    [subscriber sendNext:successDic];
                    [subscriber sendCompleted];
                } faile:^(NSDictionary *faileDic) {
                    [subscriber sendError:nil];
                }];
                return nil;
            }];
        }];
    }
    return _requestData;
}

- (void)subcribeCommandSignals {
    @weakify(self);
    [self.requestData.executionSignals subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.error = nil;
        self.requestStatus = HTTPRequestStatusBegin;
        [x subscribeNext:^(id  _Nullable x) {
            self.data = x;
            self.requestStatus = HTTPRequestStatusEnd;
        }];
    }];
    [self.requestData.errors subscribeError:^(NSError * _Nullable error) {
        @strongify(self);
        self.error = error;
        self.requestStatus = HTTPRequestStatusError;
    }];
}

- (void)postWithParame:(NSDictionary *)parame success:(void(^)(NSDictionary *))sucess faile:(void(^)(NSDictionary *))faile {
    sucess(@{@"result":@"successs1"});
}

@end
