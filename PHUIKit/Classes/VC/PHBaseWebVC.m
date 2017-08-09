//
//  PHBaseWebVC.m
//  App
//
//  Created by 項普華 on 2017/6/14.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHBaseWebVC.h"
#import <Masonry/Masonry.h>

@interface PHBaseWebVC ()<UIWebViewDelegate> {
    UIWebView *webView;
}

@end

@implementation PHBaseWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:self.originUrl]];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
    }];
}

#pragma mark -- delegate
//可以使用以下方法来拦截webview的协议
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSDictionary *params = PH_DictionaryFromURLString(request.URL.absoluteString);
    
    PHLog(@"%@", request.URL.absoluteString);
    PHLog(@"%@", params);
    //这里判断 参数出现的情况 然后跳转到不同页面
    if ([params[@"f"] isEqualToString:@"3"]) {
        //[DCURLRouter presentURLString:@"dariel://root?name=nsdn&age= 你好" animated:YES completion:nil];
        [DCURLRouter pushURLString:@"dariel://root?name=nsdn&age= 你好" animated:YES];
        return NO;
    }
    
    return YES;
}








- (void)dealloc {
    //移除所有通知监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSString *vcName = NSStringFromClass([self class]);
    PHLogWarn(@".................%@释放...............",vcName);
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
