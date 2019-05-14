//
//  NearFoodListCell.m
//  HanPay
//
//  Created by 张海彬 on 2019/1/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "NearFoodListCell.h"
#import "YYStarView.h"
@implementation NearFoodListCell
{
        //    商品图片
    UIImageView *icoImageView;
        //    商品名称
    UILabel *titleLabel;
        //    配送
    UILabel *distributionLabel;
        //    星级
    YYStarView *starView;
    //    配送费
//    UILabel *distributionMoneyLabel;
        //    销售
    UILabel *marketLabel;
    
        //    第一个
    UILabel *preferential_label_one;
        //       第二个
    UILabel *preferential_label_two;
        //    第三个
    UILabel *preferential_label_thre;
        //    第四个
    UILabel *preferential_label_four;
    //人气
    UILabel *popularityLabel;
    //时间
    UILabel *timerLabel;
//    附近
    UILabel *nearbyLabel;
    
    NSArray *labelArray;
    // 团购Label
    UILabel *groupBuyingLabel;
    
    // 代金券Label
    UILabel *voucherLabel;
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
    
    
    icoImageView = [UIImageView new];
    icoImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:icoImageView];
    [icoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(HeightRatio(27));
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(34));
        make.width.height.mas_equalTo(WidthRatio(180));
    }];
    MMViewBorderRadius(icoImageView, WidthRatio(10), 1, HEX_COLOR(0xEAEAEA));
    
    titleLabel = [UILabel new];
    titleLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(31));
        make.top.mas_equalTo(self->icoImageView.mas_top).offset(HeightRatio(6));
        make.right.mas_equalTo(self.contentView.mas_right).offset(WidthRatio(26));
        make.height.mas_equalTo(HeightRatio(30));
    }];
    
//    distributionLabel = [UILabel new];
//    distributionLabel.text = @"起送¥20 | 配送¥4";
//    distributionLabel.textColor = HEX_COLOR(0x949494);
//    distributionLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
//    [self.contentView addSubview:distributionLabel];
//    [distributionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(34));
//        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(27));
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(29));;
//        make.height.mas_equalTo(HeightRatio(22));
//    }];
    
    starView = [YYStarView new];
    starView.type = StarViewTypeShow;
    starView.starSize = CGSizeMake(WidthRatio(22), WidthRatio(22));
    starView.starSpacing = WidthRatio(10);
//    starView.starCount = 5;
    [self.contentView addSubview:starView];
    [starView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->icoImageView.mas_right).offset(WidthRatio(34));
        make.top.mas_equalTo(self->titleLabel.mas_bottom).offset(HeightRatio(27));
    }];
    
