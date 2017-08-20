//
//  UITableViewCell+PHUtils.m
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import "UITableViewCell+PHUtils.h"
#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>
#import "UIImage+PHUtils.h"
#import "UIImageView+PHUtils.h"
#import "UILabel+PHUtils.h"
#import <objc/message.h>

@implementation UITableViewCell (PHUtils)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        PH_SwizzleSelector([UITableViewCell class], @selector(initWithStyle:reuseIdentifier:), @selector(initWithStyle:ph_reuseIdentifier:));
    });
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style ph_reuseIdentifier:(NSString *)reuseIdentifier {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    if ([self respondsToSelector:@selector(ph_cellStyle)]) {
        style = (UITableViewCellStyle)[self performSelector:@selector(ph_cellStyle) withObject:nil];
    }
#pragma clang diagnostic pop
    self = [self initWithStyle:style ph_reuseIdentifier:reuseIdentifier];
    self.ph_cellConfigUI();
    return self;
}


- (void)setCellData:(id)cellData {
    objc_setAssociatedObject(self, @selector(cellData), cellData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cellData {
    return objc_getAssociatedObject(self, @selector(cellData));
}


/**
 绑定数据
 */
- (UITableViewCell *(^)(NSIndexPath *indexPath, id bindData))ph_cellBindData {
    return ^id(NSIndexPath *indexPath, id bindData) {
        self.cellData = bindData;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(ph_indexPath:bindData:)]) {
            [self performSelector:@selector(ph_indexPath:bindData:) withObject:indexPath withObject:bindData];
        }
#pragma clang diagnostic pop
        return self;
    };
}
/**
 处理UI
 */
- (UITableViewCell *(^)())ph_cellConfigUI {
    return ^id() {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(ph_configUI)]) {
            [self performSelector:@selector(ph_configUI) withObject:nil];
        }
#pragma clang diagnostic pop
        return self;
    };
}

/**
 accessory type
 */
- (UITableViewCell *(^)(UITableViewCellAccessoryType accessoryType))ph_accessoryType {
    return ^id(UITableViewCellAccessoryType accessoryType) {
        self.accessoryType = accessoryType;
        return self;
    };
}
/**
 左边image
 */
- (UITableViewCell *(^)(id leftImg))ph_leftImage {
    return ^id(id leftImg) {
        self.imageView.ph_image(leftImg);
        return self;
    };
}
/**
 左边标题
 */
- (UITableViewCell *(^)(NSString *title))ph_title {
    return ^id(NSString *title) {
        self.textLabel.ph_text(title);
        return self;
    };
}
/**
 详细标题
 */
- (UITableViewCell *(^)(NSString *subTitle))ph_subTitle {
    return ^id(NSString *subTitle) {
        self.detailTextLabel.ph_text(subTitle);
        return self;
    };
}





@end
