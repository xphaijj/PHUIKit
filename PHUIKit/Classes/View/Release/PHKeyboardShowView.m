//
//  PHKeyboardShowView.m
//  App
//
//  Created by Alex on 2017/7/22.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHKeyboardShowView.h"
#import <Masonry.h>
#import <PHBaseLib/PHTools.h>
#import "UIView+GESAdditions.h"
#import <ReactiveObjC.h>
#import "PHLineView.h"

@interface PHKeyboardShowView() {
    UIButton *cancelBtn;
    UIButton *sureBtn;
}

@property (nonatomic, strong) UIImageView *backgroundView;
@property (nonatomic, strong) UIView *toolsBar;
@property (nonatomic, strong) UILabel *barTitleLabel;

@end

@implementation PHKeyboardShowView

- (UIImageView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.backgroundColor = PH_ColorWithHexString(@"0x00000099");
    }
    return _backgroundView;
}

- (UIView *)toolsBar {
    if (!_toolsBar) {
        _toolsBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, PH_SCREEN_WIDTH, 44)];
        PHLineView.ph_create(_toolsBar);
        _toolsBar.backgroundColor = [UIColor whiteColor];
        cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_toolsBar addSubview:cancelBtn];
        [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [PHKeyboardShowView hide];
        }];
        
        sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [sureBtn setTitleColor:self.tintColor forState:UIControlStateNormal];
        [_toolsBar addSubview:sureBtn];
        [[sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (self.keyboardView && [self.keyboardView respondsToSelector:@selector(ph_keyboardValue)]) {
                self.value = [self.keyboardView performSelector:@selector(ph_keyboardValue) withObject:nil];
                if (self.callback) {
                    self.callback(self.value);
                }
            }
            [PHKeyboardShowView hide];
        }];
        
    }
    return _toolsBar;
}

- (UILabel *)barTitleLabel {
    if (!_barTitleLabel) {
        _barTitleLabel = [[UILabel alloc] init];
        _barTitleLabel.textColor = self.tintColor;
        [self addSubview:_barTitleLabel];
        [_barTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.toolsBar);
        }];
    }
    return _barTitleLabel;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = PH_ColorWithHexString(@"0x515151");
    }
    return _tintColor;
}

- (void)setKeyboardView:(UIView *)keyboardView {
    if (_keyboardView != keyboardView) {
        for (UIView *sub in self.subviews) {
            [sub removeFromSuperview];
        }
        [self addSubview:self.backgroundView];
        self.backgroundView.ges_tap(self, @selector(hide));
        [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _keyboardView = keyboardView;
        self.delegate = (id)_keyboardView;
        self.keyboardHeight = 0;
        self.aspect = 0;
        self.keyboardDirection = PHDirectionBottom;
        self.showToolBar = NO;
        [self addSubview:_keyboardView];
    }
}

- (void)setShowToolBar:(BOOL)showToolBar {
    _showToolBar = showToolBar;
    if (showToolBar) {
        [self addSubview:self.toolsBar];
    } else {
        [self.toolsBar removeFromSuperview];
    }
}

- (void)setBarTitle:(NSString *)barTitle {
    self.barTitleLabel.text = barTitle;
}

- (void)setCancelImage:(UIImage *)cancelImage {
    [cancelBtn setImage:cancelImage forState:UIControlStateNormal];
}

- (void)setSureImage:(UIImage *)sureImage {
    [sureBtn setImage:sureImage forState:UIControlStateNormal];
}

- (void)setCancelTitle:(NSString *)cancelTitle {
    [cancelBtn setTitle:cancelTitle forState:UIControlStateNormal];
}

- (void)setSureTitle:(NSString *)sureTitle {
    [sureBtn setTitle:sureTitle forState:UIControlStateNormal];
}

static PHKeyboardShowView *share_KeyboardShowView = nil;
+ (PHKeyboardShowView *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share_KeyboardShowView = [[PHKeyboardShowView alloc] initWithFrame:PH_SCREEN_BOUNDS];
    });
    return share_KeyboardShowView;
}

