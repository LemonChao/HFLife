//
//  BillDetailsCell.m
//  HFLife
//
//  Created by sxf on 2019/4/17.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "BillDetailsCell.h"

@implementation BillDetailsCell
{
    UILabel *couponCodeLabel;
    UIImageView *iconImageView;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    iconImageView = [UIImageView new];
    [self.contentView addSubview:iconImageView];
    
    
    
    couponCodeLabel = [UILabel new];
    couponCodeLabel.textAlignment = NSTextAlignmentCenter;
    couponCodeLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    couponCodeLabel.textColor = [UIColor blackColor];
    couponCodeLabel.text = @"15432684545413976510";
    [self.contentView addSubview:couponCodeLabel];
    
    
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, HeightRatio(25), self.textLabel.width, self.textLabel.height);
    self.textLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.textLabel.textColor = HEX_COLOR(0x999999);
    
    self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, HeightRatio(25), self.detailTextLabel.width, self.detailTextLabel.height);
    self.detailTextLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    self.detailTextLabel.textColor = [UIColor blackColor];

    iconImageView.backgroundColor = [UIColor yellowColor];
   	iconImageView.sd_layout
    .centerXEqualToView(self.contentView)
    .topSpaceToView(self.contentView, HeightRatio(100))
    .widthIs(WidthRatio(272))
    .heightIs(HeightRatio(120));
    
    couponCodeLabel.sd_layout
    .topSpaceToView(self.contentView, HeightRatio(100) + HeightRatio(9)+HeightRatio(120))
    .centerXEqualToView(self.contentView)
    .heightIs(HeightRatio(24))
    .widthIs(SCREEN_WIDTH);
//    [couponCodeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
////        make.centerX.mas_equalTo(self.contentView.mas_centerX);
//        make.left.right.mas_equalTo(self.contentView);
//        make.top.mas_equalTo(self.imageView.mas_bottom).offset(HeightRatio(9));
////        make.width.mas_greaterThanOrEqualTo(WidthRatio(272));
//        make.height.mas_greaterThanOrEqualTo(1);
//    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
