
//
//  friendViewCell.m
//  HanPay
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "friendViewCell.h"
@interface friendViewCell ()

@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel *nameLb;
@property (nonatomic, strong)UILabel *leveLb;
@property (nonatomic, strong)UILabel *registTimeLb;
@property (nonatomic, strong)UILabel *outMoneyLb;
@property (nonatomic, strong)UILabel *getModeyLb;

@end

@implementation friendViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    
    return self;
}



- (void) setDataForCell:(friengListModel *) friendModel{
    [self.headerImageV sd_setImageWithURL:[NSURL URLWithString:friendModel.img ? friendModel.img : @"http://www.com"]];
    self.nameLb.text = friendModel.phone ? friendModel.phone : @"";
    self.leveLb.text = [NSString stringWithFormat:@"LV:%@", friendModel.level_info[@"level_name"] ? friendModel.level_info[@"level_name"] : @""];
    self.registTimeLb.text = [NSString stringWithFormat:@"注册时间:%@", friendModel.addtime ? friendModel.addtime : @""];
    self.outMoneyLb.text = [NSString stringWithFormat:@"累计消费:￥%@", friendModel.buy_all_money ? friendModel.buy_all_money : @"0.00"];
    self.getModeyLb.text = [NSString stringWithFormat:@"贡献值:￥%@", friendModel.added_coin ? friendModel.added_coin : @"0.00"];
    self.nameLb.text = friendModel.phone ? friendModel.phone : @"";
}




- (void) addChildrenViews{
    self.headerImageV = [UIImageView new];
    self.nameLb       = [UILabel new];
    self.leveLb       = [UILabel new];
    self.registTimeLb = [UILabel new];
    self.outMoneyLb   = [UILabel new];
    self.getModeyLb   = [UILabel new];
    
    [self.contentView addSubview:self.headerImageV];
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.leveLb];
    [self.contentView addSubview:self.registTimeLb];
    [self.contentView addSubview:self.outMoneyLb];
    [self.contentView addSubview:self.getModeyLb];
    
    
    self.headerImageV.layer.cornerRadius =  WidthRatio(40);
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.clipsToBounds = YES;
    self.headerImageV.backgroundColor = HEX_COLOR(0xEEEEEE);
    

    self.nameLb.textColor = [UIColor blackColor];
    self.nameLb.font = [UIFont systemFontOfSize:WidthRatio(30)];
    
    self.leveLb.textColor = HEX_COLOR(0x999999);
    self.leveLb.font = [UIFont systemFontOfSize:WidthRatio(24)];
    
    self.registTimeLb.textColor = HEX_COLOR(0x999999);
    self.registTimeLb.font = [UIFont systemFontOfSize:WidthRatio(24)];
    
    self.outMoneyLb.textColor = HEX_COLOR(0x333333);
    self.outMoneyLb.font = [UIFont systemFontOfSize:WidthRatio(26)];
    
    self.getModeyLb.textColor = HEX_COLOR(0xFE3535);
    self.getModeyLb.font = [UIFont systemFontOfSize:WidthRatio(26)];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(28));
        make.top.mas_equalTo(self.contentView.mas_top).offset(WidthRatio(40));
        make.width.height.mas_equalTo(WidthRatio(80));
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(WidthRatio(15));
        make.top.mas_equalTo(self.headerImageV.mas_top);
    }];
    
    [self.leveLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.nameLb.mas_leading);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(WidthRatio(23));
    }];
    
    [self.registTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(self.leveLb.mas_leading);
        make.top.mas_equalTo(self.leveLb.mas_bottom).offset(WidthRatio(23));
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(WidthRatio(40));
    }];
    
    [self.outMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.nameLb.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(WidthRatio(-29));
    }];
    
    [self.getModeyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.outMoneyLb.mas_trailing);
        make.top.mas_equalTo(self.outMoneyLb.mas_bottom).offset(WidthRatio(23));
    }];
    
    
}



@end
