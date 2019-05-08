//
//  YYB_HF_LocalHeadView.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "YYB_HF_LocalHeadView.h"

@implementation YYB_HF_LocalHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.headImageV = [UIImageView new];
    self.localLabel = [UILabel new];
    self.selectBtn = [UIButton new];
    self.searchlabel = [UILabel new];
    
    
    [self addSubview:self.headImageV];
    [self addSubview:self.localLabel];
    [self addSubview:self.selectBtn];
    
    self.headImageV.backgroundColor = [UIColor redColor];
    
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(HeightStatus + 7);
        make.left.mas_equalTo(self).mas_offset(20);
        make.width.height.mas_equalTo(33);
    }];
    
    self.localLabel.text = @"郑州";
    [self.localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.headImageV.mas_right).mas_offset(10);
        make.height.mas_equalTo(14);
    }];
    
    self.selectBtn.backgroundColor = [UIColor redColor];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.localLabel.mas_right).mas_offset(0);
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(10);
    }];
    
    UIView *searchBgView = [UIView new];
    searchBgView.backgroundColor = HEX_COLOR(0xF5F5F5);
    searchBgView.clipsToBounds = YES;
    searchBgView.layer.cornerRadius = 4;
    [self addSubview:searchBgView];
    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(20);
        make.right.mas_equalTo(self).mas_offset(-20);
        make.height.mas_equalTo(33);
    }];
    
    UIImageView *searchIcon = [UIImageView new];
    searchIcon.backgroundColor = [UIColor redColor];
    [searchBgView addSubview:searchIcon];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(searchBgView).mas_offset(22);
        make.width.height.mas_equalTo(14);
    }];
    [searchBgView addSubview:self.searchlabel];
    self.searchlabel.text = @"海底捞";
    self.searchlabel.textColor = [UIColor blackColor];
    [self.searchlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(searchIcon.mas_right).mas_offset(10);
        make.height.mas_equalTo(13);
    }];
}
@end