//    UILabel *lin = [UILabel new];
//    lin.backgroundColor = HEX_COLOR(0x656565);
//    [self.contentView addSubview:lin];
//    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->distributionLabel.mas_right).offset(WidthRatio(18));
//        make.centerY.mas_equalTo(self->distributionLabel.mas_centerY);
//        make.width.mas_equalTo(WidthRatio(3));
//        make.height.mas_equalTo(HeightRatio(18));
//    }];
//
//    distributionMoneyLabel = [UILabel new];
//    distributionMoneyLabel.text = @"";
//    distributionMoneyLabel.textColor = HEX_COLOR(0x949494);
//    distributionMoneyLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
//    [self.contentView addSubview:distributionMoneyLabel];
//    [distributionMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(lin.mas_right).offset(WidthRatio(15));
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(26));
//        make.centerY.mas_equalTo(self->distributionLabel.mas_centerY);
//        make.height.mas_equalTo(HeightRatio(22));
//    }];
    
    marketLabel = [UILabel new];
    marketLabel.textColor = HEX_COLOR(0x666666);
    marketLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:marketLabel];
    [marketLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.top.mas_equalTo(self->starView.mas_bottom).offset(HeightRatio(23));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(262));
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
//    preferential_label_one = [UILabel new];
//    preferential_label_one.textColor = [UIColor redColor];
//    preferential_label_one.textAlignment = NSTextAlignmentCenter;
//    preferential_label_one.font = [UIFont systemFontOfSize:WidthRatio(20)];
//    MMViewBorderRadius(preferential_label_one, WidthRatio(5), 1, [UIColor redColor]);
//    [self.contentView addSubview:preferential_label_one];
//    [preferential_label_one mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->titleLabel.mas_left);
//        make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
//        make.width.mas_equalTo(WidthRatio(101));
//        make.height.mas_equalTo(HeightRatio(26));
//    }];
//
//    preferential_label_two = [UILabel new];
//    preferential_label_two.textColor = [UIColor redColor];
//    preferential_label_two.textAlignment = NSTextAlignmentCenter;
//    preferential_label_two.font = [UIFont systemFontOfSize:WidthRatio(20)];
//    [self.contentView addSubview:preferential_label_two];
//    MMViewBorderRadius(preferential_label_two, WidthRatio(5), 1, [UIColor redColor]);
//    [preferential_label_two mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->preferential_label_one.mas_right).offset(WidthRatio(14));
//        make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
//        make.width.mas_equalTo(WidthRatio(101));
//        make.height.mas_equalTo(HeightRatio(26));
//    }];
//
//    preferential_label_thre = [UILabel new];
//    preferential_label_thre.textColor = [UIColor redColor];
//    preferential_label_thre.textAlignment = NSTextAlignmentCenter;
//    preferential_label_thre.font = [UIFont systemFontOfSize:WidthRatio(20)];
//    [self.contentView addSubview:preferential_label_thre];
//    MMViewBorderRadius(preferential_label_thre, WidthRatio(5), 1, [UIColor redColor]);
//    [preferential_label_thre mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->preferential_label_two.mas_right).offset(WidthRatio(14));
//        make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
//        make.width.mas_equalTo(WidthRatio(101));
//        make.height.mas_equalTo(HeightRatio(26));
//    }];
//
//    preferential_label_four = [UILabel new];
//    preferential_label_four.textColor = [UIColor redColor];
//    preferential_label_four.textAlignment = NSTextAlignmentCenter;
//    preferential_label_four.font = [UIFont systemFontOfSize:WidthRatio(20)];
//    [self.contentView addSubview:preferential_label_four];
//    MMViewBorderRadius(preferential_label_four, WidthRatio(5), 1, [UIColor redColor]);
//    [preferential_label_four mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->preferential_label_thre.mas_right).offset(WidthRatio(14));
//        make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
//        make.width.mas_equalTo(WidthRatio(101));
//        make.height.mas_equalTo(HeightRatio(26));
//    }];
//
//
    popularityLabel = [UILabel new];
    popularityLabel.textColor = HEX_COLOR(0xF1621C);
    popularityLabel.textAlignment = NSTextAlignmentRight;
    popularityLabel.font = [UIFont systemFontOfSize:WidthRatio(22)];
    [self.contentView addSubview:popularityLabel];
    [popularityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(29));
        make.centerY.mas_equalTo(self->starView.mas_centerY);
        make.width.mas_equalTo(WidthRatio(150));
        make.height.mas_equalTo(HeightRatio(22));
    }];
    
//    priceLabel = [UILabel new];
//    priceLabel.textColor = HEX_COLOR(0x666666);
//    priceLabel.textAlignment = NSTextAlignmentRight;
//    priceLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
//    [self.contentView addSubview:priceLabel];
//    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(37));
//        make.centerY.mas_equalTo(self.contentView.mas_centerY);
//        make.width.mas_equalTo(WidthRatio(150));
//        make.height.mas_equalTo(HeightRatio(20));
//    }];
    
    timerLabel =  [UILabel new];
    timerLabel.textColor = HEX_COLOR(0x666666);
    timerLabel.textAlignment = NSTextAlignmentRight;
    timerLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:timerLabel];
    [timerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(29));
        make.centerY.mas_equalTo(self->marketLabel.mas_centerY);
        make.width.mas_equalTo(WidthRatio(150));
        make.height.mas_equalTo(HeightRatio(20));
    }];
    
