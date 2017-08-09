//
//  PHBaseVC+Loading.h
//  App
//
//  Created by 項普華 on 2017/6/24.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHBaseVC.h"

#import <PHBaseLib/PHMacro.h>

@interface PHBaseVC (Loading)

/**
 显示加载视图
 
 @param clickToDismiss 点击背景是否显示 默认为YES
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingViewClickToDismiss:(BOOL)clickToDismiss
                                 dismiss:(PHDismissBlock)dismissBlock;
/**
 显示加载视图

 @param imagename 加载视图上显示的image
 @param title 标题
 @param clickToDismiss 点击背景是否显示 默认为YES 
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingImagename:(NSString *)imagename
                          title:(NSString *)title
                 clickToDismiss:(BOOL)clickToDismiss
                        dismiss:(PHDismissBlock)dismissBlock;


/**
 显示无数据的视图
 
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingNoDataDismiss:(PHDismissBlock)dismissBlock;
/**
 显示无数据的视图

 @param imagename 显示的image
 @param title 重新加载按钮的标题
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingNoDataImagename:(NSString *)imagename
                          reloadTitle:(NSString *)title
                              dismiss:(PHDismissBlock)dismissBlock;

/**
 显示网络异常的视图
 
 @param dismissBlock 消失的回调
 */
- (void)ph_showNetworkDismiss:(PHDismissBlock)dismissBlock;

/**
 显示网络异常的视图

 @param imagename 显示的Image
 @param reloadTitle 重新加载的标题
 @param dismissBlock 消失的回调
 */
- (void)ph_showNetworkImagename:(NSString *)imagename
                    reloadTitle:(NSString *)reloadTitle
                        dismiss:(PHDismissBlock)dismissBlock;

/**
 消失加载视图以及消失没有数据的视图
 */
- (void)ph_dismissLoadingView;

@end
