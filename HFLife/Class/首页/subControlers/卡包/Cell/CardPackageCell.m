//
//  CardPackageCell.m
//  HFLife
//
//  Created by sxf on 2019/1/22.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "CardPackageCell.h"

@implementation CardPackageCell
{
    UIImageView *bgImageView;
    
    UILabel *titleLabel ;
    
    UILabel *explainLabel;
    
    UILabel *contentLabel;
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
//    bgImageView.backgroundColor = MMRandomColor;
    [self.contentView addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(20));
    }];
    MMViewBorderRadius(bgImageView, WidthRatio(10), 0, [UIColor clearColor]);
    
    titleLabel = [UILabel new];
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(36)];
    titleLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(53));
        make.top.mas_equalTo(self->bgImageView.mas_top).offset(HeightRatio(25));
        make.height.mas_equalTo(HeightRatio(36));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(53));;
    }];
    
    explainLabel = [UILabel new];
    explainLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    explainLabel.textColor = [UIColor whiteColor];
    explainLabel.alpha = 0.8;
    [self.contentView addSubview:explainLabel];
    [explainLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(19));
        make.height.mas_equalTo(HeightRatio(22));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(53));;
    }];

    contentLabel = [UILabel new];
    contentLabel.font = [UIFont systemFontOfSize:WidthRatio(46)];
    contentLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.top.mas_equalTo(self->explainLabel.mas_bottom).offset(HeightRatio(36));
        make.height.mas_equalTo(HeightRatio(46));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(53));;
    }];
    
    
    
    
    
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    titleLabel.text = _titleString;
}
-(void)setExplainString:(NSString *)explainString{
    _explainString = explainString;
    explainLabel.text = _explainString;
}
-(void)setContentString:(NSString *)contentString{
    _contentString = contentString;
    contentLabel.text = _contentString;
}
-(void)setBgName:(NSString *)bgName{
    _bgName = bgName;
    bgImageView.image = MMGetImage(_bgName);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
