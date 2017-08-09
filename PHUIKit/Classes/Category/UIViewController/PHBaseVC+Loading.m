//
//  PHBaseVC+Loading.m
//  App
//
//  Created by 項普華 on 2017/6/24.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHBaseVC+Loading.h"
#import <objc/message.h>

#import <PHBaseLib/PHMacro.h>
#import <PHBaseLib/PHTools.h>
#import "UIView+PHUtils.h"

#pragma mark -- loading lazy
@interface PHBaseVC (Lazy)

/**
 自己的window
 */
@property (nonatomic, strong) UIWindow *loadingWindow;
/**
 背景视图
 */
@property (nonatomic, readonly, strong) UIView *loadingBackgroundView;

/**
 点击背景视图
 */
@property (nonatomic, readonly, strong) UITapGestureRecognizer *loadingTapBackground;
/**
 加载视图
 */
@property (nonatomic, readonly, strong) UIView *loadingView;

/**
 无数据视图
 */
@property (nonatomic, readonly, strong) UIView *loadingNoDataView;

/**
 网络异常的view
 */
@property (nonatomic, readonly, strong) UIView *networkView;

/**
 默认加载显示控件
 */
@property (nonatomic, readonly, strong) UIActivityIndicatorView *loadingActivityView;

/**
 加载显示标题
 */
@property (nonatomic, readonly, strong) UILabel *titleLabel;

/**
 加载显示image
 */
@property (nonatomic, readonly, strong) UIImageView *loadingImageView;

/**
 加载显示GIF动画格式
 */
@property (nonatomic, readonly, strong) UIWebView *loadingWebView;

/**
 加载更多的按钮
 */
@property (nonatomic, readonly, strong) UIButton *loadingButton;

/**
 视图消失的回调
 */
@property (nonatomic, copy) PHDismissBlock dismissBlock;

@end

@implementation PHBaseVC (Lazy)

@dynamic loadingWindow;
@dynamic loadingTapBackground;
@dynamic loadingBackgroundView;
@dynamic loadingView;
@dynamic loadingNoDataView;
@dynamic networkView;
@dynamic loadingActivityView;
@dynamic titleLabel;
@dynamic loadingImageView;
@dynamic loadingWebView;
@dynamic loadingButton;
@dynamic dismissBlock;

PHLazyCategory(UIWindow, loadingWindow);
PHLazyCategory(UIView, loadingBackgroundView);
PHLazyCategory(UITapGestureRecognizer, loadingTapBackground);
PHLazyCategory(UIView, loadingView);
PHLazyCategory(UIView, loadingNoDataView);
PHLazyCategory(UIView, networkView);
PHLazyCategory(UIActivityIndicatorView, loadingActivityView);
PHLazyCategory(UILabel, titleLabel);
PHLazyCategory(UIWebView, loadingWebView);
PHLazyCategory(UIImageView, loadingImageView);
PHLazyCategory(UIButton, loadingButton);

- (void)setDismissBlock:(PHDismissBlock)dismissBlock {
    objc_setAssociatedObject(self, @selector(dismissBlock), dismissBlock, OBJC_ASSOCIATION_COPY);
}

- (PHDismissBlock)dismissBlock {
    return objc_getAssociatedObject(self, @selector(dismissBlock));
}

- (void)_tapBackground:(UITapGestureRecognizer *)gesture {
    [UIView animateWithDuration:0.4 animations:^{
        self.loadingView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.loadingWindow resignKeyWindow];
        self.loadingWindow.hidden = YES;
    }];
}

@end


#pragma mark -- loading
@implementation PHBaseVC (Loading)

/**
 显示加载视图
 
 @param clickToDismiss 点击背景是否显示 默认为YES
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingViewClickToDismiss:(BOOL)clickToDismiss
                                 dismiss:(PHDismissBlock)dismissBlock {
    [self ph_showLoadingImagename:nil
                            title:@"正在加载"
                   clickToDismiss:clickToDismiss
                          dismiss:dismissBlock];
}
/**
 显示加载视图
 
 @param imagename 加载视图上显示的image
 @param title 标题
 @param clickToDismiss 点击背景是否显示 默认为YES
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingImagename:(NSString *)imagename
                          title:(NSString *)title
                 clickToDismiss:(BOOL)clickToDismiss
                        dismiss:(PHDismissBlock)dismissBlock {
    [self ph_initBaseWindowFrame:PH_SCREEN_BOUNDS loadingViewFrame:CGRectMake(0, 0, PH_SCREEN_WIDTH/2., PH_SCREEN_WIDTH/2.) imagename:imagename title:title clickToDismiss:clickToDismiss block:dismissBlock];
    PH_ViewBorderRadius(self.loadingView, 6, 2, [UIColor blueColor]);
}


/**
 显示无数据的视图
 
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingNoDataDismiss:(PHDismissBlock)dismissBlock {
    [self ph_showLoadingNoDataImagename:@"logo.jpg" reloadTitle:@"数据为空" dismiss:dismissBlock];
}

/**
 显示无数据的视图
 
 @param imagename 显示的image
 @param title 重新加载按钮的标题
 @param dismissBlock 消失的回调
 */
