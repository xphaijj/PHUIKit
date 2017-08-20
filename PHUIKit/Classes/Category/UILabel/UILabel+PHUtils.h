//
//  UILabel+PHUtils.h
//  Pods
//
//  Created by 項普華 on 2017/8/15.
//
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>

@interface UILabel (PHUtils)

/**
 文字
 */
- (UILabel *(^)(NSString *text))ph_text;
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))ph_textColor;
/**
 字体
 */
- (UILabel *(^)(UIFont *font))ph_font;
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))ph_fontSize;
/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))ph_textAlignment;
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))ph_lineNum;


#pragma mark - 快速创建对象

/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局
 @param text 文本
 @param textColor 颜色
 @param fontSize 字号
 @return 当前对象
 */
+ (UILabel *)ph_createSuperView:(UIView *)superView
                         layout:(PHLayout)layout
                           text:(NSString *)text
                          color:(UIColor *)textColor
                       fontSize:(CGFloat)fontSize;


@end
