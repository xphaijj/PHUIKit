//
//  PHTableViewCellModel.m
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import "PHTableSectionModel.h"

@implementation PHTableSectionModel

/**
 创建SectionData
 */
+ (PHTableSectionModel *(^)(NSArray *list))ph_sectionData {
    return ^id(NSArray *list) {
        PHTableSectionModel *result = [[PHTableSectionModel alloc] init];
        result.sectionData = list;
        return result;
    };
}

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat headerHeight, UIView *header))ph_sectionHeaderView {
    return ^id(CGFloat headerHeight, UIView *header) {
        self.sectionHeaderHeight = headerHeight;
        self.sectionHeaderView = header;
        self.sectionHeaderTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat headerHeight, NSString *headerTitle))ph_sectionHeaderTitle {
    return ^id(CGFloat headerHeight, NSString *headerTitle) {
        self.sectionHeaderHeight = headerHeight;
        self.sectionHeaderTitle = headerTitle;
        self.sectionHeaderView = nil;
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat footerHeight, UIView *footer))ph_sectionFooterView {
    return ^id(CGFloat footerHeight, UIView *footer) {
        self.sectionFooterHeight = footerHeight;
        self.sectionFooterView = footer;
        self.sectionFooterTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat footerHeight, NSString *footerTitle))ph_sectionFooterTitle {
    return ^id(CGFloat footerHeight, NSString *footerTitle) {
        self.sectionFooterHeight = footerHeight;
        self.sectionFooterTitle = footerTitle;
        self.sectionFooterView = nil;
        return self;
    };
}

/**
 cell配置
 */
- (PHTableSectionModel *(^)(CGFloat rowHeight, Class cellClass))ph_cell {
    return ^id(CGFloat rowHeight, Class cellClass) {
        self.rowHeight = rowHeight;
        self.cellClass = cellClass;
        return self;
    };
}

#pragma mark - 快速创建对象
/**
 快速创建表头
 
 @param list 数组
 @param headerHeight 高度
 @param headerView view
 @param footerHeight footerHeight
 @param footerView footerView
 @return 当前对象
 */
+ (PHTableSectionModel *)ph_sectionData:(NSArray *)list
                           headerHeight:(CGFloat)headerHeight
                             headerView:(UIView *)headerView
                           footerHeight:(CGFloat)footerHeight
                             footerView:(UIView *)footerView {
    PHTableSectionModel *result = PHTableSectionModel
                                    .ph_sectionData(list)
                                    .ph_sectionHeaderView(headerHeight, headerView)
                                    .ph_sectionFooterView(footerHeight, footerView);
    
    return result;
}

/**
 快速创建对象
 
 @param list 数组
 @param headerString 表头标题
 @param footerString 表尾标题
 @return 当前对象
 */
+ (PHTableSectionModel *)ph_sectionData:(NSArray *)list
                           headerString:(NSString *)headerString
                           footerString:(NSString *)footerString {
    PHTableSectionModel *result = PHTableSectionModel
                                    .ph_sectionData(list)
                                    .ph_sectionHeaderTitle(36., headerString)
                                    .ph_sectionFooterTitle(36., footerString);
    return result;
}


@end
