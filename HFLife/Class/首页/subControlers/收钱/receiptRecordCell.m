//
//  receiptRecordCell.m
//  HanPay
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "receiptRecordCell.h"

@interface receiptRecordCell()
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subTitleLb;
@property (nonatomic, strong)UILabel *getCountLb;
@property (nonatomic, strong)UILabel *totleMoneyLb;
@property (nonatomic, strong)UILabel *incoderMoneyLb;
@end





@implementation receiptRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChilrenViews];
    }
    return self;
}


- (void) addChilrenViews{
    
    self.titleLb = [UILabel new];
    self.subTitleLb = [UILabel new];
    self.getCountLb = [UILabel new];
    self.totleMoneyLb = [UILabel new];
    self.incoderMoneyLb = [UILabel new];
    
    
    [self.contentView addSubview:self.titleLb];
    [self.contentView addSubview:self.subTitleLb];
    [self.contentView addSubview:self.getCountLb];
    [self.contentView addSubview:self.totleMoneyLb];
    [self.contentView addSubview:self.incoderMoneyLb];
    
    self.titleLb.font = [UIFont systemFontOfSize:14];
    self.titleLb.textColor = HEX_COLOR(0x999999);
    
    self.getCountLb.font = [UIFont systemFontOfSize:20 weight:2];
    self.getCountLb.textColor = HEX_COLOR(0x333333);
    
    self.totleMoneyLb.font = self.getCountLb.font;
    self.totleMoneyLb.textColor = HEX_COLOR(0x333333);
    
    self.incoderMoneyLb.font = [UIFont systemFontOfSize:13 weight:2];;
    self.incoderMoneyLb.textColor = HEX_COLOR(0x333333);
    
    self.subTitleLb.font = self.titleLb.font;
    self.subTitleLb.textColor = self.titleLb.textColor;
    
   
    
}
- (void) setDataForCell:(reciveModel *) model{
    
    self.titleLb.text = @"收款笔数";
    self.subTitleLb.text = @"共计";
    self.getCountLb.text = [NSString stringWithFormat:@"%@", model.log_count ? model.log_count : @(0)];
    self.incoderMoneyLb.text = @"￥";
    self.totleMoneyLb.text = [NSString stringWithFormat:@"%@", model.log_count ? model.log_date_amount : @(0)];;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(16);
        make.left.mas_equalTo(self.contentView.mas_left).offset(16);
    }];
    
    [self.getCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-25);
    }];
    
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLb.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
    }];
    
    [self.totleMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.getCountLb.mas_centerY);
        make.right.mas_equalTo(self.subTitleLb.mas_right);
    }];
    
    [self.incoderMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.totleMoneyLb.mas_left).offset(-3);
        make.bottom.mas_equalTo(self.totleMoneyLb.mas_bottom).offset(-2);
    }];
    
}







- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
