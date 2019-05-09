//
//  SXF_HF_CustomSearchBar.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CustomSearchBar.h"

@interface SXF_HF_CustomSearchBar()

@property (nonatomic, strong)UIView *searchBgView;
@property (nonatomic, strong)UIImageView *searchImageV;
@property (nonatomic, strong)UILabel *seatchTitle;

@end



@implementation SXF_HF_CustomSearchBar

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
    self.seatchTitle    = [UILabel new];
    self.searchBgView   = [UIView new];
    self.searchImageV   = [UIImageView new];
    
    [self addSubview:self.searchBgView];
    [self.searchBgView addSubview:self.searchImageV];
    [self.searchBgView addSubview:self.seatchTitle];
    
    self.seatchTitle.font = MyFont(13);
    self.seatchTitle.textColor = [UIColor colorWithHexString:@"#1D1B1B"];
    self.seatchTitle.text = @"搜索";
    
    self.searchImageV.image = [UIImage imageNamed:@"搜索"];
    self.searchBgView.backgroundColor =  HEX_COLOR(0xF5F5F5);
    self.searchBgView.layer.cornerRadius = 4;
    self.searchBgView.layer.masksToBounds = YES;
    self.searchImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchView)];
    [self addGestureRecognizer:tap];
}
- (void) tapSearchView{
    !self.searchBtnClick ? : self.searchBtnClick();
}
- (void)layoutSubviews{
    [super layoutSubviews];
     
    [self.searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(8);
        make.bottom.mas_equalTo(self).offset(-8);
        make.left.mas_equalTo(self).offset(12);
        make.right.mas_equalTo(self).offset(-12);
    }];
     
    [self.searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchBgView.mas_left).offset(12);
        make.top.bottom.mas_equalTo(self.searchBgView);
        make.width.mas_equalTo(13);
    }];
     
     [self.seatchTitle mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.searchImageV.mas_right).offset(9);
         make.centerY.mas_equalTo(self.searchImageV.mas_centerY);
     }];
    
    
}

@end
