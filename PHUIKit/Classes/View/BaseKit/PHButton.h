//
//  PHButton.h
//  App
//
//  Created by 項普華 on 2017/6/4.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <PHBaseLib/PHMacro.h>

@class PHButton;

typedef void(^PHButtonClick)(PHButton *sender);

typedef NS_ENUM(NSUInteger, PHButtonLayout) {
    PHButtonLayoutImageAtLeft = 1,//图片在左边
    PHButtonLayoutImageAtRight,//图片在右边
    PHButtonLayoutImageAtTop,//图片在上边
    PHButtonLayoutImageAtBottom,//图片在下边
};


@interface PHButton : UIButton

/**
 创建
 */
+ (PHButton *(^)(BOOL enable))ph_create;

/**
 设置背景色
 */
- (PHButton *(^)(UIColor *bgColor))ph_backgroundColor;
/**
 圆角率
 */
- (PHButton *(^)(NSInteger radius))ph_radius;

/**
 添加到View 中  并且添加了布局
 */
- (PHButton *(^)(id view, PHLayout layout))ph_addToView;


/**
 设置标题
 */
- (PHButton *(^)(NSString *title))ph_title;

/**
 设置图片 imageName 或者 图片路径  或者image 都可以
 */
- (PHButton *(^)(id image))ph_image;

/**
 设置字体颜色
 */
- (PHButton *(^)(UIColor *textColor))ph_textColor;

/**
 单击事件
 */
- (PHButton *(^)(PHButtonClick clickBlock))ph_clickAction;


/**
 布局
 */
- (PHButton *(^)(PHButtonLayout layout))ph_layout;



@end
