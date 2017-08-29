//
//  PHMapVC.m
//  App
//
//  Created by 項普華 on 2017/7/23.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHMapVC.h"
#import <PHModularLib/PHLocationHelper.h>
#import <RMUniversalAlert.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Map/BMKPointAnnotation.h>
#import <BaiduMapAPI_Map/BMKPinAnnotationView.h>
#import <BaiduMapAPI_Search/BMKRouteSearch.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>


BOOL Coordinate2DIsValid(CLLocationCoordinate2D coor) {
    if (CLLocationCoordinate2DIsValid(coor) && coor.latitude != 0 && coor.longitude != 0) {
        return YES;
    }
    return NO;
}

BOOL Coordinate2DisEqual(CLLocationCoordinate2D first, CLLocationCoordinate2D second) {
    if (Coordinate2DIsValid(first) && Coordinate2DIsValid(second)) {
        if (first.latitude-second.latitude<=0.01 && first.longitude-second.longitude<=0.01) {
            return YES;
        }
        return NO;
    }
    return YES;//都是无效的
}


@interface PHMapAnnination : BMKAnnotationView
@property (nonatomic, strong) UIImageView *thumbImageView;
@end

@implementation PHMapAnnination
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setBounds:CGRectMake(0.f, 0.f, 32.f, 32.f)];
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        _thumbImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _thumbImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_thumbImageView];
    }
    return self;
}
@end


@interface PHMapVC ()<BMKMapViewDelegate, BMKLocationServiceDelegate> {
}

@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) dispatch_queue_t dispatchQueue;
@property (nonatomic, strong) dispatch_group_t dispatchGroup;
@property (nonatomic, strong) NSArray *startPlacemarks;
@property (nonatomic, strong) NSArray *endPlacemarks;
@property (nonatomic, strong) BMKPointAnnotation *startAnnotation;
@property (nonatomic, strong) BMKPointAnnotation *endAnnotation;

@end

@implementation PHMapVC

