//
//  UIImageView+PHUtils.h
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>

@interface UIImageView (PHUtils)

/**
 设置image
 */
- (UIImageView *(^)(id image))ph_image;
/**
 设置显示方式
 */
- (UIImageView *(^)(UIViewContentMode contentMode))ph_contentMode;

#pragma mark - 快速创建对象

/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局约束
 @param image image
 @param contentMode contentMode
 @return 当前对象
 */
+ (UIImageView *)ph_createSuperView:(UIView *)superView
                             layout:(PHLayout)layout
                              image:(id)image
                        contentMode:(UIViewContentMode)contentMode;

@end
