//
//  PHVerticalLineView.m
//  App
//
//  Created by Alex on 2017/7/22.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHLineView.h"

#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>

@interface PHLineView () {
    
}
@property (nonatomic, assign) PHDirection lineDirection;
@property (nonatomic, assign) CGFloat margin;

@end

@implementation PHLineView
/**
 创建
 */
+ (PHLineView *(^)(UIView *superView))ph_create {
    return ^id(UIView *superView) {
        PHLineView *lineView = [[PHLineView alloc] init];
        lineView.backgroundColor = PH_ColorWithHexString(@"0xcccccc");
        [superView addSubview:lineView];
        lineView.lineDirection = PHDirectionBottom;
        lineView.margin = 0;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(superView);
            make.bottom.equalTo(superView);
            make.height.equalTo(@0.5);
        }];
        return lineView;
    };
}
/**
 上下左右
 */
- (PHLineView *(^)(PHDirection direction))ph_direction {
    return ^id(PHDirection direction) {
        self.lineDirection = direction;
        [self _reloadUI];
        return self;
    };
}

/**
 边距
 */
- (PHLineView *(^)(CGFloat margin))ph_margin {
    return ^id(CGFloat margin) {
        self.margin = margin;
        [self _reloadUI];
        return self;
    };
}
/**
 颜色
 */
- (PHLineView *(^)(UIColor *lineColor))ph_lineColor {
    return ^id(UIColor *lineColor) {
        self.backgroundColor = lineColor;
        return self;
    };
}


- (void)_reloadUI {
    switch (self.lineDirection) {
        case PHDirectionTop:
        {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(self.margin);
                make.right.equalTo(self).with.offset(-self.margin);
                make.top.equalTo(self);
                make.height.equalTo(@0.5);
            }];
        }
            break;
        case PHDirectionBottom:
        {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).with.offset(self.margin);
                make.right.equalTo(self).with.offset(-self.margin);
                make.bottom.equalTo(self);
                make.height.equalTo(@0.5);
            }];
        }
            break;
        case PHDirectionLeft:
        {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(self.margin);
                make.bottom.equalTo(self).with.offset(-self.margin);
                make.left.equalTo(self);
                make.width.equalTo(@0.5);
            }];
        }
            break;
        case PHDirectionRight:
        {
            [self mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).with.offset(self.margin);
                make.bottom.equalTo(self).with.offset(-self.margin);
                make.right.equalTo(self);
                make.width.equalTo(@0.5);
            }];
        }
            break;
    }
}

@end
