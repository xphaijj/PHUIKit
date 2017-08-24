//
//  UIView+PHUtils.h
//  App
//
//  Created by 項普華 on 2017/6/24.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>


@interface UIView (PHUtils)
/**
 视图的创建
 */
+ (UIView *(^)(UIView *superView, PHLayout layout))ph_create;
/**
 视图的创建frame
 */
+ (UIView *(^)(UIView *superView, CGRect frame))ph_frame;
/**
 设置视图上的数据显示
 */
- (UIView *(^)(id data))ph_data;
/**
 设置背景颜色
 */
- (UIView *(^)(UIColor *bgColor))ph_backgroundColor;
/**
 设置圆角
 */
- (UIView *(^)(NSInteger radius))ph_radius;
/**
 设置边框颜色
 */
- (UIView *(^)(UIColor *borderColor))ph_borderColor;
/**
 设置边框宽度
 */
- (UIView *(^)(CGFloat borderWidth))ph_borderWidth;
/**
 设置阴影颜色
 */
- (UIView *(^)(UIColor *shadowColor))ph_shadowColor;
/**
 设置阴影的大小
 */
- (UIView *(^)(CGSize shadowOffset))ph_shadowSize;
/**
 设置阴影模糊度
 */
- (UIView *(^)(CGFloat blur))ph_blur;
/**
 设置tag
 */
- (UIView *(^)(NSInteger tag))ph_tag;
/**
 点击事件
 */
- (UIView *(^)(PHViewBlock clickBlock))ph_clickBlock;



#pragma mark - type convert
- (UIButton *(^)())ph_convertToButton;
- (UILabel *(^)())ph_convertToLabel;
- (UIImageView *(^)())ph_convertToImageView;
- (UITableView *(^)())ph_convertToTableView;
- (UITextField *(^)())ph_convertToTextField;


#pragma mark - normal method
/**
 获取当前视图的中心点
 
 @return 中心点
 */
- (CGPoint)ph_selfcenter;
/**
 获取当前view绑定的data

 @return data
 */
- (id)data;



@end
