//
//  WithdrawItemView.m
//  HanPay
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "WithdrawItemView.h"

@implementation WithdrawItemView
{
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
    UILabel *title1;
    UILabel *title2;
    UILabel *title3;
    
    NSMutableArray *titleArr;
    NSMutableArray *btnArr;
}


- (void) selectedBtn:(UIButton *)sender{
    NSInteger index=  sender.tag - 100;
    !self.selectedAtIndex ? : self.selectedAtIndex(index);
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChidrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChidrenViews];
    }
    return self;
}
- (void) addChidrenViews{
    btnArr = [NSMutableArray array];
    titleArr = [NSMutableArray array];
    btn1 = [UIButton new];
    btn2 = [UIButton new];
    btn3 = [UIButton new];
    
    title1 = [UILabel new];
    title2 = [UILabel new];
    title3 = [UILabel new];
    
    [self addSubview:btn1];
    [self addSubview:btn2];
    [self addSubview:btn3];
    [self addSubview:title1];
    [self addSubview:title2];
    [self addSubview:title3];
    
    [btn1 setImage:[UIImage imageNamed:@"余额记录"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"提现记录"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"转账记录"] forState:UIControlStateNormal];
    title1.text = @"余额记录";
    title2.text = @"提现记录";
    title3.text = @"转账记录";
    
    title1.font = [UIFont systemFontOfSize:WidthRatio(24)];
    title2.font = title1.font;
    title3.font = title1.font;
    title1.textColor = HEX_COLOR(0x333333);
    title2.textColor = HEX_COLOR(0x333333);
    title3.textColor = HEX_COLOR(0x333333);
    
    btn1.tag = 100;
    btn2.tag = 101;
    btn3.tag = 102;
    [btn1 addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
    [btn3 addTarget:self action:@selector(selectedBtn:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.backgroundColor = [UIColor whiteColor];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(84));
        make.height.width.mas_equalTo(WidthRatio(68));
        make.top.mas_equalTo(self.mas_top).offset(WidthRatio(31));
    }];
    
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self->btn1.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.height.mas_equalTo(self->btn1.mas_width);
    }];
    
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(WidthRatio(-84));
        make.width.height.mas_equalTo(self->btn1.mas_width);
        make.centerY.mas_equalTo(self->btn1.mas_centerY);
    }];
    
    [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->btn1.mas_bottom).offset(WidthRatio(21));
        make.centerX.mas_equalTo(self->btn1.mas_centerX);
    }];
    [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->btn2.mas_bottom).offset(WidthRatio(21));
        make.centerX.mas_equalTo(self->btn2.mas_centerX);
    }];
    [title3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->btn3.mas_bottom).offset(WidthRatio(21));
        make.centerX.mas_equalTo(self->btn3.mas_centerX);
    }];
    
    
    
}


@end
