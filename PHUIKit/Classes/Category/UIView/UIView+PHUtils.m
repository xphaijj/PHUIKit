//
//  UIView+PHUtils.m
//  App
//
//  Created by 項普華 on 2017/6/24.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIView+PHUtils.h"
#import <objc/message.h>
#import "UIView+GESAdditions.h"



@interface UIView (PHData)

/**
 当前view绑定的data
 */
@property (nonatomic, strong) id viewData;
/**
 view点击事件
 */
@property (nonatomic, copy) PHViewBlock viewClickBlock;

@end

@implementation UIView (PHData)

@dynamic viewData;
@dynamic viewClickBlock;

- (void)setViewData:(id)viewData {
    objc_setAssociatedObject(self, @selector(viewData), viewData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)viewData {
    return objc_getAssociatedObject(self, @selector(viewData));
}

- (void)setViewClickBlock:(PHViewBlock)viewClickBlock {
    objc_setAssociatedObject(self, @selector(viewClickBlock), viewClickBlock, OBJC_ASSOCIATION_COPY);
}

- (PHViewBlock)viewClickBlock {
    return objc_getAssociatedObject(self, @selector(viewClickBlock));
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.viewClickBlock) {
        self.viewClickBlock(self);
    }
}


@end




#pragma mark - utils
@implementation UIView (PHUtils)

/**
 视图的创建
 */
+ (UIView *(^)(UIView *superView, PHLayout layout))ph_create {
    return ^id(UIView *superView, PHLayout layout) {
        UIView *result = [[[self class] alloc] init];
        if (superView) {
            [superView addSubview:result];
            if (layout) {
                [result mas_makeConstraints:layout];
            } else {
                [result mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(superView);
                }];
            }
        }
        return result;
    };
}
/**
 视图的创建frame
 */
+ (UIView *(^)(UIView *superView, CGRect frame))ph_frame {
    return ^id(UIView *superView, CGRect frame) {
        UIView *result = [[[self class] alloc] initWithFrame:frame];
        if (superView) {
            [superView addSubview:result];
        }
        
        return result;
    };
}
/**
 设置视图上的数据显示
 */
- (UIView *(^)(id data))ph_data {
    return ^id(id data) {
        self.viewData = data;
        return self;
    };
}
/**
 设置背景颜色
 */
- (UIView *(^)(UIColor *bgColor))ph_backgroundColor {
    return ^id(UIColor *bgColor) {
        self.backgroundColor = bgColor;
        return self;
    };
}
/**
 设置圆角
 */
- (UIView *(^)(NSInteger radius))ph_radius {
    return ^id(NSInteger radius) {
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        return self;
    };
}
/**
 设置边框颜色
 */
- (UIView *(^)(UIColor *borderColor))ph_borderColor {
    return ^id(UIColor *borderColor) {
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}
/**
 设置边框宽度
 */
- (UIView *(^)(CGFloat borderWidth))ph_borderWidth  {
    return ^id(CGFloat borderWidth) {
        self.layer.borderWidth = borderWidth;
        return self;
    };
}
/**
 设置阴影颜色
 */
- (UIView *(^)(UIColor *shadowColor))ph_shadowColor {
    return ^id(UIColor *shadowColor) {
        self.layer.shadowColor = shadowColor.CGColor;
        return self;
    };
}
/**
 设置阴影的大小
 */
- (UIView *(^)(CGSize shadowOffset))ph_shadowSize {
    return ^id(CGSize shadowOffset) {
        self.layer.shadowOffset = shadowOffset;
        return self;
    };
}
/**
 设置阴影模糊度
 */
- (UIView *(^)(CGFloat blur))ph_blur {
    return ^id(CGFloat blur) {
        self.layer.shadowRadius = blur;
        return self;
    };
}
/**
 设置tag
 */
- (UIView *(^)(NSInteger tag))ph_tag {
    return ^id(NSInteger tag) {
        self.tag = tag;
        return self;
    };
}
/**
 点击事件
 */
- (UIView *(^)(PHViewBlock clickBlock))ph_clickBlock {
    return ^id(PHViewBlock clickBlock) {
        self.viewClickBlock = clickBlock;
        self.userInteractionEnabled = YES;
        self.ges_tap(self, @selector(tapAction:));
        return self;
    };
}

#pragma mark - Convert
/**
 类型转化
 */
- (UIButton *(^)())ph_convertToButton {
    return ^id() {
        if ([self isKindOfClass:[UIButton class]]) {
            return self;
        } else {
            PHLogError(@"button 类型转化错误");
        }
        return nil;
    };
}

/**
 类型转化
 */
- (UILabel *(^)())ph_convertToLabel {
    return ^id() {
        if ([self isKindOfClass:[UILabel class]]) {
            return self;
        } else {
            PHLogError(@"label 类型转化错误");
        }
        return nil;
    };
}

/**
 类型转化
 */
- (UIImageView *(^)())ph_convertToImageView {
    return ^id() {
        if ([self isKindOfClass:[UIImageView class]]) {
            return self;
        } else {
            PHLogError(@"imageView 类型转化出错");
        }
        return nil;
    };
}

/**
 类型转化
 */
- (UITableView *(^)())ph_convertToTableView {
    return ^id() {
        if ([self isKindOfClass:[UITableView class]]) {
            return self;
        } else {
            PHLogError(@"tableView 类型转化错误");
        }
        return nil;
    };
}


#pragma mark - method
/**
 获取当前视图的中心点
 
 @return 中心点
 */
- (CGPoint)ph_selfcenter {
    return CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
}

/**
 获取当前view绑定的data
 
 @return data
 */
- (id)data {
    return self.viewData;
}


@end
