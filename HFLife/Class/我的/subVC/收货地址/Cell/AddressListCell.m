//
//  AddressListCell.m
//  HanPay
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AddressListCell.h"

@implementation AddressListCell
{
    UILabel *nameLabel;
    
    UILabel *phoneLabel;
    
    UILabel *defaultLabel;
    
    UILabel *addressLabel;
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
    nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:WidthRatio(33)];
    nameLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(30));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(23));
        make.height.mas_greaterThanOrEqualTo(HeightRatio(33));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    phoneLabel = [UILabel new];
    phoneLabel.font = [UIFont systemFontOfSize:WidthRatio(21)];
    phoneLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:phoneLabel];
    [phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->nameLabel.mas_right).offset(WidthRatio(20));
        make.centerY.mas_equalTo(self->nameLabel.mas_centerY);
        make.height.mas_equalTo(HeightRatio(21));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    defaultLabel = [UILabel new];
    defaultLabel.text = @"默认";
    defaultLabel.textColor = HEX_COLOR(0xff824b);
    defaultLabel.textAlignment = NSTextAlignmentCenter;
    defaultLabel.backgroundColor = HEX_COLOR(0xffefe2);
    defaultLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [self.contentView addSubview:defaultLabel];
    [defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(32));
        make.top.mas_equalTo(self->nameLabel.mas_bottom).offset(HeightRatio(22));
        make.width.mas_equalTo(WidthRatio(63));
        make.height.mas_equalTo(HeightRatio(32));
    }];
    
    addressLabel = [UILabel new];
    addressLabel.font = [UIFont systemFontOfSize:WidthRatio(25)];
    addressLabel.textColor = HEX_COLOR(0x000000);
    addressLabel.numberOfLines = 2;
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(115));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(165));
        make.top.mas_equalTo(self->phoneLabel.mas_bottom).offset(HeightRatio(29));
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xe5e5e5);
    [self.contentView addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(134));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(41));
        make.height.mas_equalTo(HeightRatio(60));
        make.width.mas_equalTo(WidthRatio(3));
    }];
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [button setTitle:@"编辑" forState:(UIControlStateNormal)];
    [button setTitleColor:HEX_COLOR(0x999999) forState:(UIControlStateNormal)];
    [button setImage:MMGetImage(@"addresseditor") forState:(UIControlStateNormal)];
    [button setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(13)];
//    [button setImagePositionWithType:(SSImagePositionTypeLeft) spacing:WidthRatio(13)];
    [button addTarget:self action:@selector(editorClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lin.mas_right);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.top.mas_equalTo(lin.mas_top);
        make.bottom.mas_equalTo(lin.mas_bottom);
    }];
}
-(void)setUserName:(NSString *)userName{
    _userName = userName;
    nameLabel.text = _userName;
}
-(void)setAddress:(NSString *)address{
    _address = address;
    addressLabel.text = _address;
}
-(void)setPhone:(NSString *)phone{
    _phone = phone;
    phoneLabel.text = _phone;
}
-(void)setIsDefault:(BOOL)isDefault{
    _isDefault = !isDefault;
    defaultLabel.hidden = _isDefault;
    if (_isDefault) {
        [addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(32));
            make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(165));
            make.top.mas_equalTo(self->phoneLabel.mas_bottom).offset(HeightRatio(29));
            make.height.mas_greaterThanOrEqualTo(1);
        }];
    }else{
        [addressLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(115));
            make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(165));
            make.top.mas_equalTo(self->phoneLabel.mas_bottom).offset(HeightRatio(29));
            make.height.mas_greaterThanOrEqualTo(1);
        }];
    }
}
-(void)editorClick{
    if (self.editorBlock) {
        self.editorBlock();
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
