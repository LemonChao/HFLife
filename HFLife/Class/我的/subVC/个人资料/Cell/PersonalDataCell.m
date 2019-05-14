//
//  PersonalDataCell.m
//  HanPay
//
//  Created by mac on 2019/1/18.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "PersonalDataCell.h"

@implementation PersonalDataCell
{
    UILabel *titleLabel;
    
    UILabel *subtitleLabel ;
    
    UIImageView *iconImageView;
    
    UIImageView *arrowImageView;
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
    self.contentView.backgroundColor = [UIColor whiteColor];
    titleLabel = [UILabel new];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(20));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(HeightRatio(30));
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    subtitleLabel = [UILabel new];
    subtitleLabel.textColor = HEX_COLOR(0x989898);
    subtitleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [self.contentView addSubview:subtitleLabel];
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(64));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(HeightRatio(30));
    }];
    
    iconImageView = [UIImageView new];
    [self.contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(70));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.height.mas_equalTo(WidthRatio(90));
    }];
    MMViewBorderRadius(iconImageView, WidthRatio(90)/2, 0, [UIColor clearColor]);
    
    arrowImageView = [UIImageView new];
    arrowImageView.image = MMGetImage(@"gengduo");
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(25));
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.width.mas_equalTo(WidthRatio(13));
        make.height.mas_equalTo(HeightRatio(21));
    }];
    
    UILabel *lin = [UILabel new];
//    lin.backgroundColor = HEX_COLOR(0xebebeb);
    [self.contentView addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(3));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    titleLabel.text = _titleString;
}
-(void)setSubtitleString:(NSString *)subtitleString{
    _subtitleString = subtitleString;
    iconImageView.hidden = YES;
    subtitleLabel.hidden = NO;
    subtitleLabel.text = [NSString isNOTNull:_subtitleString]?@"":_subtitleString;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    iconImageView.hidden = NO;
    subtitleLabel.hidden = YES;
    [iconImageView sd_setImageWithURL:[NSURL URLWithString:_imageName] placeholderImage:MMGetImage(@"user__easyico")];
}
-(void)setIsArrowHiden:(BOOL)isArrowHiden{
    _isArrowHiden = isArrowHiden;
    arrowImageView.hidden = _isArrowHiden;
}
-(void)setImage:(UIImage *)image{
    _image = image;
    iconImageView.hidden = NO;
    subtitleLabel.hidden = YES;
    iconImageView.image = _image;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
