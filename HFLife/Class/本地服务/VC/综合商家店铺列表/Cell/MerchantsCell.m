//
//  MerchantsCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/19.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "MerchantsCell.h"
#import "YYStarView.h"
@implementation MerchantsCell
{
    UIImageView *_iconImageView;
    
    UILabel *_titleLabel;
    
    //    星级
    YYStarView *starView;
    
    UILabel *_addreLabel;
    
    UILabel *_distanceLabel;
    
    UILabel *_percentageLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    _iconImageView = [UIImageView new];
    _iconImageView.contentMode = UIViewContentModeScaleAspectFit;
//    _iconImageView.backgroundColor = MMRandomColor;
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(11));
        make.centerY.mas_equalTo(self.contentView);//.offset(HeightRatio(25));
        make.width.height.mas_equalTo(WidthRatio(146));
    }];
    MMViewBorderRadius(_iconImageView, 10, 1, HEX_COLOR(0xeaeaea));
    
    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(24));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(52));
        make.height.mas_equalTo(HeightRatio(30));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    starView = [YYStarView new];
    starView.type = StarViewTypeShow;
    starView.starSize = CGSizeMake(WidthRatio(22), WidthRatio(22));
    starView.starSpacing = WidthRatio(10);
    starView.starCount = 5;
    [self.contentView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(23));
        make.top.mas_equalTo(self->_titleLabel.mas_bottom).offset(HeightRatio(19));
    }];
    
    UIImageView *dingweiImage = [UIImageView new];
    dingweiImage.image = MMGetImage(@"icon_dizhi");
    dingweiImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:dingweiImage];
    [dingweiImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(33));
        make.top.mas_equalTo(self->starView.mas_bottom).offset(HeightRatio(20));
        make.width.mas_equalTo(WidthRatio(21));
        make.height.mas_equalTo(HeightRatio(25));
    }];
    
    _addreLabel = [UILabel new];
    _addreLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    _addreLabel.textColor = HEX_COLOR(0x666666);
    [self.contentView addSubview:_addreLabel];
    [_addreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(dingweiImage.mas_centerY);
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(248));
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(193));
        make.width.mas_equalTo(WidthRatio(309));
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    
//    _distanceLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-WidthRatio(25)-WidthRatio(150), HeightRatio(103), WidthRatio(150), HeightRatio(20))];
    _distanceLabel = [[UILabel alloc]init];
    _distanceLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    _distanceLabel.textColor = HEX_COLOR(0x333333);
    _distanceLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_distanceLabel];
    [_distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(25));
        make.centerY.mas_equalTo(self->starView.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    UILabel *rangli = [UILabel new];
    rangli.text = @"让";
    rangli.textAlignment = NSTextAlignmentCenter;
    rangli.textColor = [UIColor whiteColor];
    rangli.backgroundColor = HEX_COLOR(0x1dc972);
    rangli.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:rangli];
    [rangli mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_iconImageView.mas_right).offset(WidthRatio(28));
        make.top.mas_equalTo(dingweiImage.mas_bottom).offset(HeightRatio(19));
        make.width.height.mas_equalTo(WidthRatio(32));
    }];
    
    UILabel *rangli_describe = [UILabel new];
    rangli_describe.text = @"让利消费金额";
    rangli_describe.font = [UIFont systemFontOfSize:WidthRatio(20)];
    rangli_describe.textColor = HEX_COLOR(0x666666);
    [self.contentView addSubview:rangli_describe];
    [rangli_describe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rangli.mas_right).offset(WidthRatio(21));
        make.centerY.mas_equalTo(rangli.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _percentageLabel = [UILabel new];
    _percentageLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    _percentageLabel.textColor = HEX_COLOR(0xFF3A3A);
    [self.contentView addSubview:_percentageLabel];
    [_percentageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(rangli_describe.mas_right);
        make.centerY.mas_equalTo(rangli_describe.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xEAEAEA);
    [self.contentView addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(195));
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(1);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}

-(void)setIconString:(NSString *)iconString{
    _iconString = iconString;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:_iconString] placeholderImage:MMGetImage(@"logo")];
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = [NSString judgeNullReturnString:_titleString];
}
-(void)setBenefit:(NSString *)benefit{
    _benefit = benefit;
    _percentageLabel.text = [NSString judgeNullReturnString:_benefit];
}
-(void)setDistance:(NSString *)distance{
    _distance = distance;
    _distanceLabel.text = _distance;
    
}
-(void)setLocation:(NSString *)location{
    _location = location;
    _addreLabel.text = _location;
}
-(void)setStar_level:(NSInteger)star_level{
    _star_level = star_level;
    starView.starScore = _star_level;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
