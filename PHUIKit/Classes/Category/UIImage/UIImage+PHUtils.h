//
//  UIImage+PHUtils.h
//  App
//
//  Created by Alex on 2017/7/19.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (PHUtils)

/**
 读取Image

 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)ph_imageNamed:(NSString *)imageName;

@end
