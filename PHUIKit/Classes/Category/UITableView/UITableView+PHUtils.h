//
//  UITableView+PHUtils.h
//  App
//
//  Created by 項普華 on 2017/6/25.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PHBaseLib/PHMacro.h>
#import "UIView+PHUtils.h"
#import "PHTableSectionModel.h"

@interface UITableView (PHUtils)

/**
 列表类别
 */
+ (UITableView *(^)(UIView *superView, PHLayout layout, UITableViewStyle style))ph_create;
/**
 视图的创建frame
 */
+ (UITableView *(^)(UIView *superView, CGRect frame, UITableViewStyle style))ph_frame;
/**
 header高度
 */
- (UITableView *(^)(UIView *headerView))ph_tableHeader;
/**
 footer高度
 */
- (UITableView *(^)(UIView *footerView))ph_tableFooter;
/**
 列表数据
 */
- (UITableView *(^)(NSArray<PHTableSectionModel *> *list))ph_tableData;
/**
 cell配置
 */
- (UITableView *(^)(CGFloat rowHeight, Class cellClass))ph_cell;
/**
 单击Cell回调
 */
- (UITableView *(^)(PHCellActionBlock cellActionBlock))ph_cellClick;
/**
 刷新列表
 */
- (UITableView *(^)())ph_reloadData;




/**
 header高度
 */
- (UITableView *(^)(CGFloat headerHeight, UIView *headerView))ph_sectionHeader;
/**
 footer高度
 */
- (UITableView *(^)(CGFloat footerHeight, UIView *footerView))ph_sectionFooter;









@end
