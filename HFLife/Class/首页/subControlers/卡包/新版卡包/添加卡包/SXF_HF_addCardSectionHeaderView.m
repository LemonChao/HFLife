//

//  SXF_HF_addCardSectionHeaderView.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_addCardSectionHeaderView.h"

@interface SXF_HF_addCardSectionHeaderView ()
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subTitleLb;
@property (nonatomic, strong)UIImageView *rightIncoderV;
@end

@implementation SXF_HF_addCardSectionHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    
    return self;
}

- (void)addChildrenViews{
    self.titleLb     = [UILabel new];
    self.subTitleLb  = [UILabel new];
    self.rightIncoderV = [UIImageView new];
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.subTitleLb];
    [self.contentView addSubview:self.rightIncoderV];
    
    self.titleLb.font = [UIFont fontWithName:@"PingFang-SC-Medium" size:18];
    self.titleLb.textColor = HEX_COLOR(0x0C0B0B);
    
    self.subTitleLb.font = [UIFont fontWithName:@"PingFang-SC-Regular" size:14];
    self.subTitleLb.textColor = HEX_COLOR(0x0C0B0B);
    
    self.rightIncoderV.image = MY_IMAHE(@"资源 36");
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickSectionHeader)];
    [self addGestureRecognizer:tap];
}
- (void)clickSectionHeader{
    !self.clickSectionHeaderCallBack ? : self.clickSectionHeaderCallBack();
}
- (void)setDataForView:(id)data{
    self.titleLb.text = @"购物";
    self.subTitleLb.text = @"服饰、超市等";
    
}



- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_right).offset(ScreenScale(10));
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.rightIncoderV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-10));
        make.width.mas_equalTo(ScreenScale(7));
        make.height.mas_equalTo(ScreenScale(11));
    }];
    
}





@end
