//
//  PHTableViewCellModel.h
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import <PHBaseLib/PHModel.h>

@interface PHTableSectionModel : PHModel

/**
 数据源
 */
@property (nonatomic, strong) NSArray *sectionData;

/**
 section header height
 */
@property (nonatomic, assign) CGFloat sectionHeaderHeight;

/**
 section header title
 */
@property (nonatomic, strong) NSString *sectionHeaderTitle;

/**
 section header view
 */
@property (nonatomic, strong) UIView *sectionHeaderView;

/**
 section footer height
 */
@property (nonatomic, assign) CGFloat sectionFooterHeight;

/**
 section footer view
 */
@property (nonatomic, strong) UIView *sectionFooterView;

/**
 section footer title
 */
@property (nonatomic, strong) NSString *sectionFooterTitle;

/**
 row height
 */
@property (nonatomic, assign) CGFloat rowHeight;
/**
 默认使用 row data中的cell 如果找不到则使用此处的cellClass
 */
@property (nonatomic, strong) Class cellClass;

/**
 创建SectionData
 */
+ (PHTableSectionModel *(^)(NSArray *list))ph_sectionData;

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat headerHeight, UIView *header))ph_sectionHeaderView;

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat headerHeight, NSString *headerTitle))ph_sectionHeaderTitle;

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat footerHeight, UIView *footer))ph_sectionFooterView;

/**
 sectionHeader 高度
 */
- (PHTableSectionModel *(^)(CGFloat footerHeight, NSString *footerTitle))ph_sectionFooterTitle;

/**
 cell配置
 */
- (PHTableSectionModel *(^)(CGFloat rowHeight, Class cellClass))ph_cell;

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
                             footerView:(UIView *)footerView;

/**
 快速创建对象

 @param list 数组
 @param headerString 表头标题
 @param footerString 表尾标题
 @return 当前对象
 */
+ (PHTableSectionModel *)ph_sectionData:(NSArray *)list
                           headerString:(NSString *)headerString
                           footerString:(NSString *)footerString;



@end
