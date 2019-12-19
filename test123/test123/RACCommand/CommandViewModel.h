//
//  CommandViewModel.h
//  test123
//
//  Created by guowenke on 2019/12/19.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HTTPRequestStatus) {
    HTTPRequestStatusBegin,
    HTTPRequestStatusEnd,
    HTTPRequestStatusError,
};

NS_ASSUME_NONNULL_BEGIN

@interface CommandViewModel : NSObject

@property(nonatomic, strong) RACCommand *requestData;
@property(nonatomic, assign) HTTPRequestStatus requestStatus;

@property (strong, nonatomic) NSDictionary *data;
@property (strong, nonatomic) NSError* error;


@end

NS_ASSUME_NONNULL_END
