//
//  PHTableRowModel.m
//  Pods
//
//  Created by 項普華 on 2017/8/20.
//
//

#import "PHTableRowModel.h"

@implementation PHTableRowModel

/**
 Cell 数据
 */
+ (PHTableRowModel *(^)(CGFloat rowHeight, Class cellClass, id data))ph_create {
    return ^id(CGFloat rowHeight, Class cellClass, id data) {
        PHTableRowModel *result = [[PHTableRowModel alloc] init];
        result.rowHeight = rowHeight;
        result.cellClass = cellClass;
        result.data = data;
        return result;
    };
}


@end
