//
//  PHMapVC.h
//  App
//
//  Created by 項普華 on 2017/7/23.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHBaseVC.h"

#import <PHBaseLib/PHMacro.h>

typedef NS_ENUM(NSUInteger, PHRouteType) {
    PHRouteTypeFromCurrentToStart = 1,//从当前位置到起始位置
    PHRouteTypeFromCurrentToEnd,//从当前位置到终止位置
    PHRouteTypeFromStartToEnd//从起始位置到终止位置
};

//百度地图调用 里面自带导航
@interface PHMapVC : PHBaseVC
//起始位置 二选一
PH_AssignProperty(CLLocationCoordinate2D startCoordinate2D);
PH_StringProperty(startAddress);
//终止位置 二选一
PH_AssignProperty(CLLocationCoordinate2D endCoordinate2D);
PH_StringProperty(endAddress);


//中心位置
PH_AssignProperty(CLLocationCoordinate2D centerCoordinate2D);
//起始标题
PH_StringProperty(startTitle);
//终止标题
PH_StringProperty(endTitle);
//导航规划方式
PH_AssignProperty(PHRouteType type);

@end
