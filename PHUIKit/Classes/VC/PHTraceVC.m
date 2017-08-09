//
//  PHTraceVC.m
//  App
//
//  Created by Alex on 2017/7/27.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHTraceVC.h"

#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>
#import <BaiduMapKit/BaiduMapAPI_Map/BMKMapView.h>

@interface PHTraceVC ()<BMKMapViewDelegate> {
    BMKMapView *_mapView;
}

@end

@implementation PHTraceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, PH_SCREEN_WIDTH, PH_SCREEN_WIDTH)];
    [self.view addSubview:_mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    //设置地图缩放级别
    [_mapView setZoomLevel:11];
}


- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    _mapView = nil;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
