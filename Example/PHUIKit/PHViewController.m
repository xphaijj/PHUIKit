//
//  PHViewController.m
//  PHUIKit
//
//  Created by xphaijj0305@126.com on 07/09/2017.
//  Copyright (c) 2017 xphaijj0305@126.com. All rights reserved.
//

#import "PHViewController.h"
#import <PHUIKit/UIView+PHUtils.h>
#import <PHUIKit/UIButton+PHUtils.h>
#import <PHUIKit/UILabel+PHUtils.h>
#import <PHUIKit/UIImage+PHUtils.h>
#import <PHUIKit/UIImageView+PHUtils.h>
#import <PHUIKit/UITableView+PHUtils.h>
#import <PHUIKit/UITextField+PHUtils.h>
#import "TestCell.h"

@interface PHViewController ()

@end

@implementation PHViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITextField.ph_create(self.view, ^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }).ph_convertToTextField().ph_placeholder(@"place").ph_textDidChange(^(NSString *value) {
        PHLog(@"--- %@", value);
    });
    
//    PHTableSectionModel *model = PHTableSectionModel.ph_sectionData(@[@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3",@"1", @"2", @"3"]);
//    
//    UITableView
//    .ph_create(self.view, ^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
//    }, UITableViewStylePlain)
//    .ph_tableHeader(
//                    UIView
//                    .ph_frame(nil,CGRectMake(0, 0, PH_SCREEN_WIDTH, 200))
//                    .ph_backgroundColor(HEXCOLOR(0xff5555)))
//    .ph_tableFooter(
//                    UIView
//                    .ph_frame(nil,CGRectMake(0, 0, PH_SCREEN_WIDTH, 100))
//                    .ph_backgroundColor(HEXCOLOR(0xf5f555)))
//    .ph_cell(44, [TestCell class])
//    .ph_tableData(@[model])
//    .ph_cellClick(^(UITableViewCell *cell, NSIndexPath *indexPath, id cellData){
//        PHLog(@"click %@", cellData);
//    })
//    .ph_reloadData();;
//    .ph_radius(50)
//    .ph_backgroundColor(HEXCOLOR(0xffff55));
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
