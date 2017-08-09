//
//  PHLabel.h
//  App
//
//  Created by 項普華 on 2017/6/4.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PHBaseLib/PHMacro.h>

@interface PHLabel : UILabel

/**
 label创建
 */
+ (PHLabel *(^)())ph_create;
/**
 圆角率
 */
- (PHLabel *(^)(NSInteger radius))ph_radius;


/**
 添加到View 中  并且添加了布局
 */
- (PHLabel *(^)(id view, PHLayout layout))ph_addToView;


/**
 设置内容
 */
- (PHLabel *(^)(NSString *title))ph_text;

/**
 设置label的Font
 */
- (PHLabel *(^)(UIFont *font))ph_font;

/**
 这是字体颜色
 */
- (PHLabel *(^)(UIColor *textColor))ph_textColor;

/**
 设置行数
 */
- (PHLabel *(^)(NSInteger lineNum))ph_lineNum;


@end
