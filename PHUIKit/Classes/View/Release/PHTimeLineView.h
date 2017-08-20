//
//  PHTimeLineView.h
//  App
//
//  Created by 項普華 on 2017/7/23.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <PHBaseLib/PHMacro.h>

@interface PHTimeLineView : UIView

/**
 传入数据 datas 部分可以为文字数组 也可以为图像数组
 */
+ (PHTimeLineView *(^)(NSArray *datas, UIView *superView, PHDirection direction, NSInteger currentSelectedIndex, PHValueBlock block))ph_create;
/**
 普通状态颜色
 */
- (PHTimeLineView *(^)(UIColor *normalColor))ph_normalColor;
/**
 高亮状态的颜色
 */
- (PHTimeLineView *(^)(UIColor *tintColor))ph_tintColor;
/**
 当前选中的 动画效果从上一个选中的到下一个选中
 */
- (PHTimeLineView *(^)(NSInteger currentIndex))ph_currentIndex;

@end
