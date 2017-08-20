//
//  UILabel+PHUtils.m
//  Pods
//
//  Created by 項普華 on 2017/8/15.
//
//

#import "UILabel+PHUtils.h"
#import "UIView+PHUtils.h"

@implementation UILabel (PHUtils)

/**
 文字
 */
- (UILabel *(^)(NSString *text))ph_text {
    return ^id(NSString *text) {
        self.text = text;
        return self;
    };
}
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))ph_textColor {
    return ^id(UIColor *textColor) {
        self.textColor = textColor;
        return self;
    };
}
/**
 字体
 */
- (UILabel *(^)(UIFont *font))ph_font {
    return ^id(UIFont *font) {
        self.font = font;
        return self;
    };
}
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))ph_fontSize {
    return ^id(CGFloat fontSize) {
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))ph_textAlignment {
    return ^id(NSTextAlignment alignment) {
        self.textAlignment = alignment;
        return self;
    };
}
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))ph_lineNum {
    return ^id(NSUInteger lineNum) {
        self.numberOfLines = lineNum;
        return self;
    };
}


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
                       fontSize:(CGFloat)fontSize {
    UILabel *result = UILabel
                        .ph_create(superView, layout)
                        .ph_convertToLabel()
                        .ph_textColor(textColor)
                        .ph_fontSize(fontSize)
                        .ph_text(text);
    return result;
}


@end
