//
//  UITableView+PHUtils.m
//  App
//
//  Created by 項普華 on 2017/6/25.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UITableView+PHUtils.h"
#import <objc/message.h>
#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "UITableViewCell+PHUtils.h"
#import "PHTableRowModel.h"

@interface UITableView (PHData)

/**
 传入的数据
 */
@property (nonatomic, strong) NSArray<PHTableSectionModel *> *tableData;
/**
 cell class
 */
@property (nonatomic, strong) Class cellClass;
/**
 cell 点击回调
 */
@property (nonatomic, copy) PHCellBlock cellBlock;

@end

@implementation UITableView (PHData)

@dynamic tableData;

- (void)setTableData:(NSArray<PHTableSectionModel *> *)tableData {
    if (tableData && [tableData isKindOfClass:[NSArray class]]) {
        objc_setAssociatedObject(self, @selector(tableData), tableData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSArray<PHTableSectionModel *> *)tableData {
    return objc_getAssociatedObject(self, @selector(tableData));
}

- (void)setCellClass:(Class)cellClass {
    objc_setAssociatedObject(self, @selector(cellClass), cellClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)cellClass {
    return objc_getAssociatedObject(self, @selector(cellClass));
}

- (void)setCellBlock:(PHCellBlock)cellBlock {
    objc_setAssociatedObject(self, @selector(cellBlock), cellBlock, OBJC_ASSOCIATION_COPY);
}

- (PHCellBlock)cellBlock {
    return objc_getAssociatedObject(self, @selector(cellBlock));
}

@end


#pragma mark - UITableViewDataSource
@interface UITableView (PHDataSource)<UITableViewDelegate, UITableViewDataSource>

/**
 设置代理
 */
- (void)ph_delegate;


@end

@implementation UITableView (PHDataSource)

/**
 设置代理
 */
- (void)ph_delegate {
    self.delegate = self;
    self.dataSource = self;
}

#pragma mark - header footer
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    PHTableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[PHTableSectionModel class]]) {
        if (data.sectionHeaderHeight != 0) {
            return data.sectionHeaderHeight;
        } else if (data.sectionHeaderView) {
            return 44.;
        } else if (data.sectionHeaderTitle) {
            return 36.;
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    PHTableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[PHTableSectionModel class]]) {
        if (data.sectionFooterHeight != 0) {
            return data.sectionFooterHeight;
        } else if (data.sectionFooterView) {
            return 44.;
        } else if (data.sectionFooterTitle) {
            return 36.;
        }
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    PHTableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[PHTableSectionModel class]]) {
        return data.sectionHeaderView?:nil;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    PHTableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[PHTableSectionModel class]]) {
        return data.sectionFooterView?:nil;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    PHTableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[PHTableSectionModel class]]) {
        return PH_CheckString(data.sectionHeaderTitle)?data.sectionHeaderTitle:nil;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    PHTableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[PHTableSectionModel class]]) {
        return PH_CheckString(data.sectionFooterTitle)?data.sectionFooterTitle:nil;
    }
    return nil;
}

#pragma mark - UITableViewDelegate UITableVIewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    PHTableSectionModel *sectionData = self.tableData[section];
    return sectionData.sectionData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PHTableSectionModel *sectionData = self.tableData[indexPath.section];
    PHTableRowModel *data = sectionData.sectionData[indexPath.row];
    CGFloat height = 44;
    if ([data isKindOfClass:[PHTableRowModel class]]) {
        PHTableRowModel *model = data;
        height = model.rowHeight;
    } else {
        height = sectionData.rowHeight;
    }
    if (height == 0) {
        height = self.rowHeight;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PHTableSectionModel *sectionData = self.tableData[indexPath.section];
    PHTableRowModel *data = sectionData.sectionData[indexPath.row];
    Class cellClass;
    if ([data isKindOfClass:[PHTableRowModel class]] && data.cellClass) {
         cellClass = data.cellClass;
    } else if (sectionData.cellClass){
        cellClass = sectionData.cellClass;
    }
    cellClass = cellClass?:self.cellClass;
    if (!cellClass) {
        cellClass = [UITableViewCell class];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    if (cell == nil) {
        [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }

    cell.ph_cellBindData(indexPath, data);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellBlock) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.cellBlock(cell, indexPath, cell.cellData);
    }
}


@end










@implementation UITableView (PHUtils)

/**
 列表类别
 */
+ (UITableView *(^)(UIView *superView, PHLayout layout, UITableViewStyle style))ph_create {
    return ^id(UIView *superView, PHLayout layout, UITableViewStyle style) {
        UITableView *result = [[[self class] alloc] initWithFrame:CGRectZero style:style];
        result.rowHeight = 44.;
        [result ph_delegate];
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
+ (UITableView *(^)(UIView *superView, CGRect frame, UITableViewStyle style))ph_frame {
    return ^id(UIView *superView, CGRect frame, UITableViewStyle style) {
        UITableView *result = [[[self class] alloc] initWithFrame:frame style:style];
        [result ph_delegate];
        if (superView) {
            [superView addSubview:result];
        }
        return result;
    };
}

/**
 header高度
 */
- (UITableView *(^)(UIView *headerView))ph_tableHeader {
    return ^id(UIView *headerView) {
        self.tableHeaderView = headerView;
        return self;
    };
}
/**
 footer高度
 */
- (UITableView *(^)(UIView *footerView))ph_tableFooter {
    return ^id(UIView *footerView) {
        self.tableFooterView = footerView;
        return self;
    };
}
/**
 列表数据
 */
- (UITableView *(^)(NSArray<PHTableSectionModel *> *list))ph_tableData {
    return ^id(NSArray<PHTableSectionModel *> *list) {
        self.tableData = list;
        [self reloadData];
        return self;
    };
}
/**
 cell配置
 */
- (UITableView *(^)(CGFloat rowHeight, Class cellClass))ph_cell {
    return ^id(CGFloat rowHeight, Class cellClass) {
        self.rowHeight = rowHeight;
        self.cellClass = cellClass;
        return self;
    };
}

/**
 单击Cell回调
 */
- (UITableView *(^)(PHCellActionBlock cellActionBlock))ph_cellClick {
    return ^id(PHCellActionBlock cellActionBlock) {
        self.cellBlock = cellActionBlock;
        return self;
    };
}

/**
 刷新列表
 */
- (UITableView *(^)())ph_reloadData {
    return ^id() {
        [self reloadData];
        return self;
    };
}





/**
 header高度
 */
- (UITableView *(^)(CGFloat headerHeight, UIView *headerView))ph_sectionHeader {
    return ^id(CGFloat headerHeight, UIView *headerView) {
        return self;
    };
}
/**
 footer高度
 */
- (UITableView *(^)(CGFloat footerHeight, UIView *footerView))ph_sectionFooter {
    return ^id(CGFloat footerHeight, UIView *footerView) {
        return self;
    };
}


@end













