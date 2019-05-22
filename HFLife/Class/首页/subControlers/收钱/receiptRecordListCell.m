//
//  receiptRecordListCell.m
//  HFLife
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "receiptRecordListCell.h"
@interface receiptRecordListCell()
@property (nonatomic, strong)UILabel *nameLb;
@property (nonatomic, strong)UILabel *timeLb;
@property (nonatomic, strong)UILabel *moneyLb;
@property (nonatomic, strong)UIImageView *headerImageV;
@property (nonatomic, strong)UILabel *typeLb;
@property (nonatomic, strong)UILabel *subTitleLb;
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
    self.headerImageV = [UIImageView new];
    self.typeLb = [UILabel new];
    self.subTitleLb = [UILabel new];
    
    [self.contentView addSubview:self.nameLb];
    [self.contentView addSubview:self.moneyLb];
    [self.contentView addSubview:self.timeLb];
    [self.contentView addSubview:self.headerImageV];
    [self.contentView addSubview:self.subTitleLb];
    [self.contentView addSubview:self.typeLb];
    
    self.nameLb.font = [UIFont systemFontOfSize:14];
    self.nameLb.textColor = color0C0B0B;
    self.moneyLb.font = [UIFont fontWithName:@"ArialMT" size:18];
    self.moneyLb.textColor = colorCA1400;
    self.subTitleLb.font = FONT(11);
    self.subTitleLb.textColor = color0C0B0B;
    self.timeLb.font = self.typeLb.font = FONT(11);
    self.timeLb.textColor = self.typeLb.textColor = colorAAAAAA;
    
    
    self.headerImageV.layer.cornerRadius = ScreenScale(16);
    self.headerImageV.clipsToBounds = YES;
    self.headerImageV.backgroundColor = colorAAAAAA;
}

- (void) setDataForCell:(subReciveModel *) model{
    self.nameLb.text = @"";
    if (model.pay_username.length > 0) {
        self.nameLb.text = model.pay_username;//[model.pay_username stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@"*"];
    }
    
    self.timeLb.text = model.createtime;
    self.moneyLb.text = [NSString stringWithFormat:@"%@", model.real_num ? model.real_num : @(0)];
    
    self.typeLb.text = @"银联";
    self.nameLb.text = @"小可爱";
    self.subTitleLb.text = @"其他";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.width.height.mas_equalTo(ScreenScale(36));
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(20));
    }];
    
    [self.nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(14));
        make.top.mas_equalTo(self.headerImageV.mas_top);
    }];
    
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLb.mas_left);
        make.height.mas_equalTo(ScreenScale(11));
        make.top.mas_equalTo(self.nameLb.mas_bottom).offset(8);
    }];
    
    [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.subTitleLb.mas_left);
        make.height.mas_equalTo(ScreenScale(11));
        make.top.mas_equalTo(self.subTitleLb.mas_bottom).offset(ScreenScale(8));
    }];
    
    [self.moneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.height.mas_equalTo(ScreenScale(14));
        make.centerY.mas_equalTo(self.nameLb.mas_centerY);
    }];
    
    [self.typeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.moneyLb.mas_right);
        make.height.mas_equalTo(ScreenScale(11));
        make.centerY.mas_equalTo(self.subTitleLb.mas_centerY);
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
