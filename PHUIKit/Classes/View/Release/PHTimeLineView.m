//
//  PHTimeLineView.m
//  App
//
//  Created by 項普華 on 2017/7/23.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHTimeLineView.h"
#import "UIView+GESAdditions.h"

#import <PHBaseLib/PHMacro.h>

@interface PHTimeLine : UIView

PH_CopyProperty(PHValueBlock block);

/**
 是否选中 设置的时候有动画效果
 */
PH_BoolProperty(selected);
PH_ColorProperty(tintColor);
PH_ColorProperty(normalColor);


@end

@implementation PHTimeLine

- (id)initWithNormalColor:(UIColor *)normalColor
                tintColor:(UIColor *)tintColor
                     data:(id)data
                direction:(PHDirection)direction
                 selected:(BOOL)selected {
    self = [super init];
    if (self) {
        _selected = selected;
        _tintColor = tintColor;
        _normalColor = normalColor;
        UIImageView *lineImageView = [[UIImageView alloc] init];
        lineImageView.backgroundColor = selected?tintColor:normalColor;
        [self addSubview:lineImageView];
        
        UIImageView *dotImageView = [[UIImageView alloc] init];
        dotImageView.backgroundColor = selected?tintColor:normalColor;
        dotImageView.layer.cornerRadius = 6;
        dotImageView.layer.masksToBounds = YES;
        dotImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        dotImageView.layer.borderWidth = 2;
        [self addSubview:dotImageView];
        
        if ([data isKindOfClass:[UIImage class]]) {
            [dotImageView setImage:data];
            switch (direction) {
                case PHDirectionTop:
                case PHDirectionBottom:
                {
                    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self);
                        make.centerY.equalTo(self);
                        make.height.equalTo(@8);
                    }];
                    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self);
                        make.centerY.equalTo(self);
                        make.top.bottom.equalTo(self);
                        make.width.equalTo(dotImageView.mas_height);
                    }];
                }
                    break;
                case PHDirectionLeft:
                case PHDirectionRight:
                {
                    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(self);
                        make.centerX.equalTo(self);
                        make.width.equalTo(@8);
                    }];
                    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self);
                        make.centerY.equalTo(self);
                        make.left.right.equalTo(self);
                        make.height.equalTo(dotImageView.mas_width);
                    }];
                }
                    break;
            }
        } else {
            UILabel *nameLabel = [[UILabel alloc] init];
            nameLabel.font = [UIFont systemFontOfSize:14];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.textColor = selected?tintColor:normalColor;
            nameLabel.text = data;
            [self addSubview:nameLabel];
            
            switch (direction) {
                case PHDirectionTop:
                {
                    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self);
                        make.top.equalTo(@4);
                        make.height.equalTo(@4);
                    }];
                    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self);
                        make.top.equalTo(self);
                        make.width.height.equalTo(@12);
                    }];
                    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self);
                        make.top.equalTo(dotImageView.mas_bottom).with.offset(4);
                    }];
                }
                    break;
                case PHDirectionBottom:
                {
                    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self);
                        make.bottom.equalTo(@(-4));
                        make.height.equalTo(@4);
                    }];
                    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(self);
                        make.bottom.equalTo(self);
                        make.width.height.equalTo(@12);
                    }];
                    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.right.equalTo(self);
                        make.bottom.equalTo(dotImageView.mas_top).with.offset(-4);
                    }];
                }
                    break;
                    
                case PHDirectionLeft:
                {
                    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(self);
                        make.left.equalTo(@(4));
                        make.width.equalTo(@4);
                    }];
                    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(self);
                        make.left.equalTo(self);
                        make.width.height.equalTo(@12);
                    }];
                    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(self);
                        make.left.equalTo(dotImageView.mas_right).with.offset(4);
                    }];
                }
                    break;
                case PHDirectionRight:
                {
                    [lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(self);
                        make.right.equalTo(@(-4));
                        make.width.equalTo(@4);
                    }];
                    [dotImageView mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(self);
                        make.right.equalTo(self);
                        make.width.height.equalTo(@12);
                    }];
                    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(self);
                        make.right.equalTo(dotImageView.mas_left).with.offset(-4);
                    }];
                }
                    break;
                    
                default:
                    break;
            }
            
            
            
            
            
            
        }
        
        
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    if (_selected) {
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[UIImageView class]]) {
                sub.backgroundColor = _tintColor;
            } else if ([sub isKindOfClass:[UILabel class]]) {
                ((UILabel *)sub).textColor = _tintColor;
            }
        }
    } else {
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[UIImageView class]]) {
                sub.backgroundColor = _normalColor;
            } else if ([sub isKindOfClass:[UILabel class]]) {
                ((UILabel *)sub).textColor = _normalColor;
            }
        }
    }
}

