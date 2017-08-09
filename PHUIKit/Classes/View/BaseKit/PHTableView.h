//
//  PHTableView.h
//  App
//
//  Created by 項普華 on 2017/6/4.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHTableCell.h"

#import <PHBaseLib/PHMacro.h>
#import <MJRefresh/MJRefresh.h>

#define PHTableViewReturnType PHTableView * (^)(id attribute)

@interface PHTableView : UITableView<UITableViewDelegate, UITableViewDataSource>


/**
 创建
 */
+ (PHTableView *(^)(UITableViewStyle style))ph_create;
#pragma mark -- 各种高度
/**
 设置列表高度
 */
- (PHTableView * (^)(CGFloat rowHeight))ph_cellHeight;

/**
 设置表头高度
 */
- (PHTableView * (^)(CGFloat headerHeight))ph_headerHeight;

/**
 设置表尾高度
 */
- (PHTableView * (^)(CGFloat footerHeight))ph_footerHeight;


#pragma mark -- 显示相关
/**
 设置列表数据源
 */
- (PHTableView * (^)(NSArray *list))ph_cellList;

/**
 设置列表Cell的Class
 */
- (PHTableView * (^)(Class cellClass))ph_cellClass;

/**
 表头显示搜索框
 */
- (PHTableView * (^)(PHSearchBlock searchBlock))ph_searchBlock;

/**
 添加到View 中  并且添加了布局
 */
- (PHTableView *(^)(id view, PHLayout layout))ph_addToView;

/**
 所有操作的最后一步都要进行 reload 才能显示数据
 */
- (PHTableView * (^)(void))ph_reload;


#pragma mark -- 操作相关
/**
 上拉刷新
 */
- (PHTableView * (^)(MJRefreshComponentRefreshingBlock pullUpBlock))ph_pullUp;

/**
 下拉加载更多
 */
- (PHTableView * (^)(MJRefreshComponentRefreshingBlock dropDownBlock))ph_dropDown;

/**
 设置列表的cell单击回调
 */
- (PHTableView * (^)(PHCellBlock cellBlock))ph_cellBlock;




/**
 列表加载数据

 @param list 数据源
 @param cellClass 列表Cell的class 属性
 @param block 列表回调
 @return 当前列表
 */
- (PHTableView *)ph_loadTableWithList:(NSArray *)list
                            cellClass:(Class)cellClass
                            cellBlock:(PHCellBlock)block;




@end
