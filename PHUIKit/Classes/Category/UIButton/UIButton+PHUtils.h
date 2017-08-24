//
//  UIButton+PHUtils.h
//  Pods
//
//  Created by 項普華 on 2017/8/13.
//
//

#import <UIKit/UIKit.h>
#import "UIView+PHUtils.h"
#import <PHBaseLib/PHMacro.h>

typedef NS_ENUM(NSUInteger, PHButtonLayout) {
    PHButtonLayoutImageAtLeft = 1,//图片在左边
    PHButtonLayoutImageAtRight,//图片在右边
    PHButtonLayoutImageAtTop,//图片在上边
    PHButtonLayoutImageAtBottom,//图片在下边
};

@interface UIButton (PHUtils)
#pragma mark - uibutton
/**
 普通image
 */
- (UIButton *(^)(id img))ph_normarlImage;
/**
 普通title
 */
- (UIButton *(^)(NSString *title))ph_normalTitle;
/**
 普通Color
 */
- (UIButton *(^)(UIColor *color))ph_normalColor;
/**
 普通字号
 */
- (UIButton *(^)(CGFloat fontSize))ph_fontSize;
/**
 选中image
 */
- (UIButton *(^)(id img))ph_selectedImage;
/**
 选中title
 */
- (UIButton *(^)(NSString *title))ph_selectedTitle;
/**
 选中Color
 */
- (UIButton *(^)(UIColor *color))ph_selectedColor;
/**
 高亮image
 */
- (UIButton *(^)(id img, UIControlState state))ph_stateImage;
/**
 高亮title
 */
- (UIButton *(^)(NSString *title, UIControlState state))ph_stateTitle;
/**
 高亮Color
 */
- (UIButton *(^)(UIColor *color, UIControlState state))ph_stateColor;
/**
 设置按钮的状态
 */
- (UIButton *(^)(UIControlState state))ph_state;
/**
 布局
 */
- (UIButton *(^)(PHButtonLayout layout))ph_layout;
/**
 点击按钮的事件
 */
- (UIButton *(^)(PHButtonBlock clickBlock))ph_buttonClickBlock;




#pragma mark - 快速创建对象
/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局约束
 @param image 图片
 @param clickBlock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ph_createSuperView:(UIView *)superView
                          layout:(PHLayout)layout
                           image:(id)image
                     clickAction:(PHButtonBlock)clickBlock;

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param title 标题
 @param clickBLock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ph_createSuperView:(UIView *)superView
                          layout:(PHLayout)layout
                           title:(NSString *)title
                     clickAction:(PHButtonBlock)clickBLock;

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param image 图像
 @param title 标题
 @param buttonLayout button上图像与标题的布局
 @param clickBlock 点击事件的回调
 @return 当前对象
 */
+ (UIButton *)ph_createSuperView:(UIView *)superView
                          layout:(PHLayout)layout
                           image:(id)image
                           title:(NSString *)title
                    buttonLayout:(PHButtonLayout)buttonLayout
                     clickAction:(PHButtonBlock)clickBlock;




@end




