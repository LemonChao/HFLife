//
//  YYB_HF_guessLikeCollectionViewCell.m
//  HFLife
//
//  Created by mac on 2019/5/10.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_guessLikeCollectionViewCell.h"

@interface YYB_HF_guessLikeCollectionViewCell()
@property(nonatomic, strong) UIView *bgView;
/** 名称 */
@property(nonatomic, strong) UILabel  *nameLabel;
/** 活动 */
@property(nonatomic, strong) UILabel *adLabel;
/** k距离 */
@property(nonatomic, strong) UILabel *distanceLabel;
/** 新价格 */
@property(nonatomic, strong) UILabel *priceLabel;
/** 旧价格 */
@property(nonatomic, strong) UILabel *oldPriceLabel;
/** 让利 */
@property(nonatomic, strong) UILabel *concessionMoney;
/** 让利背景图片 */
@property(nonatomic, strong) UIImageView *concessionIamgeView;
/** 物品图片布局 */

@property(nonatomic, strong) UIView *picBgView;
@property(nonatomic, strong) UIImageView *showImage1;
@property(nonatomic, strong) UIImageView *showImage2;
@property(nonatomic, strong) UIImageView *showImage3;
/** 图片布局数组 */
@property(nonatomic, strong) NSMutableArray *picImageViewArr;
@end
@implementation YYB_HF_guessLikeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.bgView = [UIView new];
    self.nameLabel = [UILabel new];
    self.adLabel = [UILabel new];
    self.distanceLabel = [UILabel new];
    self.priceLabel = [UILabel new];
    self.oldPriceLabel = [UILabel new];
    
    self.concessionIamgeView = [UIImageView new];
    self.concessionMoney = [UILabel new];
    self.picBgView = [UIView new];
    self.showImage1 = [UIImageView new];
    self.showImage2 = [UIImageView new];
    self.showImage3 = [UIImageView new];
    self.showImage1.backgroundColor = [UIColor brownColor];
    self.showImage2.backgroundColor = [UIColor brownColor];
    self.showImage3.backgroundColor = [UIColor brownColor];
    
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.adLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.oldPriceLabel];
    [self.contentView addSubview:self.concessionIamgeView];
    [self.contentView addSubview:self.concessionMoney];
    
    [self.contentView addSubview:self.picBgView];
    [self.picBgView addSubview:self.showImage1];
    [self.picBgView addSubview:self.showImage2];
    [self.picBgView addSubview:self.showImage3];
    
    self.showImage1.image = image(@"image1");
    self.showImage2.image = image(@"image2");
    self.showImage3.image = image(@"image3");
    self.picImageViewArr = [NSMutableArray arrayWithArray:@[self.showImage1,self.showImage2,self.showImage3]];
    
    self.concessionIamgeView.image = image(@"icon_biaoqian");
    
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    //    self.bgView.clipsToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 3;
    
    
    self.nameLabel.text = @"索菲特国际饭店海鲜自助餐";
    self.nameLabel.font = FONT(14);
    self.adLabel.text = @"仅售3580元，价值6086元的优惠套餐，欢迎体验仅售3580元，价值6086元的优惠套餐，欢迎体验";
    self.adLabel.font = FONT(12);
    self.adLabel.textColor = HEX_COLOR(0x333333);
    self.distanceLabel.text = @"x.xkm";
    self.distanceLabel.font = FONT(9);
    self.distanceLabel.textAlignment = NSTextAlignmentRight;

    self.distanceLabel.textColor = HEX_COLOR(0x333333);
    self.priceLabel.text = @"￥xxxxx";
    self.priceLabel.font = FONT(17);
    self.priceLabel.textColor = HEX_COLOR(0xCA1400);
    
    self.oldPriceLabel.text = @"￥xxxxx";
    self.oldPriceLabel.textColor = HEX_COLOR(0xAAAAAA);
    self.oldPriceLabel.font = FONT(11);
    
    self.concessionMoney.textColor = [UIColor whiteColor];
    self.concessionMoney.text = @"让利￥xxx";
    self.concessionMoney.font = FONT(10);
    self.concessionMoney.textAlignment = NSTextAlignmentCenter;

    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.oldPriceLabel.text
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPriceLabel.attributedText = attrStr;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.right.mas_equalTo(self.contentView).mas_offset(-13);
        make.top.mas_equalTo(self.contentView).mas_offset(5);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-5);
        
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        make.top.mas_equalTo(self.bgView).mas_offset(10);
        make.height.mas_equalTo(15);
    }];
    
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bgView).mas_offset(-10);
        make.height.mas_equalTo(12);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(5);
        make.width.mas_greaterThanOrEqualTo(40);
    }];
    [self.adLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        make.top.mas_equalTo(self.nameLabel.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(self.distanceLabel.mas_left).mas_offset(-18);
        make.height.mas_equalTo(12);
    }];
    
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        make.top.mas_equalTo(self.adLabel.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(17);
    }];
    
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(11);
    }];
    
    [self.concessionMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oldPriceLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(13);
    }];
    [self.concessionIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.concessionMoney);
        make.left.mas_equalTo(self.concessionMoney).mas_offset(0);
        make.width.mas_equalTo(self.concessionMoney);
    }];
    
    [self.picBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLabel.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.nameLabel);
        make.right.mas_equalTo(self.distanceLabel);
        make.height.mas_equalTo(80);
    }];
    //    [self.picImageViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:10 tailSpacing:10];
    //    [self.picImageViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(0);
    //        make.height.mas_equalTo(80);
    //    }];
    
    [self.picImageViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:105 leadSpacing:0 tailSpacing:0];
    [self.picImageViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.picBgView);
        make.bottom.mas_equalTo(self.picBgView);
    }];
    
}

