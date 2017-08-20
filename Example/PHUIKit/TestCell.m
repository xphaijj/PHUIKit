//
//  TestCell.m
//  PHUIKit
//
//  Created by 項普華 on 2017/8/20.
//  Copyright © 2017年 xphaijj0305@126.com. All rights reserved.
//

#import "TestCell.h"
#import <Masonry/Masonry.h>
#import <PHUIKit/UILabel+PHUtils.h>
#import <PHUIKit/UIView+PHUtils.h>
#import <PHUIKit/UITableViewCell+PHUtils.h>
#import <PHUIKit/UIButton+PHUtils.h>

@interface TestCell()

@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *testLabel;

@end

@implementation TestCell

- (void)ph_configUI {
    self.ph_accessoryType(UITableViewCellAccessoryDisclosureIndicator);
    _testLabel = UILabel
    .ph_create(self, ^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
    })
    .ph_backgroundColor(HEXCOLOR(0xff5555))
    .ph_convertToLabel();
    
    _btn = UIButton.ph_create(self, ^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.height.equalTo(@44);
    })
    .ph_backgroundColor(HEXCOLOR(0xffff55))
    .ph_convertToButton()
    .ph_buttonClickBlock(^(UIButton *sender) {
        PHLog(@"button click %zd", sender.tag);
    })
    ;
}

- (UITableViewCellStyle)ph_cellStyle {
    return UITableViewCellStyleValue1;
}

- (void)ph_indexPath:(NSIndexPath *)indexPath bindData:(id)data {
    _btn.tag = indexPath.row;
    self.ph_title(data);
    self.ph_subTitle(@"ceshishuju ");
    self.ph_leftImage(@"test");
    self.testLabel.ph_text([NSString stringWithFormat:@"%@%@ woshiceshishuju %@%@", data, data, data, data]);
}

@end
