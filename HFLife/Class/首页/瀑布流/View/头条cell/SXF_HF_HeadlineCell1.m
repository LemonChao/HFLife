//
//  SXF_HF_HeadlineCell1.m
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_HeadlineCell1.h"



@interface SXF_HF_HeadlineCell1()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UILabel *titleLb;
@property (nonatomic, strong) UILabel *timeLb;


@end

@implementation SXF_HF_HeadlineCell1


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.backgroundColor = [UIColor whiteColor];
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.bgView];
    
    
    self.imageV = [[UIImageView alloc] init];
    self.titleLb = [UILabel new];
    self.timeLb = [UILabel new];
    
    [self.bgView addSubview:self.imageV];
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.timeLb];
    
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV.layer.cornerRadius = 5;
    self.imageV.clipsToBounds = YES;
    self.titleLb.font = FONT(ScreenScale(14));
    self.titleLb.textColor = HEX_COLOR(0x131313);
    self.titleLb.numberOfLines = 2;
    
    self.timeLb.font = FONT(ScreenScale(11));
    self.timeLb.textColor = HEX_COLOR(0xAAAAAA);
    
    self.titleLb.text = @"汉富新生活本地商家服务 正式开放入驻";
    self.timeLb.text = @"2019-04-25";
    self.imageV.backgroundColor = HEX_COLOR(0xe1e1e1);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(6));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-ScreenScale(6));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(6));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-ScreenScale(6));
    }];
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.bgView).offset(ScreenScale(10));
        make.right.mas_equalTo(self.bgView).offset(-ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(80));
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.imageV);
        make.top.mas_equalTo(self.imageV.mas_bottom).offset(ScreenScale(10));
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.titleLb.mas_right);
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(-ScreenScale(10));
    }];
    
    
    
    
    [self layoutIfNeeded];
    
    self.bgView.layer.cornerRadius = 5;
    [self.bgView addShadowForViewColor:HEX_COLOR(0x808080) offSet:CGSizeMake(-1,2) shadowRadius:3 cornerRadius:5 opacity:0.3];
}


@end