- (void)setSetNameStr:(NSString *)setNameStr {
    _setNameStr = setNameStr;
    self.nameLabel.text = setNameStr;
}

- (void)setSetAdLabelStr:(NSString *)setAdLabelStr {
    self.adLabel.text = setAdLabelStr;
}

- (void)setSetDistanceStr:(NSString *)setDistanceStr {
    self.distanceLabel.text = setDistanceStr;
}

- (void)setSetPriceStr:(NSString *)setPriceStr {
    
    self.priceLabel.text = setPriceStr;
}

- (void)setSetOldPriceStr:(NSString *)setOldPriceStr {
    _setOldPriceStr = setOldPriceStr;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_setOldPriceStr
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPriceLabel.attributedText = attrStr;
}

- (void)setSetConcessionMoneyStr:(NSString *)setConcessionMoneyStr {
    self.concessionMoney.text = setConcessionMoneyStr;
}

- (void)setSetImageArr:(NSArray *)setImageArr {
    
    for (int i = 0; i < self.picImageViewArr.count; i ++) {
        UIImageView *imgView = self.picImageViewArr[i];
        if (setImageArr.count > i) {
            [imgView setHidden:NO];
            NSString *imgUrlStr = setImageArr[i];
            [imgView sd_setImageWithURL:[NSURL URLWithString:imgUrlStr] placeholderImage:image(@"icon_shenxian")];

        }else {
            [imgView setHidden:YES];
        }
    }
}


@end

// !!!: YYB_HF_guessLikeCollectionViewCellRightPic
@interface YYB_HF_guessLikeCollectionViewCellRightPic()
@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UILabel  *nameLabel;
@property(nonatomic, strong) UILabel *distanceLabel;
@property(nonatomic, strong) UILabel *priceLabel;
@property(nonatomic, strong) UILabel *oldPriceLabel;
/** 让利 */
@property(nonatomic, strong) UILabel *concessionMoney;

@property(nonatomic, strong) UIImageView *concessionIamgeView;
@property(nonatomic, strong) UIImageView *showImage;

