//
//  UITextField+PHUtils.h
//  Pods
//
//  Created by 項普華 on 2017/8/24.
//
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>

@interface UITextField (PHUtils)

/**
 文本框的类型
 */
- (UITextField *(^)(UITextBorderStyle style))ph_textBorderStyle;
/**
 文本框的占位文字
 */
- (UITextField *(^)(NSString *placeholder))ph_placeholder;

/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))ph_textColor;

/**
 键盘类型
 */
- (UITextField *(^)(UIKeyboardType keyboardType))ph_keyboardType;

/**
 return type
 */
- (UITextField *(^)(UIReturnKeyType returnKeyType))ph_returnKeyType;

/**
 文本框内容发生改变时的调用
 */
- (UITextField *(^)(PHValueBlock textDidChange))ph_textDidChange;



@end
