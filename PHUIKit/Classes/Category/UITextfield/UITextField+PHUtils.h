//
//  UITextField+PHUtils.h
//  Pods
//
//  Created by 項普華 on 2017/8/24.
//
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>

typedef NS_OPTIONS(NSUInteger, PHStringFilterType) {
    PH_STRING_FILTER_TYPE_NUMBER = 100,//纯数字
    PH_STRING_FILTER_TYPE_LETTER,//纯字母
    PH_STRING_FILTER_TYPE_HANZI,//汉字
    PH_STRING_FILTER_TYPE_EMOJI,//emoji
    PH_STRING_FILTER_TYPE_SYMBOL,//符号
    PH_STRING_FILTER_TYPE_NONE,//没有限制
};


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
 是否密文显示
 */
- (UITextField *(^)(BOOL secure))ph_secure;
/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))ph_textColor;
/**
 左边视图
 */
- (UITextField *(^)(UIView *leftView))ph_leftView;
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
/**
 过滤类型
 */
- (UITextField *(^)(PHStringFilterType filterType))ph_filterType;



@end
