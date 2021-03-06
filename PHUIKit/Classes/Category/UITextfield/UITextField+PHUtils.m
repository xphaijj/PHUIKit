//
//  UITextField+PHUtils.m
//  Pods
//
//  Created by 項普華 on 2017/8/24.
//
//

#import "UITextField+PHUtils.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface UITextField (PHData)

@end

@implementation UITextField (PHData)

@end

@implementation UITextField (PHUtils)

/**
 文本框的类型
 */
- (UITextField *(^)(UITextBorderStyle style))ph_textBorderStyle {
    return ^id(UITextBorderStyle style) {
        self.borderStyle = style;
        return self;
    };
}
/**
 文本框的占位文字
 */
- (UITextField *(^)(NSString *placeholder))ph_placeholder {
    return ^id(NSString *placeholder) {
        self.placeholder = placeholder;
        return self;
    };
}
/**
 是否密文显示
 */
- (UITextField *(^)(BOOL secure))ph_secure {
    return ^id(BOOL secure) {
        self.secureTextEntry = secure;
        return self;
    };
}
/**
 左边视图
 */
- (UITextField *(^)(UIView *leftView))ph_leftView {
    return ^id(UIView *leftView) {
        if (CGRectEqualToRect(leftView.frame, CGRectZero)) {
            leftView.frame = CGRectMake(0, 0, 44, 44);
        }
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        return self;
    };
}
/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))ph_textColor {
    return ^id(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}

/**
 键盘类型
 */
- (UITextField *(^)(UIKeyboardType keyboardType))ph_keyboardType {
    return ^id (UIKeyboardType keyboardType) {
        self.keyboardType = keyboardType;
        return self;
    };
}

/**
 return type
 */
- (UITextField *(^)(UIReturnKeyType returnKeyType))ph_returnKeyType {
    return ^id(UIReturnKeyType returnKeyType) {
        self.returnKeyType = returnKeyType;
        return self;
    };
}

/**
 文本框内容发生改变时的调用
 */
- (UITextField *(^)(PHValueBlock textDidChange))ph_textDidChange {
    return ^id(PHValueBlock textDidChange) {
        [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            if (textDidChange) {
                textDidChange(x);
            }
        }];
        return self;
    };
}

/**
 过滤类型
 */
- (UITextField *(^)(PHStringFilterType filterType))ph_filterType {
    return ^id(PHStringFilterType filterType) {
        return self;
    };
}

/**
 限制长度
 */
- (UITextField *(^)(NSUInteger limitLength))ph_limitLength {
    return ^id(NSUInteger limitLength) {
        [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            
        }];
        return self;
    };
}

@end




















