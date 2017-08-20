//
//  PHVerticalLineView.h
//  App
//
//  Created by Alex on 2017/7/22.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PHBaseLib/PHMacro.h>

@interface PHLineView : UIImageView

/**
 创建
 */
+ (PHLineView *(^)(UIView *superView))ph_create;
/**
 上下左右
 */
- (PHLineView *(^)(PHDirection direction))ph_direction;
/**
 边距
 */
- (PHLineView *(^)(CGFloat margin))ph_margin;
/**
 颜色
 */
- (PHLineView *(^)(UIColor *lineColor))ph_lineColor;

@end
