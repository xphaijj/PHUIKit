//
//  PHBaseVC.m
//  Example
//
//  Created by 項普華 on 2017/5/10.
//  Tel:(+86)13316987488  Mail:xiangpuhua@126.com
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHBaseVC.h"

#import <PHBaseLib/PHMacro.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "PHView.h"

@implementation PHBaseVCModel

@end


@interface PHBaseVC () {
}

@end

@implementation PHBaseVC

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    PHBaseVC *baseVC = [super allocWithZone:zone];
    @weakify(baseVC);
    [[baseVC rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(baseVC);
        if ([baseVC respondsToSelector:@selector(ph_addSubviews)]) {
            [baseVC ph_addSubviews];
        }
        if ([baseVC respondsToSelector:@selector(ph_bindModel)]) {
            [baseVC ph_bindModel];
        }
        if ([baseVC respondsToSelector:@selector(ph_request)]) {
            [baseVC ph_request];
        }
    }];
    [[baseVC rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
        @strongify(baseVC);
        if ([baseVC respondsToSelector:@selector(ph_loadData)]) {
            [baseVC ph_loadData];
        }
    }];
    
    [[baseVC rac_signalForSelector:@selector(viewDidAppear:)] subscribeNext:^(id x) {
        @strongify(baseVC);
        if ([baseVC respondsToSelector:@selector(ph_autolayout)]) {
            [baseVC ph_autolayout];
        }
    }];
    
    [[baseVC rac_signalForSelector:@selector(viewDidDisappear:)] subscribeNext:^(id x) {
        @strongify(baseVC);
        if ([baseVC respondsToSelector:@selector(ph_dismiss)]) {
            [baseVC ph_dismiss];
        }
        //递归所有的view 通知当前vc生命周期结束
        [baseVC _recursionSubviews:baseVC.view];
    }];
    
    return baseVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:PH_VIEWAPPEAR object:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:PH_VIEWDISAPPEAR object:self];
}

- (BOOL)willDealloc {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- private
- (void)_recursionSubviews:(UIView *)targetView {
    for (PHView *subview in targetView.subviews) {
        if (subview && [subview respondsToSelector:@selector(ph_dismiss)]) {
            [subview ph_dismiss];
        }
        [self _recursionSubviews:subview];
    }
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    PHBaseVC *vc = segue.destinationViewController;
    @weakify(self);
    if ([vc respondsToSelector:@selector(ph_nextData:backBlock:)]) {
        [vc ph_nextData:sender backBlock:^(id data) {
            @strongify(self);
            [self ph_back:data];
        }];
    }
}

#pragma mark RAC
- (void)ph_nextData:(id)data
          backBlock:(PHVCBackBlock)backBlock {
    self.lastPageData = data;
    self.backBlock = backBlock;
}

/**
 视图创建 params 参数
 * @"push":@(YES)    push 进去 否则present进去
 * @"title":@"页面标题"  title 内容标题
 * @"target":self     target 当前页面
 * @"nib":@"PHBaseVC"  nib的名称
 * @"storyboard":@"Main"  storyboard 的名称  使用storyboard的时候 配合nib一起使用  否则nib名称默认与storyboard一致
 */
+ (PHBaseVC *(^)(PHBaseVCModel *params))ph_create {
    return ^id(PHBaseVCModel *params) {
        PHBaseVC *result;
        if (!params) {
            params = [[PHBaseVCModel alloc] init];
        }
        
        if (PH_CheckString(params.storyboard)) {
            if (!PH_CheckString(params.nib)) {
                params.nib = params.storyboard;
            }
            result = [PH_Storyboard(params.storyboard) instantiateViewControllerWithIdentifier:params.nib];
        } else if (PH_CheckString(params.nib)) {
            for (id object in [[NSBundle mainBundle] loadNibNamed:params.nib owner:self options:nil]) {
                if ([object isKindOfClass:self]) {
                    result = object;
                }
            }
        } else {
            result = [[self alloc] init];
        }
        if (result == nil) {
            result = [[self alloc] init];
            PHLogInfo(@"初始化失败");
        }
        
        [result ph_nextData:params.extras backBlock:params.backBlock];
        
        if ([params.target isKindOfClass:[UIView class]]) {
            UIView *superView = params.target;
            [superView addSubview:result.view];
            [result.view mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.equalTo(superView);
            }];
        } else if ([params.target isKindOfClass:[UIViewController class]]){
            result.title = params.title;
            if (!params.target || (!params.present && ![params.target respondsToSelector:@selector(navigationController)]) || (params.present && ![params.target respondsToSelector:@selector(presentViewController:animated:completion:)])) {
                params.target = PH_CurrentVC();
            }
            if (!params.present) {
                [((UIViewController *)params.target).navigationController pushViewController:result animated:YES];
            } else {
                [params.target presentViewController:result animated:YES completion:nil];
            }
        }
        
        return result;
    };
}



- (void)dealloc {
    //移除所有通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSString *vcName = NSStringFromClass([self class]);
    PHLogWarn(@".................%@释放...............",vcName);
}


@end














