//
//  PHButton.m
//  App
//
//  Created by 項普華 on 2017/6/4.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHButton.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIImage+PHUtils.h"
#import <AFNetworking/UIButton+AFNetworking.h>

@implementation PHButton

/**
 按钮创建
 */
+ (PHButton *(^)(BOOL enable))ph_create {
    return ^id(BOOL enable) {
        PHButton *button = [PHButton buttonWithType:UIButtonTypeCustom];
        button.adjustsImageWhenDisabled = NO;
        button.adjustsImageWhenHighlighted = NO;
        button.enabled = enable;
        return button;
    };
}

/**
 设置背景色
 */
- (PHButton *(^)(UIColor *bgColor))ph_backgroundColor {
    return ^id(UIColor *bgColor) {
        [self setBackgroundColor:bgColor];
        return self;
    };
}

/**
 圆角率
 */
- (PHButton *(^)(NSInteger radius))ph_radius {
    return ^id(NSInteger radius) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        return self;
    };
}

/**
 添加到View 中  并且添加了布局
 */
- (PHButton *(^)(id view, PHLayout layout))ph_addToView {
    return ^id(id targetView, PHLayout layout) {
        if ([targetView respondsToSelector:@selector(addSubview:)]) {
            [targetView addSubview:self];
            [self mas_makeConstraints:layout];
        } else {
            PHLogWarn(@"添加视图出错");
        }
        return self;
    };
}

/**
 设置标题
 */
- (PHButton *(^)(NSString *title))ph_title {
    return ^id(NSString *title) {
        [self setTitle:title forState:UIControlStateNormal];
        return self;
    };
}

/**
 设置图片 imageName 或者 图片路径  或者image 都可以
 */
- (PHButton *(^)(id image))ph_image {
    return ^id(id image) {
        if ([image isKindOfClass:[UIImage class]]) {
            [self setImage:image forState:UIControlStateNormal];
        }
        else if ([image isKindOfClass:[NSURL class]]) {
            [self setImageForState:UIControlStateNormal withURL:image];
        }
        else if ([image isKindOfClass:[NSString class]]) {
            if ([image hasPrefix:@"http://"] || [image hasPrefix:@"https://"]) {
                [self setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:image]];
            }
            else {
                [self setImage:[UIImage ph_imageNamed:image] forState:UIControlStateNormal];
            }
        }
        [self setContentMode:UIViewContentModeScaleAspectFit];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        return self;
    };
}



/**
 设置字体颜色
 */
- (PHButton *(^)(UIColor *textColor))ph_textColor {
    return ^id(UIColor *textColor) {
        [self setTitleColor:textColor forState:UIControlStateNormal];
        return self;
    };
}

/**
 单击事件
 */
- (PHButton *(^)(PHButtonClick clickBlock))ph_clickAction {
    return ^id(PHButtonClick click) {
        if (click) {
            [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
                if (click) {
                    click(self);
                }
            }];
        }
        return self;
    };
}

/**
 布局
 */
- (PHButton *(^)(PHButtonLayout layout))ph_layout {
    return ^id(PHButtonLayout layout) {
        [self layoutIfNeeded];
        switch (layout) {
            case PHButtonLayoutImageAtLeft: {
                self.titleEdgeInsets = UIEdgeInsetsZero;
                self.imageEdgeInsets = UIEdgeInsetsZero;
            }
                break;
            case PHButtonLayoutImageAtRight: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width-self.frame.size.width + self.titleLabel.intrinsicContentSize.width, 0.0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0, -self.titleLabel.frame.size.width-self.frame.size.width+self.imageView.frame.size.width);
            }
                break;
            case PHButtonLayoutImageAtTop: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, -self.imageView.frame.size.height-20, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, 0.0, 0.0, -self.titleLabel.intrinsicContentSize.width);
            }
                break;
            case PHButtonLayoutImageAtBottom: {
                self.titleEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, -self.imageView.frame.size.width, 0.0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -self.imageView.frame.size.height-20, -self.titleLabel.intrinsicContentSize.width);
            }
                break;
        }
        return self;
    };
}

@end
