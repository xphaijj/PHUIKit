//
//  PHTopMenu.m
//  App
//
//  Created by 項普華 on 2017/7/18.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "PHTopMenu.h"
#import <Masonry.h>

#import <PHBaseLib/PHMacro.h>

@interface PHTopMenu ()<UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    UIView *_superView;
    NSArray *_titles;
    NSArray *_views;
    UIView *topMenuView;//顶部菜单
    UIView *topSelectedView;//顶部视图选中的标识
    UICollectionView *mainCollectionView;//
}

@property (nonatomic, copy) PHValueBlock valueBlock;

@end

@implementation PHTopMenu

/**
 显示顶部菜单栏
 
 @param toView 目标视图
 @param titles 标题数组
 @param views views
 @param valueBlock 点击回调
 */
+ (PHTopMenu *)createTopMenuToView:(UIView *)toView
                            titles:(NSArray<NSString *> *)titles
                             views:(NSArray<UIView *> *)views
                        clickBlock:(PHValueBlock)valueBlock {
    PHTopMenu *topMenu = [[PHTopMenu alloc] initWithSuperView:toView titles:titles views:views clickBlock:valueBlock];
    return topMenu;
}

- (void)show {
    [self _configUI];
    [_superView layoutSubviews];
    [mainCollectionView reloadData];
}

- (id)initWithSuperView:(UIView *)toView
                 titles:(NSArray *)titles
                  views:(NSArray *)views
             clickBlock:(PHValueBlock)valueBlock  {
    self = [super init];
    if (self) {
        self.currentSelectedIndex = 0;
        self.menuHeight = 44.;
        self.currentSelectedMenuHeight = 2.;
        self.normalFont = [UIFont systemFontOfSize:12];
        self.tintFont = [UIFont systemFontOfSize:14];
        self.tintColor = [UIColor colorWithRed:238./255. green:86./255. blue:83./255. alpha:1.0];
        self.normalColor = [UIColor colorWithRed:153./255. green:153./255. blue:153./255. alpha:1.0];
        _superView = toView;
        _titles = titles;
        _views = views;
        self.valueBlock = valueBlock;
    }
    return self;
}
#pragma mark -- private

- (void)_configUI {
    [self removeFromSuperview];
    for (UIView *sub in self.subviews) {
        [sub removeFromSuperview];
    }
    if (_titles.count != _views.count) {
        PHLogError(@"数量异常");
        return;
    }
    
    [_superView addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(_superView);
    }];
    
    topMenuView = [[UIView alloc] init];
    [self addSubview:topMenuView];
    [topMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(self.menuHeight));
    }];
    CGFloat width = PH_SCREEN_WIDTH/_titles.count;
    for (int i = 0; i < _titles.count; i++) {
        NSString *title = _titles[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(_click:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.tintColor forState:UIControlStateSelected];
        [btn setTitleColor:self.normalColor forState:UIControlStateNormal];
        [topMenuView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(i*width));
            make.width.equalTo(@(width));
            make.top.bottom.equalTo(topMenuView);
        }];
    }
    topSelectedView = [[UIView alloc] init];
    topSelectedView.backgroundColor = self.tintColor;
    [topMenuView addSubview:topSelectedView];
    [topSelectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(topMenuView);
        make.width.equalTo(@(width));
        make.height.equalTo(@(self.currentSelectedMenuHeight));
    }];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    mainCollectionView.pagingEnabled = YES;
    mainCollectionView.bounces = NO;
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    [mainCollectionView setDelaysContentTouches:NO];
    [mainCollectionView setCanCancelContentTouches:NO];
    mainCollectionView.alwaysBounceHorizontal = YES;
    mainCollectionView.alwaysBounceVertical = NO;
    mainCollectionView.directionalLockEnabled = YES;
    [mainCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:mainCollectionView];
    [mainCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(topMenuView.mas_bottom);
    }];

    [self _click:@(self.currentSelectedIndex)];
}

- (void)_click:(id)sender {
    NSInteger index = 0;
    if ([sender isKindOfClass:[UIButton class]]) {
        index = ((UIButton *)sender).tag;
    } else if ([sender isKindOfClass:[NSNumber class]]){
        index = [((NSNumber *) sender) integerValue];
    } else {
        return;
    }
    if (index >= _titles.count) {
        index = _titles.count-1;
    }
    if (self.currentSelectedIndex == index) {
        return;
    }
    
    for (UIButton *btn in topMenuView.subviews) {
        if ([btn isKindOfClass:[UIButton class]]) {
            btn.selected = (btn.tag == index);
        }
    }
    [topSelectedView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(index*topSelectedView.frame.size.width));
    }];
    if ([sender isKindOfClass:[UIButton class]]) {
        [mainCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
    [UIView animateWithDuration:0.27 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
    }];
    self.currentSelectedIndex = index;
    if (self.valueBlock) {
        self.valueBlock(@(index));
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger index = ceilf((scrollView.contentOffset.x-scrollView.frame.size.width/2.)/scrollView.frame.size.width);
    if (index != self.currentSelectedIndex) {
        [self _click:@(index)];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _views.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    for (UIView *sub in cell.subviews) {
        [sub removeFromSuperview];
    }
    UIView *view = _views[indexPath.row];
    [cell addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell);
    }];
    return cell;
}


@end
