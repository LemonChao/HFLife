
//
//  myTopView.m
//  masonry对数组布局
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "myTopView.h"
#import "customItemView.h"
#import <Masonry.h>
@interface myTopView()
@property (nonatomic, strong)NSMutableArray <customItemView *>*itemArr;
@property (nonatomic, strong)customItemView *item;
@end

@implementation myTopView
{
    NSArray *_titleArr;
    NSArray *_imageArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    _titleArr = @[@"扫一扫", @"付款", @"收款", @"卡包"];
    _imageArr = @[@"扫一扫", @"fukuan", @"shouqian", @"我的卡包"];
    self.itemArr = [NSMutableArray array];
    for (int i = 0; i < _titleArr.count; i++) {
        customItemView *item = [customItemView new];
        item.tag = i;
        item.titleLb.text = _titleArr[i];
        item.imageV.image = [UIImage imageNamed:_imageArr[i]];
        
        item.clickItem = ^(NSInteger index) {
            !self.selectedItem ? : self.selectedItem(index);
        };
        
        [self.itemArr addObject:item];
        [self addSubview:item];
        self.item = item;
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.itemArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:[UIScreen mainScreen].bounds.size.width / _titleArr.count leadSpacing:0 tailSpacing:0];
    [self.itemArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
    }];
}
@end