//    UILabel *cross_lin = [UILabel new];
//    cross_lin.backgroundColor = HEX_COLOR(0xebebeb);
//    [self.contentView addSubview:cross_lin];
//    [cross_lin mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-HeightRatio(78));
//        make.left.mas_equalTo(self->titleLabel.mas_left);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(WidthRatio(29));
//        make.height.mas_equalTo(HeightRatio(1));
//    }];
    
//    nearbyLabel =  [UILabel new];
//    nearbyLabel.textColor = HEX_COLOR(0x666666);
//    nearbyLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
//    [self.contentView addSubview:nearbyLabel];
//    [nearbyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self->titleLabel.mas_left);
//        make.top.mas_equalTo(cross_lin.mas_bottom).offset(HeightRatio(19));
//        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(29));
//        make.height.mas_equalTo(HeightRatio(20));
//    }];
    
  	
    groupBuyingLabel = [UILabel new];
//    groupBuyingLabel.backgroundColor = [UIColor yellowColor];
    groupBuyingLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:groupBuyingLabel];
    [groupBuyingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
        make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(26));
    }];

    voucherLabel = [UILabel new];
//    voucherLabel.backgroundColor = [UIColor yellowColor];
    voucherLabel.font = [UIFont systemFontOfSize:WidthRatio(20)];
    [self.contentView addSubview:voucherLabel];
    [voucherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->titleLabel.mas_left);
//        make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
        make.top.mas_equalTo(self->groupBuyingLabel.mas_bottom).offset(HeightRatio(15));
        make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(26));
    }];
    
    
//    UILabel *cross_lin1 = [UILabel new];
//    cross_lin1.backgroundColor = HEX_COLOR(0xebebeb);
//    [self.contentView addSubview:cross_lin1];
//    [cross_lin1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-HeightRatio(18));
//        make.left.mas_equalTo(self->titleLabel.mas_left);
//        make.right.mas_equalTo(self.contentView.mas_right).offset(WidthRatio(29));
////        make.height.mas_equalTo(HeightRatio(1));
//
//    }];
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xebebeb);
    [self.contentView addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(34));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.right.mas_equalTo(self.contentView.mas_right);
        make.height.mas_equalTo(HeightRatio(2));
    }];
