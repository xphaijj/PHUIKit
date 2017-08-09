//
//  PHBaseVC.h
//  Example
//
//  Created by 項普華 on 2017/5/10.
//  Tel:(+86)13316987488  Mail:xiangpuhua@126.com
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>
#import <AFNetworking/AFNetworking.h>
#import "PHBaseVCProtocol.h"
#import "PHNetworkProtocol.h"
#import "PHLocationProtocol.h"
#import "PHLogProtocol.h"
#import <DCURLRouter/DCURLRouter.h>

@interface PHBaseVCModel : NSObject
//YES present 进去 NO push进去
PH_BoolProperty(present);
//标题
PH_StringProperty(title);
//目标对象控制器 当target 为vc时 进行页面的跳转  当target为view的时候 addsubview
PH_StrongProperty(id target);
//nib名称
PH_StringProperty(nib);
//storyboard名称 storyboard 的名称  使用storyboard的时候 配合nib一起使用  否则nib名称默认与storyboard一致
PH_StringProperty(storyboard);
//backBlock
PH_CopyProperty(PHVCBackBlock backBlock);
//扩展参数 主要用来传值之类的
PH_StrongProperty(NSDictionary *extras);

@end




@interface PHBaseVC : UIViewController<PHBaseVCProtocol, PHNetworkProtocol, PHLocationProtocol, PHLogProtocol>
/**
 上个页面传下的参数
 */
@property (nonatomic, strong) id lastPageData;

/**
 页面返回时的回调
 */
@property (nonatomic, copy) PHVCBackBlock backBlock;

/**
 视图创建 params 参数  
 * @"push":@(YES)    push 进去 否则present进去
 * @"title":@"页面标题"  title 内容标题
 * @"target":self     target 当前页面
 * @"nib":@"PHBaseVC"  nib的名称
 * @"storyboard":@"Main"  storyboard 的名称  使用storyboard的时候 配合nib一起使用  否则nib名称默认与storyboard一致
 */
+ (PHBaseVC *(^)(PHBaseVCModel *params))ph_create;






@end
