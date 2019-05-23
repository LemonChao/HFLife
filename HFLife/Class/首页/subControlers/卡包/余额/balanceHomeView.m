
//
//  balanceHomeView.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "balanceHomeView.h"
#import "WithdrawItemView.h"
@interface balanceHomeView()

@property (nonatomic, strong)UILabel *moneyLb;
@property (nonatomic, strong)UIImageView *bgImageV;
@property (nonatomic, strong)UILabel *monryTitleLb;
@property (nonatomic, strong)UIView *headerBottomView;
@property (nonatomic, strong)UILabel *timelb;
@property (nonatomic, strong)UILabel *subTitleLb;
@property (nonatomic, strong)UIButton *lookBtn;//chakan
@property (nonatomic, strong)WithdrawItemView *itemView;
@property (nonatomic, strong)UIView *bottomBarView;

@property (nonatomic, strong)UIButton *txBtn;
@property (nonatomic, strong)UIButton *transBtn;
@end



@implementation balanceHomeView

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
    self.bgImageV        = [UIImageView new];
    self.moneyLb         = [UILabel new];
    self.monryTitleLb    = [UILabel new];
    self.headerBottomView      = [UIView new];
    self.timelb          = [UILabel new];
    self.subTitleLb      = [UILabel new];
    self.lookBtn         = [UIButton new];
    self.itemView        = [WithdrawItemView new];
    self.bottomBarView   = [UIView new];
    self.txBtn           = [UIButton new];
    self.transBtn        = [UIButton new];
    
    [self addSubview:self.bgImageV];
    [self addSubview:self.monryTitleLb];
    [self addSubview:self.moneyLb];
    [self addSubview:self.headerBottomView];
    [self addSubview:self.bottomBarView];
    [self.headerBottomView addSubview:self.timelb];
    [self.headerBottomView addSubview:self.subTitleLb];
    [self.headerBottomView addSubview:self.lookBtn];
    [self.bottomBarView addSubview:self.txBtn];
    [self.bottomBarView addSubview:self.transBtn];
    
    self.moneyLb.setFontSize(40).setTextColor([UIColor whiteColor]);
    self.monryTitleLb.setFontSize(14).setTextColor([UIColor whiteColor]);
    self.timelb.setFontSize(14).setTextColor([UIColor whiteColor]);
    self.subTitleLb.setFontSize(14).setTextColor([UIColor whiteColor]);
    self.lookBtn.layer.cornerRadius = 4;
    self.lookBtn.layer.masksToBounds = YES;
    self.lookBtn.setTitleFontSize(14).setTitleColor([UIColor whiteColor], UIControlStateNormal).setTitle(@"去查看", UIControlStateNormal);
    
    self.txBtn.setTitleFontSize(18).setTitleColor(HEX_COLOR(0x429AFD), UIControlStateNormal).setTitle(@"提现", UIControlStateNormal).setBackgroundColor([UIColor whiteColor]);
    self.lookBtn.setTitleFontSize(18).setTitleColor([UIColor whiteColor], UIControlStateNormal).setTitle(@"转账", UIControlStateNormal).setBackgroundColor(HEX_COLOR(0x429AFD));
    
    
    [self.lookBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)clickBtn:(UIButton *)sender{
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
