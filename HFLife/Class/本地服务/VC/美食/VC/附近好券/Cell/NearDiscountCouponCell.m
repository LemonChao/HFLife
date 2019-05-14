//
//  NearDiscountCouponCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearDiscountCouponCell.h"

@implementation NearDiscountCouponCell
{
    //    金额
    UILabel *moneyLabel;
//    标题
    UILabel *titleLabel;
    
    UILabel *evaluatePriceLabel;
//
    UILabel *voucherLabel;
//    距离
    UILabel *distanceLabel;
    
    UILabel *fan_priceLabel;
    
    UILabel *letLabel ;
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    UIImageView *bgImageView = [UIImageView new];
    bgImageView.image = MMGetImage(@"youhuiquan");
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(25));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(25));
    }];
    moneyLabel = [UILabel new];
    moneyLabel.textColor = [UIColor redColor];
    moneyLabel.font = [UIFont systemFontOfSize:WidthRatio(46)];
    moneyLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(40));
        make.top.bottom.mas_equalTo(bgImageView);
        make.width.mas_equalTo(WidthRatio(150));
    }];
    
    titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->moneyLabel.mas_right).offset(WidthRatio(65));
        make.right.mas_equalTo(bgImageView.mas_right).offset(-WidthRatio(131));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(27));
        make.height.mas_equalTo(HeightRatio(24));
    }];
    
    evaluatePriceLabel = [UILabel new];
    evaluatePriceLabel.textColor = HEX_COLOR(0xd2d2d2);
    evaluatePriceLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:evaluatePriceLabel];
    [evaluatePriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->moneyLabel.mas_right).offset(WidthRatio(65));
        make.right.mas_equalTo(bgImageView.mas_right);
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(17));
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    voucherLabel = [UILabel new];
    voucherLabel.textColor = [UIColor blackColor];
    voucherLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    [self.contentView addSubview:voucherLabel];
    [voucherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->moneyLabel.mas_right).offset(WidthRatio(65));
        make.right.mas_equalTo(bgImageView.mas_right);
        make.top.mas_equalTo(self->evaluatePriceLabel.mas_bottom).offset(HeightRatio(17));
        make.height.mas_equalTo(HeightRatio(23));
    }];
    
    distanceLabel = [UILabel new];
    distanceLabel.textColor = HEX_COLOR(0xd2d2d2);
    distanceLabel.textAlignment = NSTextAlignmentRight;
    distanceLabel.font = [UIFont systemFontOfSize:WidthRatio(17)];
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->titleLabel.mas_centerY);
//        make.width.mas_equalTo(WidthRatio(121));
        make.width.mas_greaterThanOrEqualTo(1);
        make.right.mas_equalTo(bgImageView.mas_right).offset(-WidthRatio(11));
        make.height.mas_equalTo(HeightRatio(18));
    }];
    UIButton *button = [UIButton new];
    button.backgroundColor = HEX_COLOR(0xfec800);
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [button setTitle:@"抢券" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:button];
    MMViewBorderRadius(button, WidthRatio(15), 0, [UIColor clearColor]);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WidthRatio(121));
        make.right.mas_equalTo(bgImageView.mas_right).offset(-WidthRatio(11));
        make.height.mas_equalTo(HeightRatio(50));
        make.bottom.mas_equalTo(bgImageView.mas_bottom).offset(-HeightRatio(28));
    }];
    
    
    
    fan_priceLabel =  [UILabel new];
    fan_priceLabel.textColor = HEX_COLOR(0x999999);
//    fan_priceLabel.text = @"111";
    fan_priceLabel.font = [UIFont systemFontOfSize:WidthRatio(17)];
//    self->distanceLabel.backgroundColor = [UIColor yellowColor];
    [bgImageView addSubview:fan_priceLabel];
    [fan_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            //        make.left.mas_equalTo(letLabel.mas_right).offset(WidthRatio(10));
            //        make.centerY.mas_equalTo(letLabel.mas_centerY);
        make.right.mas_equalTo(self->distanceLabel.mas_left).offset(-WidthRatio(10));
        make.centerY.mas_equalTo(self->distanceLabel.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    letLabel = [UILabel new];
    letLabel.text = @"让";
    letLabel.backgroundColor = HEX_COLOR(0x03e4a7);
    letLabel.textColor = [UIColor whiteColor];
    letLabel.font = [UIFont systemFontOfSize:WidthRatio(18)];
    letLabel.textAlignment = NSTextAlignmentCenter;
    [bgImageView addSubview:letLabel];
    [letLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->fan_priceLabel.mas_left).offset(-WidthRatio(10));
        make.centerY.mas_equalTo(self->fan_priceLabel.mas_centerY);
        make.width.height.mas_equalTo(WidthRatio(28));
    }];
    
    
    
}
-(void)changeLableFontColor:(UILabel *)label{
    
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:label.text];
    NSRange range = [label.text rangeOfString:@"分"];
    if (range.length > 0) {
        [attrString addAttribute:NSForegroundColorAttributeName value:HEX_COLOR(0xfcab53) range:NSMakeRange(0,range.location)];
        label.attributedText = attrString;
    }
}
-(void)setMoney:(NSString *)money{
    _money = money;
    moneyLabel.text = _money;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = title;
}
-(void)setEvaluatePrice:(NSString *)evaluatePrice{
    _evaluatePrice = evaluatePrice;
    evaluatePriceLabel.text = _evaluatePrice;
    [self changeLableFontColor:evaluatePriceLabel];
}
-(void)setVoucher:(NSString *)voucher{
    _voucher = voucher;
    voucherLabel.text = _voucher;
}
-(void)setDistance:(NSString *)distance{
    _distance = distance;
    distanceLabel.text = _distance;
}
-(void)setFan_price:(NSString *)fan_price{
    _fan_price = fan_price;
    if (![NSString isNOTNull:_fan_price]) {
        if ([_fan_price floatValue]>0) {
            letLabel.hidden = NO;
            fan_priceLabel.text = MMNSStringFormat(@"¥%@",_fan_price);
        }else{
            letLabel.hidden = YES;
            fan_priceLabel.text = @"";
        }
    }else{
        letLabel.hidden = YES;
        fan_priceLabel.text = @"";
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
