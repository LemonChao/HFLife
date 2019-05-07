//
//  SXF_HF_HomePageTableHeader.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_HomePageTableHeader.h"

@interface SXF_HF_HomePageTableHeader ()

@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UIImageView *peploImageV;

/**
 人数
 */
@property (nonatomic, strong)UIView *pepleCountView;

/**
 我的富权
 */
@property (nonatomic, strong)UILabel *myFQNumLb;
@property (nonatomic, strong)UIImageView *eyeImageV;
/**
 我的资产
 */
@property (nonatomic, strong)UILabel *myMoneyTitleLb;

/**
 实时资产状态
 */
@property (nonatomic, strong)UILabel *moneyTypeLb;
@property (nonatomic, strong)UILabel *myMoneyLb;

@property (nonatomic, strong)UILabel *fqTitleLb;

/**
 富权
 */
@property (nonatomic, strong)UIView *fqMoneyLabel;

@property (nonatomic, strong)UIView *bottomBarView;

@end


@implementation SXF_HF_HomePageTableHeader
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    
    self.bgImageV = [UIImageView new];
    self.peploImageV = [UIImageView new];
    self.pepleCountView = [UIView new];
    self.myFQNumLb = [UILabel new];
    self.eyeImageV = [UIImageView new];
    self.myMoneyTitleLb = [UILabel new];
    self.moneyTypeLb = [UILabel new];
    self.myMoneyLb = [UILabel new];
    self.fqTitleLb = [UILabel new];
    self.fqMoneyLabel = [UILabel new];
    self.bottomBarView = [UILabel new];
    
    [self addSubview:self.bgImageV];
    [self addSubview:self.peploImageV];
    [self addSubview:self.pepleCountView];
    [self addSubview:self.myFQNumLb];
    [self addSubview:self.eyeImageV];
    [self addSubview:self.myMoneyTitleLb];
    [self addSubview:self.moneyTypeLb];
    [self addSubview:self.myMoneyLb];
    [self addSubview:self.fqTitleLb];
    [self addSubview:self.fqMoneyLabel];
    [self addSubview:self.bottomBarView];
    
    self.peploImageV.image = [UIImage imageNamed:@"人数图标"];
    self.bgImageV.backgroundColor = [UIColor purpleColor];
    self.myFQNumLb.textColor = [UIColor whiteColor];
    self.myFQNumLb.font = MyFont(15);
    self.eyeImageV.image = [UIImage imageNamed:@"眼睛"];
    self.myMoneyTitleLb.textColor = [UIColor whiteColor];
    self.myMoneyTitleLb.font = MyFont(13);
    self.moneyTypeLb.font = MyFont(10);
    self.moneyTypeLb.backgroundColor = HEX_COLOR(0xCA1400);
//    self.moneyTypeLb.backgroundColor = 
    
    
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
