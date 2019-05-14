//
//  NewStoresCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/15.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NewStoresCell.h"
#import "YYStarView.h"
@implementation NewStoresCell
{
        //    商品图片
    UIImageView *icoImageView;
        //    商品名称
    UILabel *titleLabel;
        //    星级
    YYStarView *starView;
        //    销售
    UILabel *priceLabel;
        //    地址
    UILabel *addressLabel;
        //人气
    UILabel *popularityLabel;
	//距离
    UILabel *distanceLabel;
    //优惠
    UILabel *preferentialLabel;
    
    UILabel *_la;//团
    UILabel *_lb;//券
    
    
    UILabel *_couponLb;//代金券标签
    UILabel *_food_cateLb;//团购标签
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initWithUI];
//        self.contentView.backgroundColor = MMRandomColor;
    }
    return self;
}
-(void)initWithUI{
    
    
    icoImageView = [UIImageView new];
    icoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:icoImageView];
    [icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(40));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(26));
        make.width.height.mas_equalTo(WidthRatio(150));
    }];
    MMViewBorderRadius(icoImageView, WidthRatio(10), 0, [UIColor clearColor]);
    
    titleLabel = [UILabel new];
    titleLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(23));
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(43));
        make.right.mas_equalTo(self.contentView.mas_right).offset(WidthRatio(26));
        make.height.mas_equalTo(HeightRatio(25));
    }];
    
    starView = [YYStarView new];
    starView.type = StarViewTypeShow;
    starView.starSize = CGSizeMake(WidthRatio(22), WidthRatio(22));
    starView.starSpacing = WidthRatio(10);
    starView.starCount = 5;
    [self.contentView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(23));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(15));
    }];
    
//    UILabel *lin = [UILabel new];
//    lin.backgroundColor = HEX_COLOR(0x656565);
//    [self.contentView addSubview:lin];
//    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->starView.mas_right).offset(WidthRatio(18));
//        make.centerY.mas_equalTo(self->starView.mas_centerY);
//        make.width.mas_equalTo(WidthRatio(3));
//        make.height.mas_equalTo(HeightRatio(18));
//    }];
    
    priceLabel = [UILabel new];
    priceLabel.text = @"";
    priceLabel.textColor = HEX_COLOR(0x949494);
    priceLabel.font = [UIFont systemFontOfSize:WidthRatio(16)];
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->starView.mas_right).offset(WidthRatio(10));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(26));
        make.centerY.mas_equalTo(self->starView.mas_centerY);
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    addressLabel = [UILabel new];
    addressLabel.textColor = HEX_COLOR(0x666666);
    addressLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:addressLabel];
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.top.mas_equalTo(self->starView.mas_bottom).offset(HeightRatio(20));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(170));
        make.height.mas_equalTo(HeightRatio(20));
    }];

    UILabel  *la  = [UILabel new];
    la.text  = @"团"	;
    la.font = [UIFont systemFontOfSize:WidthRatio(18)];
    la.textColor = [UIColor whiteColor];
    la.textAlignment = NSTextAlignmentCenter;
    la.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:la];
    MMViewBorderRadius(la, WidthRatio(5), 0, [UIColor clearColor]);
    [la mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.top.mas_equalTo(self->addressLabel.mas_bottom).offset(HeightRatio(22));
        make.width.height.mas_equalTo(WidthRatio(20));
    }];
    _la = la;
    
    
    
    
    preferentialLabel = [UILabel new];
    preferentialLabel.textColor = HEX_COLOR(0x737373);
    preferentialLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:preferentialLabel];
    [preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(la.mas_right).offset(WidthRatio(18));
        make.centerY.mas_equalTo(la.mas_centerY);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(100));
    }];
    
    
    distanceLabel = [UILabel new];
    distanceLabel.textColor = HEX_COLOR(0x666666);
    distanceLabel.textAlignment = NSTextAlignmentRight;
    distanceLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:distanceLabel];
    [distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(37));
        make.centerY.mas_equalTo(self->addressLabel.mas_centerY);
        make.width.mas_equalTo(WidthRatio(150));
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    popularityLabel  = [UILabel new];
    popularityLabel.textColor = HEX_COLOR(0xF1621C);
    popularityLabel.textAlignment = NSTextAlignmentRight;
    popularityLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:popularityLabel];
    [popularityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(37));
        make.centerY.mas_equalTo(self->starView.mas_centerY);
        make.width.mas_equalTo(WidthRatio(150));
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
    UILabel *cross_lin = [UILabel new];
    cross_lin.backgroundColor = HEX_COLOR(0xebebeb);
    [self.contentView addSubview:cross_lin];
    [cross_lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.right.mas_equalTo(self.contentView.mas_right).offset(WidthRatio(29));
        make.height.mas_equalTo(HeightRatio(3));
    }];
    
    
    
    
    
    
    //券
    _lb =             [UILabel new];
    _couponLb =       [UILabel new];
    _food_cateLb =    [UILabel new];
    [self.contentView addSubview:_lb];
    [self.contentView addSubview:_couponLb];
    [self.contentView addSubview:_food_cateLb];
    _couponLb.textColor = _food_cateLb.textColor = HEX_COLOR(0x666666);
    _couponLb.font = _food_cateLb.font = [UIFont systemFontOfSize:WidthRatio(20)];
    
