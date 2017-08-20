//
//  UIImage+PHUtils.m
//  App
//
//  Created by Alex on 2017/7/19.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIImage+PHUtils.h"

#import <PHBaseLib/PHMacro.h>

@implementation UIImage (PHUtils)

/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)ph_imageNamed:(NSString *)imageName {
    UIImage *result = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:@"png"]];
    if (result == nil) {
        NSArray *array = [imageName componentsSeparatedByString:@"/"];
        NSString *bundleName = nil;
        NSString *type = @"png";
        NSString *name = imageName;
        NSMutableString *dir = nil;
        for (NSString *path in array) {
            if ([path hasPrefix:@".bundle"]) {
                bundleName = path;
            } else if ([path rangeOfString:@"."].location != NSNotFound) {
                NSArray *nameList = [path componentsSeparatedByString:@"."];
                name = nameList[0];
                if ([name hasSuffix:@"@2x"]) {
                    name = [name stringByReplacingOccurrencesOfString:@"@2x" withString:@""];
                }
                if ([name hasSuffix:@"@3x"]) {
                    name = [name stringByReplacingOccurrencesOfString:@"@3x" withString:@""];
                }
                type = nameList[1];
            } else {
                if (dir == nil) {
                    dir = [[NSMutableString alloc] init];
                }
                [dir appendFormat:@"%@/", path];
            }
        }
        
        result = PH_ImageRes(name, type, bundleName, dir);
    }
    
    return result;
}


@end
