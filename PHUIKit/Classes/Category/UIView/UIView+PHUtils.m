//
//  UIView+PHUtils.m
//  App
//
//  Created by 項普華 on 2017/6/24.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIView+PHUtils.h"

@implementation UIView (PHUtils)

- (CGPoint)ph_selfcenter {
    return CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
}

@end
