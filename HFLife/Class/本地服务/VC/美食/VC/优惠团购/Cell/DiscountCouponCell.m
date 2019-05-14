//
//  DiscountCouponCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "DiscountCouponCell.h"

@implementation DiscountCouponCell
{
//    店铺
    UILabel *merchantsLabel;
//    距离
    UILabel *distanceLabel;
    //    商品图片
    UIImageView *icoImageView;
    //    商品名称
    UILabel *titleLabel;
    //    介绍
    UILabel *introduceLabel;
	//    时间
    UILabel *timeLabel;
	//    现价
    UILabel *presentPriceLabel;
	//    原价
    UILabel *originalPriceLabel;
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
    UIImageView *imageView = [UIImageView new];
    imageView.image = MMGetImage(@"dianpu");
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(29));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(31));
        make.width.height.mas_equalTo(WidthRatio(22));
    }];
    merchantsLabel = [UILabel new];
    merchantsLabel.textColor = HEX_COLOR(0x666666);
    merchantsLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [self.contentView addSubview:merchantsLabel];
    [merchantsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(WidthRatio(15));
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(72));
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.height.mas_equalTo(HeightRatio(22));
    }];
    
    distanceLabel = [UILabel new];
    distanceLabel.textColor = HEX_COLOR(0x999999);
    distanceLabel.textAlignment = NSTextAlignmentRight;
    distanceLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(imageView.mas_right).offset(WidthRatio(15));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(26));
        make.width.mas_equalTo(100);
        make.centerY.mas_equalTo(imageView.mas_centerY);
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    icoImageView = [UIImageView new];
    icoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:icoImageView];
    [icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->merchantsLabel.mas_bottom).offset(HeightRatio(21));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(29));
        make.width.mas_equalTo(WidthRatio(182));
        make.height.mas_equalTo(HeightRatio(176));
    }];
    MMViewBorderRadius(icoImageView, WidthRatio(10), 0, [UIColor clearColor]);
    
    titleLabel = [UILabel new];
    titleLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(25));
        make.top.mas_equalTo(self->icoImageView.mas_top).offset(HeightRatio(8));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(72));
        make.height.mas_equalTo(HeightRatio(30));
    }];
    
    
    introduceLabel = [UILabel new];
    introduceLabel.text = @"";
    introduceLabel.textColor = HEX_COLOR(0x333333);
    introduceLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [self.contentView addSubview:introduceLabel];
    [introduceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(25));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(72));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(23));
        make.height.mas_equalTo(HeightRatio(22));
    }];
    
    timeLabel = [UILabel new];
    timeLabel.text = @"";
    timeLabel.textColor = HEX_COLOR(0x666666);
    timeLabel.font = [UIFont systemFontOfSize:WidthRatio(18)];
    [self.contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(25));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(72));
        make.top.mas_equalTo(self->introduceLabel.mas_bottom).offset(HeightRatio(25));
        make.height.mas_equalTo(HeightRatio(18));
    }];
    
    presentPriceLabel = [UILabel new];
    presentPriceLabel.text = @"";
    presentPriceLabel.textColor = HEX_COLOR(0xFD2424);
    presentPriceLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [self.contentView addSubview:presentPriceLabel];
    [presentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(25));
//        make.width.mas_equalTo(WidthRatio(78));
        make.width.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(self->timeLabel.mas_bottom).offset(HeightRatio(25));
        make.height.mas_equalTo(HeightRatio(30));
    }];
    
    originalPriceLabel =  [UILabel new];
    originalPriceLabel.text = @"";
    originalPriceLabel.textColor = HEX_COLOR(0x666666);
    originalPriceLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:originalPriceLabel];
    [originalPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->presentPriceLabel.mas_right).offset(WidthRatio(15));
        make.width.mas_equalTo(WidthRatio(78));
//        make.centerY.mas_equalTo(self->presentPriceLabel.mas_centerY);
        make.height.mas_equalTo(HeightRatio(20));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-HeightRatio(15));
    }];
}
-(void)setMerchants:(NSString *)merchants{
    _merchants = merchants;
    merchantsLabel.text = _merchants;
}
-(void)setDistance:(NSString *)distance{
    _distance = distance;
    distanceLabel.text = _distance;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    titleLabel.text = _title;
}
-(void)setIntroduce:(NSString *)introduce{
    _introduce = introduce;
    introduceLabel.text = _introduce;
}
-(void)setTime:(NSString *)time{
    _time = time;
    timeLabel.text = time;
}
-(void)setPresentPrice:(NSString *)presentPrice{
    _presentPrice = presentPrice;
    presentPriceLabel.text = _presentPrice;
//    [presentPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(25));
//        make.top.mas_equalTo(self->timeLabel.mas_bottom).offset(HeightRatio(25));
//        make.height.mas_equalTo(HeightRatio(30));
////        make.width.mas_equalTo(WidthRatio(100));
//        make.width.mas_greaterThanOrEqualTo(1);
//    }];
}
-(void)setOriginalPrice:(NSString *)originalPrice{
    _originalPrice = originalPrice;
    originalPriceLabel.text = _originalPrice;
    NSDictionary *attrDic = @{
                               NSStrikethroughStyleAttributeName: @(1),
                        	NSBaselineOffsetAttributeName : @(NSUnderlineStyleSingle)
                              };
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:originalPriceLabel.text attributes:attrDic];
    originalPriceLabel.attributedText = attrStr;
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    icoImageView.image = MMGetImage(imageName);
    [icoImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:MMGetImage(@"pingpai")];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