- (void)_realodUI {
    switch (self.keyboardDirection) {
        case PHDirectionTop:
        {
            [self.keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                if (self.keyboardHeight == 0) {
                    self.keyboardHeight = PH_SCREEN_HEIGHT*self.aspect;
                }
                make.height.equalTo(@(self.keyboardHeight));
                make.top.equalTo(self).with.offset(-self.keyboardHeight);
            }];
            if (self.showToolBar) {
                [self.toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.keyboardView.mas_bottom);
                    make.left.right.equalTo(self);
                    make.height.equalTo(@44);
                }];
                [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_toolsBar.mas_left).with.offset(16);
                    make.top.bottom.equalTo(_toolsBar);
                    make.width.equalTo(@44);
                }];
                [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(_toolsBar.mas_right).with.offset(-16);
                    make.top.bottom.equalTo(_toolsBar);
                    make.width.equalTo(@44);
                }];
            }
        }
            break;
        case PHDirectionBottom:
        {
            [self.keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(self);
                if (self.aspect!=0) {
                    self.keyboardHeight = PH_SCREEN_HEIGHT*self.aspect;
                }
                if (self.keyboardHeight == 0) {
                    self.keyboardHeight = 216;
                }
                make.height.equalTo(@(self.keyboardHeight));
                make.bottom.equalTo(self).with.offset(self.keyboardHeight);
            }];
            if (self.showToolBar) {
                [self.toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.equalTo(self.keyboardView.mas_top);
                    make.left.right.equalTo(self);
                    make.height.equalTo(@44);
                }];
                [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(_toolsBar.mas_left).with.offset(16);
                    make.top.bottom.equalTo(_toolsBar);
                    make.width.equalTo(@44);
                }];
                [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(_toolsBar.mas_right).with.offset(-16);
                    make.top.bottom.equalTo(_toolsBar);
                    make.width.equalTo(@44);
                }];
            }
        }
            break;
        case PHDirectionLeft:
        {
            [self.keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                if (self.keyboardHeight == 0) {
                    self.keyboardHeight = PH_SCREEN_WIDTH*self.aspect;
                }
                make.width.equalTo(@(self.keyboardHeight));
                make.left.equalTo(self).with.offset(-self.keyboardHeight);
            }];
            if (self.showToolBar) {
                [self.toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(self.keyboardView.mas_right);
                    make.top.bottom.equalTo(self);
                    make.width.equalTo(@44);
                }];
                [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(_toolsBar);
                    make.top.equalTo(_toolsBar).with.offset(16);
                    make.height.equalTo(@44);
                }];
                [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(_toolsBar);
                    make.bottom.equalTo(_toolsBar).with.offset(-16);
                    make.height.equalTo(@44);
                }];
            }
        }
            break;
        case PHDirectionRight:
        {
            [self.keyboardView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                if (self.keyboardHeight == 0) {
                    self.keyboardHeight = PH_SCREEN_WIDTH*self.aspect;
                }
                make.width.equalTo(@(self.keyboardHeight));
                make.right.equalTo(self).with.offset(self.keyboardHeight);
            }];
            if (self.showToolBar) {
                [self.toolsBar mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.equalTo(self.keyboardView.mas_left);
                    make.top.bottom.equalTo(self);
                    make.width.equalTo(@44);
                }];
                
                [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(_toolsBar);
                    make.top.equalTo(_toolsBar).with.offset(16);
                    make.height.equalTo(@44);
                }];
                [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.right.equalTo(_toolsBar);
                    make.bottom.equalTo(_toolsBar).with.offset(-16);
                    make.height.equalTo(@44);
                }];
            }
        }
            break;
    }
}


/**
 显示
 */
+ (void)show:(PHValueBlock)callback {
    if (![PHKeyboardShowView shareInstance].keyboardView) {
        return;
    }
    [PHKeyboardShowView shareInstance].callback = callback;
    UIWindow *keyWindow = PH_AppWindow;
    [keyWindow addSubview:[PHKeyboardShowView shareInstance]];
    [PHKeyboardShowView shareInstance].frame = keyWindow.bounds;
    [[PHKeyboardShowView shareInstance] _realodUI];
    [keyWindow layoutIfNeeded];
    
    [[PHKeyboardShowView shareInstance] animation:YES];
}

/**
 隐藏
 */
+ (void)hide {
    [[PHKeyboardShowView shareInstance] animation:NO];
}

- (void)hide {
    [PHKeyboardShowView hide];
}

/**
 动画效果显示

 @param isShow 是否是显示的时候调用
 */
- (void)animation:(BOOL)isShow {
    [self.keyboardView mas_updateConstraints:^(MASConstraintMaker *make) {
        switch (self.keyboardDirection) {
            case PHDirectionTop:
            {
                isShow?make.top.equalTo(self).with.offset(0):make.top.equalTo(self).with.offset(-self.keyboardHeight);
            }
                break;
            case PHDirectionBottom:
            {
                isShow?make.bottom.equalTo(self).with.offset(0):make.bottom.equalTo(self).with.offset(self.keyboardHeight);
            }
                break;
            case PHDirectionLeft:
            {
                isShow?make.left.equalTo(self).with.offset(0):make.left.equalTo(self).with.offset(-self.keyboardHeight);
            }
                break;
            case PHDirectionRight:
            {
                isShow?make.right.equalTo(self).with.offset(0):make.right.equalTo(self).with.offset(self.keyboardHeight);
            }
                break;
        }
    }];
    if (isShow) {
        self.backgroundView.alpha = 0;
        [UIView animateWithDuration:0.27 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self layoutIfNeeded];
            self.backgroundView.alpha = 0.5;
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.27 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            [self layoutIfNeeded];
            self.backgroundView.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
