//
//  PHLabel.m
//  App
//
//  Created by 項普華 on 2017/6/4.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHLabel.h"

@implementation PHLabel


/**
 label创建
 */
+ (PHLabel *(^)())ph_create {
    return ^id() {
        PHLabel *label = [[PHLabel alloc] init];
        label.font = [UIFont systemFontOfSize:16];
        return label;
    };
}
/**
 圆角率
 */
- (PHLabel *(^)(NSInteger radius))ph_radius {
    return ^id(NSInteger radius) {
        self.layer.cornerRadius = radius;
        return self;
    };
}


/**
 添加到View 中  并且添加了布局
 */
- (PHLabel *(^)(id view, PHLayout layout))ph_addToView {
    return ^id(id targetView, PHLayout layout) {
        if ([targetView respondsToSelector:@selector(addSubview:)]) {
            [targetView addSubview:self];
            [self mas_makeConstraints:layout];
        }
        return self;
    };
}

/**
 设置内容
 */
- (PHLabel *(^)(NSString *title))ph_text {
    return ^id(NSString *title) {
        if ([self respondsToSelector:@selector(setText:)]) {
            self.text = title;
        }
        return self;
    };
}

/**
 设置label的Font
 */
- (PHLabel *(^)(UIFont *font))ph_font {
    return ^id(UIFont *font) {
        if ([self respondsToSelector:@selector(setFont:)]) {
            self.font = font;
        }
        return self;
    };
}

/**
 这是字体颜色
 */
- (PHLabel *(^)(UIColor *textColor))ph_textColor {
    return ^id(UIColor *textColor) {
        if ([self respondsToSelector:@selector(setTextColor:)]) {
            self.textColor = textColor;
        }
        return self;
    };
}

/**
 设置行数
 */
- (PHLabel *(^)(NSInteger lineNum))ph_lineNum {
    return ^id(NSInteger lineNum) {
        if ([self respondsToSelector:@selector(setNumberOfLines:)]) {
            self.numberOfLines = lineNum;
        }
        return self;
    };
}

@end
