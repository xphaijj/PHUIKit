//
//  PHView.h
//  App
//
//  Created by 項普華 on 2017/6/3.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PHBaseLib/PHMacro.h>
#import "PHViewModel.h"

@class PHView;

@protocol PHViewProtocol <NSObject>

@optional

/**
 页面的初始化
 
 @param viewModel 需要绑定的ViewModel
 @param block 页面上的操作回调
 */
- (instancetype)initWithViewModel:(PHViewModel *)viewModel
                            block:(PHViewBlock)block;

/**
 *  页面数据绑定
 */
- (void)ph_bindViewModel;

/**
 添加子视图
 */
- (void)ph_addSubviews;

/**
 布局
 */
- (void)ph_autolayout;

/**
 刷新数据
 */
- (void)ph_reloadData;

/**
 VC dismiss 的操作
 */
- (void)ph_dismiss;

@end


@interface PHView : UIView<PHViewProtocol>

//当前页面绑定的ViewModel
@property (nonatomic, strong) PHViewModel *viewModel;

//当前页面事件的回调
@property (nonatomic, copy) PHViewBlock block;

@end




