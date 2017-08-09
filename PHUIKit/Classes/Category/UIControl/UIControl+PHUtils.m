//
//  UIControl+PHUtils.m
//  App
//
//  Created by 項普華 on 2017/6/22.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIControl+PHUtils.h"

#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>

@implementation UIControl (PHUtils)

+ (void)load {
    PH_SwizzleSelector([UIControl class], @selector(sendAction:to:forEvent:), @selector(ph_sendAction:to:forEvent:));
    PH_SwizzleSelector([UIControl class], @selector(sendActionsForControlEvents:), @selector(ph_sendActionsForControlEvents:));
}

- (void)ph_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self ph_sendAction:action to:target forEvent:event];
    //PHLog(@"收到了事件 %@", PH_CurrentVC());
}

- (void)ph_sendActionsForControlEvents:(UIControlEvents)controlEvents {
    [self ph_sendActionsForControlEvents:controlEvents];
    //PHLog(@"收到了事件 %@", PH_CurrentVC());
}

@end
