
//
//  customItemView.m
//  masonry对数组布局
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "customItemView.h"
#import <Masonry.h>
@interface customItemView()

@property (nonatomic, strong)UIButton *tapBtn;
@end

@implementation customItemView

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
    self.titleLb = [UILabel new];
    self.imageV  = [UIImageView new];
    self.tapBtn  = [UIButton new];
    
    [self addSubview:self.titleLb];
    [self addSubview:self.imageV];
    [self addSubview:self.tapBtn];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLb.text = @"标题";
    [self.tapBtn addTarget:self action:@selector(clickUpBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
- (void) clickUpBtn:(UIButton *)sender{
    !self.clickItem ? : self.clickItem(sender.tag);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(30));
        make.height.mas_equalTo(30);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-ScreenScale(30));
        make.top.mas_equalTo(self.imageV.mas_bottom).offset(ScreenScale(10));
    }];
    
    [self.tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self);
    }];
    
    
}
@end
