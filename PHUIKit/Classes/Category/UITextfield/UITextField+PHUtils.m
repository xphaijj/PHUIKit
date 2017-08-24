//
//  UITextField+PHUtils.m
//  Pods
//
//  Created by 項普華 on 2017/8/24.
//
//

#import "UITextField+PHUtils.h"
#import <ReactiveObjC/ReactiveObjC.h>

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

@end
