//
//  UIButton+PHUtils.m
//  Pods
//
//  Created by 項普華 on 2017/8/13.
//
//

#import "UIButton+PHUtils.h"
#import "UIImage+PHUtils.h"
#import <objc/message.h>
#import <PHBaseLib/PHTools.h>
#import <AFNetworking/UIButton+AFNetworking.h>
#import <ReactiveObjC/ReactiveObjC.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@interface UIButton (PHAction)


@end


@implementation UIButton (PHAction)


@end






@implementation UIButton (PHUtils)

/**
 普通image
 */
- (UIButton *(^)(id img))ph_normarlImage {
    return ^id(id image) {
        return self.ph_stateImage(image, UIControlStateNormal);
    };
}
/**
 普通title
 */
- (UIButton *(^)(NSString *title))ph_normalTitle {
    return ^id(NSString *title) {
        return self.ph_stateTitle(title, UIControlStateNormal);
    };
}
/**
 普通Color
 */
- (UIButton *(^)(UIColor *color))ph_normalColor {
    return ^id(UIColor *color) {
        return self.ph_stateColor(color, UIControlStateNormal);
    };
}
/**
 普通字号
 */
- (UIButton *(^)(CGFloat fontSize))ph_fontSize {
    return ^id(CGFloat fontSize) {
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
/**
 选中image
 */
- (UIButton *(^)(id img))ph_selectedImage {
    return ^id(id img) {
        return self.ph_stateImage(img, UIControlStateSelected);
    };
}
/**
 选中title
 */
- (UIButton *(^)(NSString *title))ph_selectedTitle {
    return ^id(NSString *title) {
        return self.ph_stateTitle(title, UIControlStateSelected);
    };
}
/**
 选中Color
 */
- (UIButton *(^)(UIColor *color))ph_selectedColor {
    return ^id(UIColor *color) {
        return self.ph_stateColor(color, UIControlStateSelected);
    };
}
/**
 高亮image
 */
- (UIButton *(^)(id img, UIControlState state))ph_stateImage {
    return ^id(id img, UIControlState state) {
        if ([self isKindOfClass:[UIButton class]]) {
            if ([img isKindOfClass:[UIImage class]]) {
                [self setImage:img forState:state];
            }
            else if ([img isKindOfClass:[NSURL class]]) {
                [self setImageForState:state withURL:img];
            }
            else if ([img isKindOfClass:[NSString class]]) {
                if (PH_CheckURL(img)) {
                    [self setImageForState:state withURL:[NSURL URLWithString:img]];
                }
                else {
                    [self setImage:[UIImage ph_imageNamed:img] forState:state];
                }
            }
            [self setContentMode:UIViewContentModeScaleAspectFit];
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        return self;
    };
}
/**
 高亮title
 */
- (UIButton *(^)(NSString *title, UIControlState state))ph_stateTitle {
    return ^id(NSString *title, UIControlState state) {
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitle:title forState:state];
        }
        return self;
    };
}
/**
 高亮Color
 */
- (UIButton *(^)(UIColor *color, UIControlState state))ph_stateColor {
    return ^id(UIColor *color, UIControlState state) {
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitleColor:color forState:state];
        }
        return self;
    };
}

/**
 设置按钮的状态
 */
- (UIButton *(^)(UIControlState state))ph_state {
    return ^id(UIControlState state) {
        switch (state) {
            case UIControlStateHighlighted: self.highlighted = YES; break;
            case UIControlStateDisabled: self.enabled = YES; break;
            case UIControlStateSelected: self.selected = YES; break;
            default:
                break;
        }
        return self;
    };
}

/**
 布局
 */
- (UIButton *(^)(PHButtonLayout layout))ph_layout {
    return ^id(PHButtonLayout layout) {
        [self layoutIfNeeded];
        switch (layout) {
            case PHButtonLayoutImageAtLeft: {
                self.titleEdgeInsets = UIEdgeInsetsZero;
                self.imageEdgeInsets = UIEdgeInsetsZero;
            }
                break;
            case PHButtonLayoutImageAtRight: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width-self.frame.size.width + self.titleLabel.intrinsicContentSize.width, 0.0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0,  0.0, 0.0, -self.titleLabel.frame.size.width-self.frame.size.width+self.imageView.frame.size.width);
            }
                break;
            case PHButtonLayoutImageAtTop: {
                self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -self.imageView.frame.size.width, -self.imageView.frame.size.height-20, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, 0.0, 0.0, -self.titleLabel.intrinsicContentSize.width);
            }
                break;
            case PHButtonLayoutImageAtBottom: {
                self.titleEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height, -self.imageView.frame.size.width, 0.0, 0.0);
                self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -self.imageView.frame.size.height-20, -self.titleLabel.intrinsicContentSize.width);
            }
                break;
        }
        return self;
    };
}


/**
 点击按钮的事件
 */
- (UIButton *(^)(PHButtonBlock clickBlock))ph_buttonClickBlock {
    return ^id(PHButtonBlock clickBlock) {
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (clickBlock) {
                clickBlock(x);
            }
        }];
        return self;
    };
}



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
                     clickAction:(PHButtonBlock)clickBlock {
    UIButton *result = UIButton
                        .ph_create(superView, layout)
                        .ph_convertToButton()
                        .ph_normarlImage(image)
                        .ph_clickBlock(clickBlock);
    return result;
}

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
                     clickAction:(PHButtonBlock)clickBLock {
    UIButton *result = UIButton
                        .ph_create(superView, layout)
                        .ph_convertToButton()
                        .ph_normalTitle(title)
                        .ph_normalColor(HEXCOLOR(0x515151))
                        .ph_clickBlock(clickBLock);
    return result;
}

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
                     clickAction:(PHButtonBlock)clickBlock {
    UIButton *result = UIButton
                        .ph_create(superView, layout)
                        .ph_convertToButton()
                        .ph_normalTitle(title)
                        .ph_normarlImage(image)
                        .ph_normalColor(HEXCOLOR(0x515151))
                        .ph_layout(buttonLayout)
                        .ph_clickBlock(clickBlock);
    
    return result;
}


@end
#pragma clang diagnostic pop



