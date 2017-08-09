//
//  PHTableCell.h
//  App
//
//  Created by 項普華 on 2017/6/3.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PHModel.h"

#import <PHBaseLib/PHMacro.h>
#import "PHButton.h"
#import "PHLabel.h"

@protocol PHTableCellProtocol <NSObject>

@optional
- (void)indexPath:(NSIndexPath *)indexPath
             data:(id)response;

@end


@interface PHTableCell : UITableViewCell<PHTableCellProtocol>

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id data;

/**
 cell 添加一个Button
 */
- (PHTableCell *(^)(PHButton *btn, PHCellActionBlock clickActionBlock))addButton;

/**
 Cell左边的ImageView
 */
- (PHTableCell *(^)(UIImage *image, BOOL isCircle, PHCellActionBlock clickActionBlock))leftImageView;

/**
 Cell右边的ImageView
 */
- (PHTableCell *(^)(UIImage *image, BOOL isCircle, PHCellActionBlock clickActionBlock))rightImageView;

/**
 Cell左边的Title
 */
- (PHTableCell *(^)(NSString *title))leftTitle;

@end
