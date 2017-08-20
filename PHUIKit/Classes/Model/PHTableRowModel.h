//
//  PHTableRowModel.h
//  Pods
//
//  Created by 項普華 on 2017/8/20.
//
//

#import <PHBaseLib/PHModel.h>

@interface PHTableRowModel : PHModel

/**
 行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 cell class
 */
@property (nonatomic, strong) Class cellClass;

/**
 data
 */
@property (nonatomic, strong) id data;

/**
 Cell 数据
 */
+ (PHTableRowModel *(^)(CGFloat rowHeight, Class cellClass, id data))ph_create;

@end
