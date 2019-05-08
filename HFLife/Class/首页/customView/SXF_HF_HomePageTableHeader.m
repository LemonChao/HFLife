//
//  SXF_HF_HomePageTableHeader.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_HomePageTableHeader.h"
#import "myTopView.h"
#import "DigitalRollingView.h"
@interface SXF_HF_HomePageTableHeader ()

@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UIImageView *peploImageV;

/**
 人数
 */
@property (nonatomic, strong)UIView *pepleCountView;
@property (nonatomic, strong)DigitalRollingView *countView;

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
@property (nonatomic, strong)UIView *fqMoneyView;

@property (nonatomic, strong)myTopView *bottomBarView;
@property (nonatomic, strong)UIView *bottomBarBgView;

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
    self.backgroundColor = [UIColor whiteColor];
    self.bgImageV = [UIImageView new];
    self.peploImageV = [UIImageView new];
    self.pepleCountView = [UIView new];
    self.myFQNumLb = [UILabel new];
    self.eyeImageV = [UIImageView new];
    self.myMoneyTitleLb = [UILabel new];
    self.moneyTypeLb = [UILabel new];
    self.myMoneyLb = [UILabel new];
    self.fqTitleLb = [UILabel new];
    self.fqMoneyView = [UILabel new];
    self.bottomBarView = [myTopView new];
    self.bottomBarBgView = [UIView new];
    self.countView = [[DigitalRollingView alloc] init];
    
    [self addSubview:self.bgImageV];
    [self addSubview:self.peploImageV];
    [self addSubview:self.pepleCountView];
    [self addSubview:self.myFQNumLb];
    [self addSubview:self.eyeImageV];
    [self addSubview:self.myMoneyTitleLb];
    [self addSubview:self.moneyTypeLb];
    [self addSubview:self.myMoneyLb];
    [self addSubview:self.fqTitleLb];
    [self addSubview:self.fqMoneyView];
    [self addSubview:self.bottomBarBgView];
    [self.bottomBarBgView addSubview:self.bottomBarView];
    [self.pepleCountView addSubview:self.countView];
    
    self.peploImageV.image = [UIImage imageNamed:@"人数图标"];
    self.bgImageV.backgroundColor = [UIColor purpleColor];
    self.myFQNumLb.textColor = [UIColor whiteColor];
    self.myFQNumLb.font = MyFont(15);
    self.eyeImageV.image = [UIImage imageNamed:@"眼睛"];
    self.myMoneyTitleLb.textColor = [UIColor whiteColor];
    self.myMoneyTitleLb.font = MyFont(13);
    self.moneyTypeLb.font = MyFont(10);
    self.moneyTypeLb.backgroundColor = HEX_COLOR(0xCA1400);
    self.moneyTypeLb.textColor = [UIColor whiteColor];
    self.moneyTypeLb.layer.cornerRadius = 4;
    self.moneyTypeLb.layer.masksToBounds = YES;
    self.moneyTypeLb.textAlignment = NSTextAlignmentCenter;
    
    self.myMoneyLb.textColor = [UIColor whiteColor];
    self.myMoneyLb.font = MyFont(ScreenScale(30));
    
    self.fqTitleLb.font = MyFont(13);
    self.fqTitleLb.textColor = [UIColor whiteColor];
    
    
    self.bottomBarView.backgroundColor = [UIColor whiteColor];
    self.bottomBarBgView.backgroundColor = [UIColor whiteColor];
    
    
    self.pepleCountView.backgroundColor = [UIColor yellowColor];
    self.fqMoneyView.backgroundColor = [UIColor whiteColor];
    
//    self.moneyTypeLb.backgroundColor = 
    
    self.myFQNumLb.text = @"我的富权";
    self.myMoneyTitleLb.text = @"富权资产";
    self.moneyTypeLb.text = @"实时";
    self.fqTitleLb.text = @"富权";
    
    self.myMoneyLb.text = @"34545.7989789";
    
    
    self.bottomBarView.selectedItem = ^(NSInteger index) {
        NSLog(@"点击的是 ： %ld", index);
    };
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self);
        make.height.mas_equalTo(ScreenScale(200));
    }];
    
    [self.peploImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(ScreenScale(24));
        make.top.mas_equalTo(ScreenScale(20));
        make.width.mas_equalTo(ScreenScale(6));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.pepleCountView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.peploImageV.mas_right).offset(ScreenScale(8));
        make.centerY.mas_equalTo(self.peploImageV.mas_centerY);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(self.peploImageV.mas_height);
    }];
    
    [self.myFQNumLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.peploImageV.mas_left);
        make.top.mas_equalTo(self.peploImageV.mas_bottom).offset(ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(15));
    }];
    
    [self.eyeImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myFQNumLb.mas_right).offset(ScreenScale(4));
        make.centerY.mas_equalTo(self.myFQNumLb.mas_centerY);
        make.width.mas_equalTo(ScreenScale(16));
        make.height.mas_equalTo(ScreenScale(11));
    }];
    
    [self.myMoneyTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.peploImageV.mas_left);
        make.top.mas_equalTo(self.myFQNumLb.mas_bottom).offset(ScreenScale(16));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    [self.moneyTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myMoneyTitleLb.mas_right).offset(ScreenScale(4));
        make.centerY.mas_equalTo(self.myMoneyTitleLb.mas_centerY);
        make.width.mas_equalTo(ScreenScale(33));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.myMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myMoneyTitleLb.mas_left);
        make.top.mas_equalTo(self.myMoneyTitleLb.mas_bottom).offset(ScreenScale(11));
        make.height.mas_equalTo(ScreenScale(23));
    }];
    
    [self.fqTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.myMoneyTitleLb.mas_left);
        make.top.mas_equalTo(self.myMoneyLb.mas_bottom).offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.fqMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.fqTitleLb.mas_right).offset(ScreenScale(4));
        make.centerY.mas_equalTo(self.fqTitleLb.mas_centerY);
        make.width.mas_equalTo(ScreenScale(200));
        make.height.mas_equalTo(self.fqTitleLb.mas_height);
    }];
    [self.bottomBarBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.mas_right).offset(-ScreenScale(12));
        make.top.mas_equalTo(self.fqTitleLb.mas_bottom).offset(ScreenScale(14));
        make.height.mas_equalTo(ScreenScale(110));
    }];
    [self.bottomBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(self.bottomBarBgView);
    }];
    
    
    
    [self layoutIfNeeded];    
    self.bottomBarBgView.layer.shadowColor = HEX_COLOR(0xFCC9C4).CGColor;
    self.bottomBarBgView.layer.shadowRadius = 4;
    self.bottomBarBgView.layer.shadowOpacity = 1.0;
    self.bottomBarBgView.layer.shadowOffset = CGSizeMake(0, 4);
    self.bottomBarBgView.layer.cornerRadius = 5;
    self.bottomBarBgView.layer.masksToBounds = YES;
    self.bottomBarBgView.clipsToBounds = YES;
    self.bottomBarBgView.masksToBounds = NO;
    
    self.bottomBarView.layer.cornerRadius = 5;
    self.bottomBarView.masksToBounds = YES;
    self.bottomBarView.clipsToBounds = YES;
    
    
    
}

@end
