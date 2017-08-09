//
//  PHKeyboardShowView.h
//  App
//
//  Created by Alex on 2017/7/22.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PHBaseLib/PHMacro.h>

@protocol PHKeyboardDelegate <NSObject>

- (id)ph_keyboardValue;

@end

@interface PHKeyboardShowView : UIView

PH_ShareInstanceHeader(PHKeyboardShowView);

/**
 键盘点击确定按钮时 键盘上的值
 */
@property (nonatomic, strong) id value;
/**
 代理
 */
@property (nonatomic, weak) id<PHKeyboardDelegate> delegate;
/**
 键盘视图
 */
@property (nonatomic, strong) UIView *keyboardView;
/**
 键盘高度 如果设置了高度 占比失效
 */
@property (nonatomic, assign) CGFloat keyboardHeight;
/**
 占比
 */
@property (nonatomic, assign) CGFloat aspect;
/**
 颜色
 */
@property (nonatomic, strong) UIColor *tintColor;
/**
 键盘弹出的方向
 */
@property (nonatomic, assign) PHDirection keyboardDirection;

/**
 是否显示上方的tools bar 取消 确定按钮
 */
@property (nonatomic, assign) BOOL showToolBar;
/**
 取消标题
 */
@property (nonatomic, strong) NSString *cancelTitle;
/**
 确定标题
 */
@property (nonatomic, strong) NSString *sureTitle;
/**
 取消图片
 */
@property (nonatomic, strong) UIImage *cancelImage;
/**
 确定图片
 */
@property (nonatomic, strong) UIImage *sureImage;
/**
 键盘标题
 */
@property (nonatomic, strong) NSString *barTitle;

/**
 回调
 */
@property (copy, nonatomic) PHValueBlock callback;
/**
 显示
 */
+ (void)show:(PHValueBlock)callback;
/**
 隐藏
 */
+ (void)hide;

@end