@end
@implementation YYB_HF_guessLikeCollectionViewCellRightPic

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.bgView = [UIView new];
    self.nameLabel = [UILabel new];
    self.distanceLabel = [UILabel new];
    self.priceLabel = [UILabel new];
    self.oldPriceLabel = [UILabel new];
    
    self.concessionIamgeView = [UIImageView new];
    self.concessionMoney = [UILabel new];
    self.showImage = [UIImageView new];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.oldPriceLabel];
    [self.contentView addSubview:self.concessionIamgeView];
    [self.contentView addSubview:self.concessionMoney];
    [self.contentView addSubview:self.showImage];
    self.concessionIamgeView.image = image(@"icon_biaoqian");
    self.showImage.image = image(@"image1");
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    //    self.bgView.clipsToBounds = YES;
    self.bgView.layer.cornerRadius = 5;
    self.bgView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.bgView.layer.shadowOffset = CGSizeMake(0,0);
    self.bgView.layer.shadowOpacity = 0.5;
    self.bgView.layer.shadowRadius = 3;
    
    self.nameLabel.text = @"郑州辰星医疗美容医院【冰点脱 毛】（腋毛/唇毛二选一）...郑州辰星医疗美容医院【冰点脱 毛】（腋毛/唇毛二选一）...";
    self.nameLabel.font = FONT(14);
    self.nameLabel.numberOfLines = 2;
    self.distanceLabel.text = @"x.xkm";
    self.distanceLabel.font = FONT(9);
    self.distanceLabel.textAlignment = NSTextAlignmentRight;
    self.priceLabel.text = @"￥xxxxx";
    self.priceLabel.font = FONT(17);
    self.priceLabel.textColor = HEX_COLOR(0xCA1400);
    
    self.oldPriceLabel.text = @"￥xxxxx";
    self.oldPriceLabel.textColor = HEX_COLOR(0xAAAAAA);
    self.oldPriceLabel.font = FONT(11);
    
    self.concessionMoney.textColor = [UIColor whiteColor];
    self.concessionMoney.text = @"让利￥xxx";
    self.concessionMoney.font = FONT(10);
    self.concessionMoney.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:self.oldPriceLabel.text
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPriceLabel.attributedText = attrStr;
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).mas_offset(12);
        make.right.mas_equalTo(self.contentView).mas_offset(-13);
        make.top.mas_equalTo(self.contentView).mas_offset(5);
        make.bottom.mas_equalTo(self.contentView).mas_offset(-5);
        
    }];
    [self.showImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.right.mas_equalTo(self.bgView).mas_offset(-10);
        make.width.mas_equalTo(101);
        make.height.mas_equalTo(74);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        make.top.mas_equalTo(self.bgView).mas_offset(10);
        make.right.mas_equalTo(self.showImage.mas_left).mas_offset(-39);
        make.height.mas_greaterThanOrEqualTo(33);
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgView).mas_offset(10);
        make.bottom.mas_equalTo(self.showImage.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(17);
    }];
    
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.priceLabel.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(11);
    }];
    
    [self.concessionMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.oldPriceLabel.mas_right).mas_offset(10);
        make.centerY.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(13);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
    [self.concessionIamgeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.concessionMoney).mas_offset(0);
        make.right.mas_equalTo(self.concessionMoney);
        make.bottom.mas_equalTo(self.concessionMoney);
        make.top.mas_equalTo(self.concessionMoney);
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.showImage.mas_left).mas_offset(-5);
        make.left.mas_equalTo(self.concessionIamgeView.mas_right).mas_offset(5);
        make.bottom.mas_equalTo(self.priceLabel);
        make.height.mas_equalTo(12);
    }];
}

- (void)setSetNameStr:(NSString *)setNameStr {
    _setNameStr = setNameStr;
    self.nameLabel.text = setNameStr;
}

- (void)setSetDistanceStr:(NSString *)setDistanceStr {
    self.distanceLabel.text = setDistanceStr;
}

- (void)setSetPriceStr:(NSString *)setPriceStr {
    
    self.priceLabel.text = setPriceStr;
}

- (void)setSetOldPriceStr:(NSString *)setOldPriceStr {
    _setOldPriceStr = setOldPriceStr;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:_setOldPriceStr
                                                                                attributes:@{NSStrikethroughStyleAttributeName : @(NSUnderlineStyleSingle)}];
    self.oldPriceLabel.attributedText = attrStr;
}

- (void)setSetConcessionMoneyStr:(NSString *)setConcessionMoneyStr {
    self.concessionMoney.text = setConcessionMoneyStr;
}

- (void)setSetImageUrl:(NSString *)setImageUrl {
    [self.showImage sd_setImageWithURL:[NSURL URLWithString:setImageUrl] placeholderImage:image(@"icon_shenxian")];
}


@end

