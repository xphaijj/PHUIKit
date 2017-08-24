//
//  UIImageView+PHUtils.m
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import "UIImageView+PHUtils.h"
#import "UIImage+PHUtils.h"
#import "UIView+PHUtils.h"
#import <PHBaseLib/PHTools.h>
#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation UIImageView (PHUtils)

/**
 设置image
 */
- (UIImageView *(^)(id))ph_image {
    return ^id(id image) {
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:image];
            }
            else if ([image isKindOfClass:[NSURL class]]) {
                [self setImageWithURL:(NSURL *)image];
            }
            else if ([image isKindOfClass:[NSString class]]) {
                
                if (PH_CheckURL(((NSString *)image))) {
                    [self setImageWithURL:[NSURL URLWithString:(NSString *)image]];
                }
                else {
                    [self setImage:[UIImage ph_imageNamed:(NSString *)image]];
                }
            }
        }
        return self;
    };
}
/**
 设置显示方式
 */
- (UIImageView *(^)(UIViewContentMode contentMode))ph_contentMode {
    return ^id(UIViewContentMode contentMode) {
        self.contentMode = contentMode;
        return self;
    };
}



#pragma mark - 快速创建对象

/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局约束
 @param image image
 @param contentMode contentMode
 @return 当前对象
 */
+ (UIImageView *)ph_createSuperView:(UIView *)superView
                             layout:(PHLayout)layout
                              image:(id)image
                        contentMode:(UIViewContentMode)contentMode {
    UIImageView *result = UIImageView
                            .ph_create(superView, layout)
                            .ph_convertToImageView()
                            .ph_image(image)
                            .ph_contentMode(contentMode);
    return result;
}


@end
