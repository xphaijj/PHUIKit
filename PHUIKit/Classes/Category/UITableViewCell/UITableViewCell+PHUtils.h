//
//  UITableViewCell+PHUtils.h
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import <UIKit/UIKit.h>

@protocol PHTableViewCellProtocol <NSObject>
/**
 类型配置

 @return UITableViewCellStyle
 */
- (UITableViewCellStyle)ph_cellStyle;
/**
 UI配置
 */
- (void)ph_configUI;
/**
 数据绑定
 */
- (void)ph_indexPath:(NSIndexPath *)indexPath bindData:(id)data;

@end


@interface UITableViewCell (PHUtils)<PHTableViewCellProtocol>

/**
 当前行上绑定的数据
 */
@property (nonatomic, strong) id cellData;

/**
 绑定数据
 */
- (UITableViewCell *(^)(NSIndexPath *indexPath, id bindData))ph_cellBindData;
/**
 处理UI
 */
- (UITableViewCell *(^)())ph_cellConfigUI;
/**
 accessory type
 */
- (UITableViewCell *(^)(UITableViewCellAccessoryType accessoryType))ph_accessoryType;
/**
 左边image
 */
- (UITableViewCell *(^)(id leftImg))ph_leftImage;
/**
 左边标题
 */
- (UITableViewCell *(^)(NSString *title))ph_title;
/**
 详细标题
 */
- (UITableViewCell *(^)(NSString *subTitle))ph_subTitle;





@end
