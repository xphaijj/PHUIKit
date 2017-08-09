//
//  PHTableCell.m
//  App
//
//  Created by 項普華 on 2017/6/3.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHTableCell.h"
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface PHTableCell () {
}
@end

@implementation PHTableCell

- (void)indexPath:(NSIndexPath *)indexPath
             data:(id)response {
    self.indexPath = indexPath;
    self.data = response;
}

/**
 cell 使用一个button来填充
 */
- (PHTableCell *(^)(PHButton *btn, PHCellActionBlock clickActionBlock))addButton {
    return ^id(UIButton *btn, PHCellActionBlock clickActionBlock) {
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (clickActionBlock) {
                clickActionBlock(self.indexPath, x);
            }
        }];
        [self addSubview:btn];
        return self;
    };
}

/**
 Cell左边的ImageView
 */
- (PHTableCell *(^)(UIImage *image, BOOL isCircle, PHCellActionBlock clickActionBlock))leftImageView {
    return ^id(UIImage *image, BOOL isCircle, PHCellActionBlock clickBlock) {
        PHButton.ph_create((clickBlock != nil)).ph_image(image).ph_radius(18).ph_clickAction(^(PHButton *sender) {
            if (clickBlock) {
                clickBlock(self.indexPath, sender);
            }
        }).ph_addToView(self, ^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(12);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.width.equalTo(@36);
            make.height.equalTo(@36);
        });
        
        return self;
    };
}

/**
 Cell右边的ImageView
 */
- (PHTableCell *(^)(UIImage *image, BOOL isCircle, PHCellActionBlock clickActionBlock))rightImageView {
    return ^id(UIImage *image, BOOL isCircle, PHCellActionBlock clickBlock) {
        PHButton.ph_create((clickBlock != nil)).ph_image(image).ph_radius(18).ph_clickAction(^(PHButton *sender) {
            if (clickBlock) {
                clickBlock(self.indexPath, sender);
            }
        }).ph_addToView(self, ^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-12);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
            make.width.equalTo(@36);
            make.height.equalTo(@36);
        });
        return self;
    };
}

/**
 Cell左边的Title
 */
- (PHTableCell *(^)(NSString *title))leftTitle {
    return ^id(NSString *title) {
        PHLabel.ph_create().ph_text(title).ph_addToView(self, ^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(12);
            make.centerY.equalTo(self.mas_centerY).with.offset(0);
        });
        return self;
    };
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
