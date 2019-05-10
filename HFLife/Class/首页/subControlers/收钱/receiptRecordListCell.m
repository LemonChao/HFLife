//
//  receiptRecordListCell.m
//  HanPay
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "receiptRecordListCell.h"
@interface receiptRecordListCell()
@property (nonatomic, strong)UILabel *nameLb;
@property (nonatomic, strong)UILabel *timeLb;
@property (nonatomic, strong)UILabel *moneyLb;
@end
@implementation receiptRecordListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChilrenViews];
    }
    return self;
}

- (void) addChilrenViews{
    self.nameLb = [UILabel new];
    self.moneyLb = [UILabel new];
    self.timeLb = [UILabel new];
    
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.moneyLb];
    [self.contentView addSubview:self.timeLb];
    
    
    self.nameLb.font = [UIFont systemFontOfSize:14];
    self.nameLb.textColor = HEX_COLOR(0x333333);
    self.moneyLb.font = [UIFont systemFontOfSize:14 weight:2];
    self.moneyLb.textColor = HEX_COLOR(0x333333);
    self.nameLb.font = [UIFont systemFontOfSize:14];
    self.nameLb.textColor = HEX_COLOR(0x999999);
    
}

- (void) setDataForCell:(subReciveModel *) model{
    self.nameLb.text = @"";
    if (model.pay_username.length > 0) {
        self.nameLb.text = model.pay_username;//[model.pay_username stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    self.timeLb.text = model.createtime;
    self.moneyLb.text = [NSString stringWithFormat:@"%@", model.real_num ? model.real_num : @(0)];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(25);
        make.left.mas_equalTo(self.contentView.mas_left).offset(19);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb.mas_left);
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(10);
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-16);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
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
