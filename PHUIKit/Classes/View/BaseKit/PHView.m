//
//  PHView.m
//  App
//
//  Created by 項普華 on 2017/6/3.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHView.h"
#import <ReactiveObjC.h>

@implementation PHView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    PHView *baseView = [super allocWithZone:zone];
    @weakify(baseView);
    [[baseView rac_signalForSelector:@selector(initWithViewModel:block:)] subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(baseView);
        if ([baseView respondsToSelector:@selector(ph_addSubviews)]) {
            [baseView ph_addSubviews];
        }
        if ([baseView respondsToSelector:@selector(ph_bindViewModel)]) {
            [baseView ph_bindViewModel];
        }
        if ([baseView respondsToSelector:@selector(ph_autolayout)]) {
            [baseView ph_autolayout];
        }
        if ([baseView respondsToSelector:@selector(ph_reloadData)]) {
            [baseView ph_reloadData];
        }
    }];
    
    return baseView;
}

- (instancetype)initWithViewModel:(PHViewModel *)viewModel block:(PHViewBlock)block {
    self = [super init];
    if (self) {
        self.viewModel = viewModel;
        self.block = block;
    }
    return self;
}

/**
 VC dismiss的操作
 */
- (void)ph_dismiss {
    PHLog(@"%@ 视图消失", NSStringFromClass([self class]));
}


@end