- (BMKPointAnnotation *)startAnnotation {
    if (!_startAnnotation) {
        _startAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _startAnnotation;
}

- (BMKPointAnnotation *)endAnnotation {
    if (!_endAnnotation) {
        _endAnnotation = [[BMKPointAnnotation alloc] init];
    }
    return _endAnnotation;
}

- (void)setCenterCoordinate2D:(CLLocationCoordinate2D)centerCoordinate2D {
    _mapView.centerCoordinate = centerCoordinate2D;
    _centerCoordinate2D = centerCoordinate2D;
}

- (void)setStartTitle:(NSString *)startTitle {
    _startTitle = startTitle;
    self.startAnnotation.title = startTitle;
}

- (void)setEndTitle:(NSString *)endTitle {
    _endTitle = endTitle;
    self.endAnnotation.title = endTitle;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.locationService = [[BMKLocationService alloc] init];
    
    self.mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, PH_SCREEN_WIDTH, PH_SCREEN_WIDTH)];
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.mapView removeAnnotations:_mapView.annotations];
    
    self.mapView.showsUserLocation = NO;//先关闭显示的定位图层
    self.mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    self.mapView.showsUserLocation = YES;//显示定位图层
    //设置地图缩放级别
    [self.mapView setZoomLevel:11];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"导航" style:UIBarButtonItemStyleDone target:self action:@selector(navigationTO:)];
    self.navigationItem.rightBarButtonItem = item;
    
    PH_Weak(self);
    self.dispatchQueue = dispatch_get_global_queue(0, 0);//dispatch_queue_create("PHMapVC_Queue", DISPATCH_QUEUE_CONCURRENT);
    self.dispatchGroup = dispatch_group_create();
    
    dispatch_group_enter(self.dispatchGroup);
    dispatch_group_async(self.dispatchGroup, self.dispatchQueue, ^{
        PH_Strong(self);
        if (Coordinate2DIsValid(self.startCoordinate2D) && PH_CheckString(self.startAddress)) {
            dispatch_group_leave(self.dispatchGroup);
        } else if (Coordinate2DIsValid(self.startCoordinate2D)) {
            [PHLocationHelper addressFromCoorinate2D:self.startCoordinate2D completionHandler:^(NSString *address, CLLocationCoordinate2D coordinate2D, NSArray<CLPlacemark *> *placemarks) {
                PH_Strong(self);
                self.startAddress = address;
                dispatch_group_leave(self.dispatchGroup);
            }];
        } else if (PH_CheckString(self.startAddress)){
            [PHLocationHelper coordinate2DfromAddress:self.startAddress completionHandler:^(NSString *address, CLLocationCoordinate2D coordinate2D, NSArray<CLPlacemark *> *placemarks) {
                PH_Strong(self);
                self.startPlacemarks = placemarks;
                self.startCoordinate2D = coordinate2D;
                dispatch_group_leave(self.dispatchGroup);
            }];
        } else {//起始位置无效
            self.startAddress = @"当前位置";
            self.startCoordinate2D = [PHLocationHelper shareInstance].currentLocation.coordinate;
            dispatch_group_leave(self.dispatchGroup);
        }
    });
    
    dispatch_group_enter(self.dispatchGroup);
    dispatch_group_async(self.dispatchGroup, self.dispatchQueue, ^{
        PH_Strong(self);
        if (Coordinate2DIsValid(self.endCoordinate2D) && PH_CheckString(self.endAddress)) {
            dispatch_group_leave(self.dispatchGroup);
        } else if (Coordinate2DIsValid(self.endCoordinate2D)) {
            [PHLocationHelper addressFromCoorinate2D:self.endCoordinate2D completionHandler:^(NSString *address, CLLocationCoordinate2D coordinate2D, NSArray<CLPlacemark *> *placemarks) {
                PH_Strong(self);
                self.endAddress = address;
                dispatch_group_leave(self.dispatchGroup);
            }];
        } else if (PH_CheckString(self.endAddress)) {
            [PHLocationHelper coordinate2DfromAddress:self.endAddress completionHandler:^(NSString *address, CLLocationCoordinate2D coordinate2D, NSArray<CLPlacemark *> *placemarks) {
                PH_Strong(self);
                self.endPlacemarks = placemarks;
                self.endCoordinate2D = coordinate2D;
                dispatch_group_leave(self.dispatchGroup);
            }];
        } else {
            self.endAddress = @"当前位置";
            self.endCoordinate2D = [PHLocationHelper shareInstance].currentLocation.coordinate;
            dispatch_group_leave(self.dispatchGroup);
        }
    });
}


- (void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    self.locationService.delegate = self;
    [self.locationService startUserLocationService];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self ph_reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.mapView viewWillDisappear];
    self.locationService.delegate = nil;
    self.locationService = nil;
    self.mapView.delegate = nil;
    self.mapView = nil;
}

- (void)ph_reloadData {
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DIsValid(self.centerCoordinate2D)?self.centerCoordinate2D:[PHLocationHelper shareInstance].currentLocation.coordinate];
    if (self.startAnnotation && [_mapView.annotations containsObject:self.startAnnotation]) {
        [self.mapView removeAnnotation:self.startAnnotation];
    }
    self.startAnnotation.coordinate = _startCoordinate2D;
    [self.mapView addAnnotation:self.startAnnotation];
    if (self.endAnnotation && [_mapView.annotations containsObject:self.endAnnotation]) {
        [_mapView removeAnnotation:self.endAnnotation];
    }
    self.endAnnotation.coordinate = _endCoordinate2D;
    [self.mapView addAnnotation:self.endAnnotation];
}

- (void)ph_selectPlacemarks:(NSArray<CLPlacemark *> *)placemarks message:(NSString *)msg valueBlock:(PHValueBlock)valueBlock {
    NSMutableArray *places = [[NSMutableArray alloc] init];
    [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [places addObject:[PHLocationHelper addressFromPlacemark:obj level:PHAddressLevelCity]];
    }];
    
    [RMUniversalAlert showActionSheetInViewController:self withTitle:msg message:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:places popoverPresentationControllerBlock:nil tapBlock:^(RMUniversalAlert * _Nonnull alert, NSInteger buttonIndex) {
        if (buttonIndex >= 2) {
            CLPlacemark *placemark = placemarks[buttonIndex-2];
            if (valueBlock) {
                valueBlock(placemark);
            }
        }
    }];
}

