//
//  BalanceListCell.m
//  HFLife
//
//  Created by sxf on 2019/4/16.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "BalanceListCell.h"

@interface BalanceListCell ()
@end


@implementation BalanceListCell
{
    UIImageView *_iconImageView;
    
    UILabel *_titleLabel;
    
    UILabel *_typeLabel;
    
    UILabel *_timerLabel;
    
    UILabel *_priceLabel;
    
    UILabel *_payTypeLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self inintWithUI];
    }
    return self;
}
-(void)inintWithUI{
    _iconImageView = [UIImageView new];
//    _iconImageView.backgroundColor = MMRandomColor;
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(20));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(31));
        make.width.height.mas_equalTo(WidthRatio(51));
    }];
    MMViewBorderRadius(_iconImageView, WidthRatio(51)/2, 0, [UIColor clearColor]);
    
    _titleLabel = [UILabel new];
    _titleLabel.textColor = HEX_COLOR(0x333333);
    _titleLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(31));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(32));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _typeLabel = [UILabel new];
    _typeLabel.textColor = HEX_COLOR(0x333333);
    _typeLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self.contentView addSubview:_typeLabel];
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(31));
        make.top.mas_equalTo(self->_titleLabel.mas_bottom).offset(HeightRatio(19));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    
    _timerLabel = [UILabel new];
    _timerLabel.textColor = HEX_COLOR(0x999999);
    _timerLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [self.contentView addSubview:_timerLabel];
    [_timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(31));
        make.top.mas_equalTo(self->_typeLabel.mas_bottom).offset(HeightRatio(19));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _priceLabel = [UILabel new];
    _priceLabel.textColor = HEX_COLOR(0x333333);
    _priceLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_priceLabel];
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(23));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(31));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _payTypeLabel = [UILabel new];
    _payTypeLabel.textColor = HEX_COLOR(0x333333);
    _payTypeLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    _payTypeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_payTypeLabel];
    [_payTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(23));
        make.top.mas_equalTo(self->_priceLabel.mas_bottom).offset(HeightRatio(17));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
}


-(void)setTypeString:(NSString *)typeString{
    _typeString = typeString;
    _typeLabel.text = [NSString judgeNullReturnString:_typeString];
}

-(void)setIconImage:(NSString *)iconImage{
    _iconImage = iconImage;
    if (![NSString isNOTNull:_iconImage]) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_iconImage] placeholderImage:MMGetImage(@"barCode_icon")];
    }
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _titleLabel.text = [NSString judgeNullReturnString:_title];
}

-(void)setTimer:(NSString *)timer{
    _timer = timer;
    _timerLabel.text = [NSString judgeNullReturnString:_timer];
}

-(void)setPrice:(NSString *)price{
    _price = price;
    _priceLabel.text = [NSString judgeNullReturnString:_price];
    if([_price containsString:@"+"]) {
        _priceLabel.textColor = HEX_COLOR(0xEA4B2C);
    }else{
        _priceLabel.textColor = HEX_COLOR(0x333333);
    }
}

-(void)setPayType:(NSString *)payType{
    _payType = payType;
    _payTypeLabel.text = [NSString judgeNullReturnString:_payType];
}
-(void)setIsPayclose:(BOOL)isPayclose{
    _isPayclose = isPayclose;
    if (_isPayclose) {
       _payTypeLabel.textColor = HEX_COLOR(0xEA4B2C);
    }else{
        _payTypeLabel.textColor = HEX_COLOR(0x999999);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