- (void)ph_showLoadingNoDataImagename:(NSString *)imagename
                          reloadTitle:(NSString *)title
                              dismiss:(PHDismissBlock)dismissBlock {
    [self ph_initBaseWindowFrame:self.view.frame loadingViewFrame:self.view.bounds imagename:imagename title:title clickToDismiss:NO block:dismissBlock];
}

/**
 显示网络异常的视图
 
 @param dismissBlock 消失的回调
 */
- (void)ph_showNetworkDismiss:(PHDismissBlock)dismissBlock {
    [self ph_showNetworkImagename:@"logo.jpg" reloadTitle:@"网络异常" dismiss:dismissBlock];
}

/**
 显示网络异常的视图
 
 @param imagename 显示的Image
 @param reloadTitle 重新加载的标题
 @param dismissBlock 消失的回调
 */
- (void)ph_showNetworkImagename:(NSString *)imagename
                reloadTitle:(NSString *)reloadTitle
                    dismiss:(PHDismissBlock)dismissBlock {
    [self ph_initBaseWindowFrame:self.view.frame loadingViewFrame:self.view.bounds imagename:imagename title:reloadTitle clickToDismiss:NO block:dismissBlock];
}

/**
 消失加载视图以及消失没有数据的视图
 */
- (void)ph_dismissLoadingView {
    if (self.dismissBlock) {
        self.dismissBlock(nil);
    }
    [self _tapBackground:nil];
}


#pragma mark -- private method 
- (void)ph_initBaseWindowFrame:(CGRect)windowFrame loadingViewFrame:(CGRect)loadingViewFrame imagename:(NSString *)imagename title:(NSString *)title clickToDismiss:(BOOL)clickToDismiss block:(PHDismissBlock)dismissBlock {
    for (UIView *view in self.loadingWindow.subviews) {
        [view removeFromSuperview];
    }
    //赋值操作
    self.dismissBlock = dismissBlock;
    //window 相关配置
    self.loadingWindow.hidden = NO;
    self.loadingWindow.frame = windowFrame;
    self.loadingWindow.backgroundColor = [UIColor clearColor];
    //点击背景是否消失的背景
    if (clickToDismiss) {
        [self.loadingWindow addSubview:self.loadingBackgroundView];
        self.loadingBackgroundView.frame = self.loadingWindow.bounds;
        [self.loadingTapBackground addTarget:self action:@selector(_tapBackground:)];
        [self.loadingBackgroundView addGestureRecognizer:self.loadingTapBackground];
    }
    //loadingView 相关配置
    self.loadingView.alpha = 0;
    self.loadingView.frame = loadingViewFrame;
    self.loadingView.backgroundColor = [UIColor redColor];
    [self.loadingWindow addSubview:self.loadingView];
    self.loadingView.center = self.loadingWindow.ph_selfcenter;

    //图片相关配置
    if (PH_CheckString(imagename)) {
        if ([[imagename lowercaseString] hasSuffix:@".gif"]) {
            self.loadingWebView.scalesPageToFit = YES;
            [self.loadingWebView loadData:PH_Data(imagename) MIMEType:@"image/gif" textEncodingName:@"utf-8" baseURL:[NSURL URLWithString:@""]];
            self.loadingWebView.opaque = NO;
            [self.loadingView addSubview:self.loadingWebView];
            self.loadingWebView.backgroundColor = [UIColor clearColor];
            self.loadingWebView.frame = self.loadingView.bounds;
            self.loadingWebView.center = self.loadingView.ph_selfcenter;
        } else {
            self.loadingImageView.image = PH_Image(imagename);
            [self.loadingView addSubview:self.loadingImageView];
            self.loadingImageView.frame = CGRectMake(0, 0, 80, 80);
            self.loadingImageView.center = self.loadingView.ph_selfcenter;
        }
    } else {
        [self.loadingActivityView startAnimating];
        [self.loadingView addSubview:self.loadingActivityView];
        self.loadingActivityView.center = self.loadingView.ph_selfcenter;
    }
    
    //标题相关配置
    if (!PH_CheckString(title)) {
        title = @"正在加载...";
    }
    self.titleLabel.text = title;
    self.titleLabel.textColor = [UIColor greenColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.loadingView addSubview:self.titleLabel];
    self.titleLabel.frame = CGRectMake(0, 0, PH_SCREEN_WIDTH/2., 20);
    self.titleLabel.center = CGPointMake(self.loadingView.ph_selfcenter.x, self.loadingView.ph_selfcenter.y+40);
    
    //显示相关
    [UIView animateWithDuration:0.4 animations:^{
        self.loadingView.alpha = 1;
    } completion:^(BOOL finished) {
    }];
    self.loadingWindow.windowLevel = UIWindowLevelAlert-1;
    [self.loadingWindow makeKeyAndVisible];
    
}

@end