//    labelArray = @[preferential_label_one,preferential_label_two,preferential_label_thre,preferential_label_four];
//     [self setupAutoHeightWithBottomViewsArray:@[groupBuyingLabel,voucherLabel] bottomMargin:HeightRatio(25)];
}
-(void)setDataDict:(NSDictionary *)dataDict{
    _dataDict = dataDict;
    self.imageName = _dataDict[@"photo"] ? _dataDict[@"photo"] : @"";
    self.titleString = _dataDict[@"food_name"] ? _dataDict[@"food_name"] : @"";
    self.star_level = 4;
    self.salesString = MMNSStringFormat(@"月售%@",_dataDict[@"month_num"] ? _dataDict[@"month_num"] : @"0") ;
    self.sentiment = MMNSStringFormat(@"%@",_dataDict[@"moods"] ? _dataDict[@"moods"] : @"");
    self.timeDistance = MMNSStringFormat(@"%@",_dataDict[@"distance"] ? _dataDict[@"distance"]: @"" );
    if ( [_dataDict[@"coupon"] isKindOfClass:[NSArray class]]) {
        self.preferentialArray = _dataDict[@"coupon"];
    }
   
    NSArray *couponArray = _dataDict[@"food_cate"];
    if ([couponArray isKindOfClass:[NSArray class]]&&couponArray.count>0	) {
        groupBuyingLabel.hidden = NO;
        NSString *str = @"";
        for (NSString *content in couponArray) {
            str = MMNSStringFormat(@"%@ %@",str,content);
        }
        NSMutableAttributedString *attri =    [[NSMutableAttributedString alloc] initWithString:str];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];attch.image = [UIImage imageNamed:@"dumpling"];attch.bounds = CGRectMake(0, 0, 14.5, HeightRatio(26));
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:0];
        groupBuyingLabel.attributedText = attri;
    }else{
        groupBuyingLabel.hidden = YES;
    }
    NSArray *ticketArray = _dataDict[@"coupon"];
    if ([ticketArray isKindOfClass:[NSArray class]]&&ticketArray.count>0) {
        voucherLabel.hidden = NO;
        NSString *str = @"";
        for (NSString *content in ticketArray) {
            str = MMNSStringFormat(@"%@ %@",str,content);
        }
        NSMutableAttributedString *attri =    [[NSMutableAttributedString alloc] initWithString:str];
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];attch.image = [UIImage imageNamed:@"ticket"];attch.bounds = CGRectMake(0, 0, 14.5, HeightRatio(26));
        NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
        [attri insertAttributedString:string atIndex:0];
        voucherLabel.attributedText = attri;
        if (groupBuyingLabel.hidden) {
            [voucherLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self->titleLabel.mas_left);
                make.top.mas_equalTo(self->marketLabel.mas_bottom).offset(HeightRatio(26));
                make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
                make.height.mas_equalTo(HeightRatio(26));
            }];
        }else{
            [voucherLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self->titleLabel.mas_left);
                make.top.mas_equalTo(self->groupBuyingLabel.mas_bottom).offset(HeightRatio(15));
                make.right.mas_equalTo(self.contentView.mas_right).offset(-WidthRatio(20));
                make.height.mas_equalTo(HeightRatio(26));
            }];
        }
    
    }else{
        voucherLabel.hidden = YES;
    }
//    [self setupAutoHeightWithBottomViewsArray:@[icoImageView,groupBuyingLabel,voucherLabel] bottomMargin:0];
}
-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
//    icoImageView.image = MMGetImage(_imageName);
    [icoImageView sd_setImageWithURL:[NSURL URLWithString:imageName] placeholderImage:MMGetImage(@"pingpai")];
}
-(void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    titleLabel.text = titleString;
}
-(void)setUpToSend:(NSString *)upToSend{
    _upToSend = upToSend;
    distributionLabel.text = MMNSStringFormat(@"起送¥%@ | 配送¥%@",_upToSend?_upToSend:@"",_distributionMoney?_distributionMoney:@"");
//    distributionLabel.text = MMNSStringFormat(@"起送%@",_upToSend);
}
-(void)setDistributionMoney:(NSString *)distributionMoney{
    _distributionMoney = distributionMoney;
//    distributionMoneyLabel.text = MMNSStringFormat(@"配送%@",_distributionMoney);
    distributionLabel.text = MMNSStringFormat(@"起送¥%@ | 配送¥%@",_upToSend?_upToSend:@"",_distributionMoney?_distributionMoney:@"");
}
-(void)setStar_level:(NSInteger)star_level{
    _star_level = star_level;
    starView.starScore = _star_level;
}
-(void)setSentiment:(NSString *)sentiment{
    _sentiment = sentiment;
    popularityLabel.text = MMNSStringFormat(@"当前人气 %@",_sentiment);
}
-(void)setTimeDistance:(NSString *)timeDistance{
    _timeDistance = timeDistance;
    timerLabel.text = _timeDistance;
}
-(void)setNear:(NSString *)near{
    _near = near;
    nearbyLabel.text = _near;
}
-(void)setSalesString:(NSString *)salesString{
    _salesString = salesString;
    marketLabel.text = _salesString;
}
-(void)setPreferentialArray:(NSArray *)preferentialArray{
    _preferentialArray = preferentialArray;
    for (int i =0; i<labelArray.count; i++ ) {
        UILabel *la = labelArray[i];
        if (i<_preferentialArray.count) {
            la.hidden = NO;
            la.text =_preferentialArray[i];
        }else{
            la.hidden = YES;
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