- (void)setTintColor:(UIColor *)tintColor {
    if (tintColor) {
        _tintColor = tintColor;
        if (_selected) {
            for (UIView *sub in self.subviews) {
                if ([sub isKindOfClass:[UIImageView class]]) {
                    sub.backgroundColor = tintColor;
                } else if ([sub isKindOfClass:[UILabel class]]) {
                    ((UILabel *)sub).textColor = tintColor;
                }
            }
        }
    }
}

- (void)setNormalColor:(UIColor *)normalColor {
    if (normalColor) {
        if (!_selected) {
            for (UIView *sub in self.subviews) {
                if ([sub isKindOfClass:[UIImageView class]]) {
                    sub.backgroundColor = normalColor;
                } else if ([sub isKindOfClass:[UILabel class]]) {
                    ((UILabel *)sub).textColor = normalColor;
                }
            }
        }
    }
}

@end





@interface PHTimeLineView ()

PH_ColorProperty(normalColor);
PH_ColorProperty(tintColor);
PH_CopyProperty(PHValueBlock valueBlock);

@end

@implementation PHTimeLineView

//传入数据 datas 部分可以为文字数组 也可以为图像数组
+ (PHTimeLineView *(^)(NSArray *datas, UIView *superView, PHDirection direction, NSInteger currentSelectedIndex, PHValueBlock block))ph_create {
    return ^id(NSArray *datas, UIView *superView, PHDirection direction, NSInteger currentSelectedIndex, PHValueBlock block) {
        PHTimeLineView *result = [[PHTimeLineView alloc] initWithSuperView:superView datas:datas direction:direction selectedIndex:currentSelectedIndex valueBlock:block];
        return result;
    };
}

- (id)initWithSuperView:(UIView *)superView datas:(NSArray *)datas direction:(PHDirection)direction selectedIndex:(NSInteger)selectedIndex valueBlock:(PHValueBlock)block {
    self = [super init];
    if (self) {
        direction = (direction!=0)?direction:PHDirectionTop;
        [superView addSubview:self];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(superView);
        }];
        self.backgroundColor = [UIColor clearColor];
        [superView layoutSubviews];
        //单个的宽度 或 高度
        CGFloat width = superView.frame.size.width/datas.count;
        self.normalColor = HEXCOLOR(0x999999);
        self.tintColor = HEXCOLOR(0xFF5555);
        self.valueBlock = block;
        switch (direction) {
            case PHDirectionTop:
            {
                for (int i = 0; i < datas.count; i++) {
                    PHTimeLine *timeLine = [[PHTimeLine alloc] initWithNormalColor:self.normalColor tintColor:self.tintColor data:datas[i] direction:direction selected:selectedIndex>=i];
                    timeLine.tag = i;
                    [self addSubview:timeLine];
                    [timeLine mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.top.bottom.equalTo(self);
                        make.left.equalTo(@(i*width));
                        make.width.equalTo(@(width));
                    }];
                    timeLine.ges_tap(self, @selector(tapAction:));
                }
            }
                break;
                
            default:
                break;
        }
    }
    return self;
}



//普通状态颜色
- (PHTimeLineView *(^)(UIColor *normalColor))ph_normalColor {
    return ^id(UIColor *normalColor) {
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[PHTimeLine class]]) {
                ((PHTimeLineView *)sub).normalColor = normalColor;
            }
        }
        return self;
    };
}

//高亮状态的颜色
- (PHTimeLineView *(^)(UIColor *tintColor))ph_tintColor {
    return ^id(UIColor *tintColor) {
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[PHTimeLine class]]) {
                ((PHTimeLineView *)sub).tintColor = tintColor;
            }
        }
        return self;
    };
}

//当前选中的 动画效果从上一个选中的到下一个选中
- (PHTimeLineView *(^)(NSInteger currentIndex))ph_currentIndex {
    return ^id(NSInteger currentIndex) {
        for (UIView *sub in self.subviews) {
            if ([sub isKindOfClass:[PHTimeLine class]]) {
                ((PHTimeLine *)sub).selected = sub.tag <= currentIndex;
            }
        }
        return self;
    };
}






- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.valueBlock) {
        self.valueBlock(@(sender.view.tag));
    }
}


@end
