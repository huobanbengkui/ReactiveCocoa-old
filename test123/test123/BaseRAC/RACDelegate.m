//
//  RACDelegate.m
//  test123
//
//  Created by guowenke on 2019/12/18.
//  Copyright © 2019 guowenke. All rights reserved.
//

#import "RACDelegate.h"

@implementation RACDelegate

- (RACSubject *)clickSignal {
    if (!_clickSignal) {
        _clickSignal = [RACSubject subject];
    }
    return _clickSignal;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    [_clickSignal sendNext:@"发生了点击事件！！"];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
