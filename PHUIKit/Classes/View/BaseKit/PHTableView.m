//
//  PHTableView.m
//  App
//
//  Created by 項普華 on 2017/6/4.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHTableView.h"
#import <MJRefresh/MJRefresh.h>

@interface PHTableView ()<UISearchBarDelegate> {
}
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, strong) Class cellName;
@property (nonatomic, strong) UISearchBar *headerSearchBar;
@property (nonatomic, copy) PHCellBlock block;
@property (nonatomic, copy) PHSearchBlock searchActionBlock;


@end

@implementation PHTableView

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

/**
 创建
 */
+ (PHTableView *(^)(UITableViewStyle style))ph_create {
    return ^id(UITableViewStyle style) {
        PHTableView *table = [[PHTableView alloc] initWithFrame:CGRectZero style:style];
        return table;
    };
}

#pragma mark -- 各种高度
/**
 设置列表高度
 */
- (PHTableView * (^)(CGFloat rowHeight))ph_cellHeight {
    return ^id(CGFloat attribute) {
        self.rowHeight = attribute;
        return self;
    };
}

/**
 设置表头高度
 */
- (PHTableView * (^)(CGFloat headerHeight))ph_headerHeight {
    return ^id(CGFloat attribute) {
        self.sectionHeaderHeight = attribute;
        return self;
    };
}

/**
 设置表尾高度
 */
- (PHTableView * (^)(CGFloat footerHeight))ph_footerHeight {
    return ^id(CGFloat attribute) {
        self.sectionFooterHeight = attribute;
        return self;
    };
}

#pragma mark -- 显示相关
/**
 设置列表数据源
 */
- (PHTableView * (^)(NSArray *list))ph_cellList {
    return ^id(NSArray *attribute) {
        self.list = attribute;
        return self;
    };
}

/**
 设置列表Cell的Class
 */
- (PHTableView * (^)(Class cellClass))ph_cellClass {
    return ^id(Class cellClass) {
        self.cellName = cellClass;
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        return self;
    };
}

/**
 添加到View 中  并且添加了布局
 */
- (PHTableView *(^)(id view, PHLayout layout))ph_addToView {
    return ^id(id view, PHLayout layout) {
        if ([view respondsToSelector:@selector(addSubview:)]) {
            [view addSubview:self];
            [self mas_makeConstraints:layout];
        }
        return self;
    };
}

/**
 刷新列表数据
 */
- (PHTableView * (^)(void))ph_reload {
    return ^id(void) {
        self.dataSource = self;
        self.delegate = self;
        if (!self.tableHeaderView) {
            self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.sectionHeaderHeight)];
        }
        if (!self.tableFooterView) {
            self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.sectionFooterHeight)];
        }
        [self reloadData];
        return self;
    };
}

#pragma mark -- 其他视图
/**
 表头显示搜索框
 */
- (PHTableView * (^)(PHSearchBlock searchBlock))ph_searchBlock {
    return ^id(PHSearchBlock attribute) {
        self.searchActionBlock = attribute;
        self.headerSearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
        self.headerSearchBar.returnKeyType = UIReturnKeySearch;
        self.headerSearchBar.placeholder = @"请输入搜索内容";
        self.headerSearchBar.delegate = self;
        self.tableHeaderView = self.headerSearchBar;
        return self;
    };
}

#pragma mark -- 操作相关
/**
 上拉刷新
 */
- (PHTableView * (^)(MJRefreshComponentRefreshingBlock pullUpBlock))ph_pullUp {
    return ^id(MJRefreshComponentRefreshingBlock pullUpBlock) {
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:pullUpBlock];
        return self;
    };
}

/**
 下拉加载更多
 */
- (PHTableView * (^)(MJRefreshComponentRefreshingBlock dropDownBlock))ph_dropDown {
    return ^id(MJRefreshComponentRefreshingBlock dropDownBlock) {
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:dropDownBlock];
        return self;
    };
}

/**
 设置列表的cell单击回调
 */
- (PHTableView * (^)(PHCellBlock cellBlock))ph_cellBlock {
    return ^id(PHCellBlock cellBlock) {
        self.block = cellBlock;
        return self;
    };
}

#pragma mark -- search bar delegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    if (self.searchActionBlock) {
        self.searchActionBlock(searchBar);
    }
}



#pragma mark -- method

- (PHTableView *)ph_loadTableWithList:(NSArray *)list
                            cellClass:(Class)cellClass
                            cellBlock:(PHCellBlock)block {
    self.ph_cellList(list).ph_cellClass(cellClass).ph_cellBlock(block).ph_reload();
    
    return self;
}

#pragma mark -- TableView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.headerSearchBar) {
        [self.headerSearchBar resignFirstResponder];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id info = self.list[section];
    return [info isKindOfClass:[NSArray class]]?((NSArray *)info).count:1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PHTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.cellName)];
    id info = self.list[indexPath.section];
    if ([info isKindOfClass:[NSArray class]]) {
        info = info[indexPath.row];
    }
    [cell indexPath:indexPath data:info];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.block) {
        id info = self.list[indexPath.section];
        if ([info isKindOfClass:[NSArray class]]) {
            info = info[indexPath.row];
        }
        self.block(indexPath, info);
    }
}

@end
