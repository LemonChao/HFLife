//
//  PaymentMethodsCell.m
//  HFLife
//
//  Created by sxf on 2019/1/19.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "PaymentMethodsCell.h"

@implementation PaymentMethodsCell
{
    UIImageView *bgImageView;
    UILabel *accountLabel;
    UILabel *nameLabel;
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
    bgImageView = [UIImageView new];
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(13));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-HeightRatio(13));
    }];
    MMViewBorderRadius(bgImageView, WidthRatio(10), 0, [UIColor clearColor]);
    
    accountLabel = [UILabel new];
    accountLabel.textColor = [UIColor whiteColor];
    accountLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
//    accountLabel
    [self.contentView addSubview:accountLabel];
    [accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->bgImageView.mas_left).offset(WidthRatio(87));
        make.height.mas_equalTo(HeightRatio(30));
        make.bottom.mas_equalTo(self->bgImageView.mas_bottom).offset(-HeightRatio(45));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [button setTitle:@"解绑" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.contentView addSubview:button];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    MMViewBorderRadius(button, WidthRatio(10), 1, [UIColor whiteColor]);
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self->bgImageView.mas_right).offset(-WidthRatio(30));
        make.top.mas_equalTo(self->bgImageView.mas_top).offset(HeightRatio(30));
        make.height.mas_equalTo(HeightRatio(40));
        make.width.mas_equalTo(WidthRatio(90));
    }];
    
    nameLabel = [UILabel new];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->accountLabel);
        make.top.mas_equalTo(self->bgImageView.mas_top).offset(HeightRatio(30));
        make.height.mas_equalTo(HeightRatio(40));
    }];
}
-(void)buttonClick{
    if (self.unbundlingClick) {
        self.unbundlingClick(self.dataModel);
    }
}
-(void)setAccount:(NSString *)account{
    _account = account;
    if ([NSString checkCardNo:account]) {
        accountLabel.text = [_account EncodeBank];
    }else {
        accountLabel.text = [_account EncodeAlipay];
    }
    if (self.gatheringType == PaymentMethodsAlipay) {
        accountLabel.text = [_account EncodeAlipay];
    }
    if (_gatheringType == HotelReservationNone) {
        nameLabel.hidden = NO;
        nameLabel.text = [NSString getBankName:[account stringByReplacingOccurrencesOfString:@" " withString:@""]];
        
    }else {
        nameLabel.hidden = YES;
    }
    
}
-(void)setGatheringType:(PaymentMethodsType)gatheringType{
    _gatheringType = gatheringType;
    bgImageView.image = MMGetImage(MMNSStringFormat(@"paymentTerm_%ld",(long)_gatheringType));
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