#pragma mark -- map delegate
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation {
    [self.mapView updateLocationData:userLocation];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation {
    if (annotation == self.startAnnotation || annotation == self.endAnnotation) {
        PHMapAnnination *annotationView = (PHMapAnnination *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PHMapAnnination"];
        if (annotationView == nil) {
            annotationView = [[PHMapAnnination alloc] initWithAnnotation:annotation reuseIdentifier:@"PHMapAnnination"];
        }
        annotationView.thumbImageView.image = [UIImage imageNamed:(annotation==self.startAnnotation)?@"icon_start":@"icon_end"];
        return annotationView;
    }
    return nil;
}



#pragma mark -- view action
- (void)navigationTO:(UIBarButtonItem *)sender {
    PH_Weak(self);
    if (self.endPlacemarks.count > 1) {
        dispatch_group_enter(self.dispatchGroup);
        [self ph_selectPlacemarks:self.endPlacemarks message:@"选择目的地" valueBlock:^(id value) {
            PH_Strong(self);
            CLPlacemark *placemark = value;
            self.endCoordinate2D = placemark.location.coordinate;
            dispatch_group_leave(self.dispatchGroup);
        }];
    }

    if (self.startPlacemarks.count > 1) {
        dispatch_group_enter(self.dispatchGroup);
        [self ph_selectPlacemarks:self.startPlacemarks message:@"选择出发地" valueBlock:^(id value) {
            PH_Strong(self);
            CLPlacemark *placemark = value;
            self.startCoordinate2D = placemark.location.coordinate;
            dispatch_group_leave(self.dispatchGroup);
        }];
    }
    
    dispatch_group_notify(self.dispatchGroup, self.dispatchQueue, ^{
        PH_Strong(self);
        switch (self.type) {
            case PHRouteTypeFromCurrentToStart:
            {
                if (CLLocationCoordinate2DIsValid([PHLocationHelper shareInstance].currentLocation.coordinate)) {
                    [PHLocationHelper shareInstance].fromCoordinate2D = [PHLocationHelper shareInstance].currentLocation.coordinate;
                }
                if (CLLocationCoordinate2DIsValid(self.startCoordinate2D)) {
                    [PHLocationHelper shareInstance].toCoordinate2D = self.startCoordinate2D;
                }
            }
                break;
            case PHRouteTypeFromCurrentToEnd:
            {
                if (CLLocationCoordinate2DIsValid([PHLocationHelper shareInstance].currentLocation.coordinate)) {
                    [PHLocationHelper shareInstance].fromCoordinate2D = [PHLocationHelper shareInstance].currentLocation.coordinate;
                }
                if (CLLocationCoordinate2DIsValid(self.endCoordinate2D)) {
                    [PHLocationHelper shareInstance].toCoordinate2D = self.endCoordinate2D;
                }
            }
                break;
            case PHRouteTypeFromStartToEnd:
            {
                if (CLLocationCoordinate2DIsValid(self.startCoordinate2D)) {
                    [PHLocationHelper shareInstance].fromCoordinate2D = self.startCoordinate2D;
                }
                if (CLLocationCoordinate2DIsValid(self.endCoordinate2D)) {
                    [PHLocationHelper shareInstance].toCoordinate2D = self.endCoordinate2D;
                }
            }
                break;
        }
        
        PHLogInfo(@"from %@:%f %f to %@:%f %f", [PHLocationHelper shareInstance].fromAddress, [PHLocationHelper shareInstance].fromCoordinate2D.latitude, [PHLocationHelper shareInstance].fromCoordinate2D.longitude, [PHLocationHelper shareInstance].toAddress, [PHLocationHelper shareInstance].toCoordinate2D.latitude, [PHLocationHelper shareInstance].toCoordinate2D.longitude);
        if (Coordinate2DisEqual([PHLocationHelper shareInstance].fromCoordinate2D, [PHLocationHelper shareInstance].toCoordinate2D)) {
            PH_ShowTips(@"起始位置相同");
            return;
        }
        if (Coordinate2DIsValid(self.startCoordinate2D) && Coordinate2DIsValid(self.endCoordinate2D)) {
            [[PHLocationHelper shareInstance] ph_navigation];
        } else {
            PH_ShowTips(@"位置异常");
        }
    });
    
    
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
