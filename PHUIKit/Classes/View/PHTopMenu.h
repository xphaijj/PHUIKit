//
//  PHTopMenu.h
//  App
//
//  Created by 項普華 on 2017/7/18.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PHBaseLib/PHMacro.h>

@interface PHTopMenu : UIView

/**
 菜单栏的高度
 */
@property (nonatomic, assign) CGFloat menuHeight;
/**
 普通颜色
 */
@property (nonatomic, strong) UIColor *normalColor;
/**
 普通字体
 */
@property (nonatomic, strong) UIFont *normalFont;
/**
 选中的颜色
 */
@property (nonatomic, strong) UIColor *tintColor;
/**
 选中字体
 */
@property (nonatomic, strong) UIFont *tintFont;
/**
 当前选中的索引
 */
@property (nonatomic, assign) NSInteger currentSelectedIndex;
/**
 当前选中索引的标识高度 默认2
 */
@property (nonatomic, assign) CGFloat currentSelectedMenuHeight;

/**
 显示顶部菜单栏

 @param toView 目标视图
 @param titles 标题数组
 @param views views
 @param valueBlock 点击回调
 */
+ (PHTopMenu *)createTopMenuToView:(UIView *)toView
                            titles:(NSArray<NSString *> *)titles
                             views:(NSArray<UIView *> *)views
                        clickBlock:(PHValueBlock)valueBlock;


- (void)show;


@end