//    _lb.text = @"券";
//    _lb.textColor = [UIColor whiteColor];
//    _lb.backgroundColor = [UIColor colorWithRed:48 / 255.0 green:217 / 255.0 blue:177 / 255.0 alpha:1.0];
//    _lb.font = [UIFont systemFontOfSize:WidthRatio(18)];
//    _lb.textColor = [UIColor whiteColor];
//    _lb.textAlignment = NSTextAlignmentCenter;
//    MMViewBorderRadius(_lb, WidthRatio(5), 0, [UIColor clearColor]);
//
//    [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(la.mas_bottom).offset(5);
//        make.left.mas_equalTo(la.mas_left);
//        make.width.height.mas_equalTo(WidthRatio(26));
//    }];
    
    _lb.text  = @"券";
    _lb.font = [UIFont systemFontOfSize:WidthRatio(18)];
    _lb.textColor = [UIColor whiteColor];
    _lb.textAlignment = NSTextAlignmentCenter;
    _lb.backgroundColor = [UIColor colorWithRed:48 / 255.0 green:217 / 255.0 blue:177 / 255.0 alpha:1.0];;
    MMViewBorderRadius(_lb, WidthRatio(5), 0, [UIColor clearColor]);
    [_lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(la.mas_bottom).offset(5);
        make.left.mas_equalTo(la.mas_left);
        make.width.height.mas_equalTo(WidthRatio(20));
    }];
    
    
    
    
    
    
    
    
    
    
    [_couponLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(la.mas_right).offset(5);
        make.centerY.mas_equalTo(la.mas_centerY);
        make.right.mas_equalTo(self->distanceLabel.mas_right);
    }];
    
    [_food_cateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->_lb.mas_right).offset(5);
        make.centerY.mas_equalTo(self->_lb.mas_centerY);
        make.right.mas_equalTo(self->_couponLb.mas_right);
    }];
    
}




- (void)setDataSource:(NSDictionary *)dataSource{
    _dataSource = dataSource;
    NSArray *food_cateArr = dataSource[@"food_cate"];
    NSArray *couponArr = dataSource[@"coupon"];
    
    //取前两个
    if (food_cateArr.count > 2) {
        food_cateArr = [food_cateArr subarrayWithRange:NSMakeRange(0, 2)];
    }
    if (couponArr.count > 2) {
        couponArr = [couponArr subarrayWithRange:NSMakeRange(0, 2)];
    }
    
    
    NSString *couponStr = [couponArr componentsJoinedByString:@" "];
    NSString *food_cateStr = [food_cateArr componentsJoinedByString:@" "];
    NSMutableArray *viewArray = [NSMutableArray array];
    UIView *bottomView = nil;
    if (![NSString isNOTNull:couponStr]) {
        _couponLb.hidden = NO;
        _la.hidden = NO;
        _couponLb.text = couponStr;
        [viewArray addObject:_couponLb];
        [_lb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self->_la.mas_bottom).offset(5);
            make.left.mas_equalTo(self->_la.mas_left);
            make.width.height.mas_equalTo(WidthRatio(20));
        }];
        bottomView = _couponLb;
    }else{
        _couponLb.hidden = YES;
        _la.hidden = YES;
        [_lb mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self->titleLabel.mas_left);
            make.top.mas_equalTo(self->addressLabel.mas_bottom).offset(HeightRatio(22));
            make.width.height.mas_equalTo(WidthRatio(20));
        }];
    }
    if (![NSString isNOTNull:food_cateStr]) {
        _food_cateLb.hidden = NO;
        _lb.hidden = NO;
        _food_cateLb.text = food_cateStr;
        [viewArray addObject:_food_cateLb];
          bottomView = _food_cateLb;
    }else{
        _food_cateLb.hidden = YES;
        _lb.hidden = YES;
    }
    [viewArray addObject:icoImageView];
    if (!bottomView) {
        bottomView = icoImageView;
    }
//    [self setupAutoHeightWithBottomViewsArray:viewArray bottomMargin:HeightRatio(10)];
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:HeightRatio(30)];
//    priceLabel.backgroundColor = [UIColor redColor];
#warning 当前人气去掉
//    popularityLabel.text = [NSString stringWithFormat:@"当前人气 %@", dataSource[@"moods"] ? dataSource[@"moods"] : @"0"];
    popularityLabel.text = @"";
    
    priceLabel.text = [NSString stringWithFormat:@"| 月销量 %@", dataSource[@"month_num"] ? dataSource[@"month_num"] : @""];
    
    
    addressLabel.text = MMNSStringFormat(@"%@",dataSource[@"address"] ?dataSource[@"address"] : @"");
    
}





-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
//    icoImageView.image = MMGetImage(_imageName);
    [icoImageView sd_setImageWithURL:[NSURL URLWithString:_imageName] placeholderImage:MMGetImage(@"")];
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    titleLabel.text = titleString;
}
-(void)setStarCount:(NSInteger)starCount{
    _starCount = starCount;
    starView.starCount = _starCount;
}
-(void)setStar_level:(NSInteger)star_level{
    _star_level = star_level;
    starView.starScore = _star_level;
}
-(void)setPrice:(NSString *)price{
    _price = price;
    priceLabel.text = _price;
}
-(void)setAddress:(NSString *)address{
    _address =address;
    addressLabel.text = _address;
}
-(void)setPreferential:(NSString *)preferential{
    _preferential = preferential;
    preferentialLabel.text = _preferential;
}
- (void)setDistance:(NSString *)distance{
    _distance = distance;
    distanceLabel.text = distance;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
