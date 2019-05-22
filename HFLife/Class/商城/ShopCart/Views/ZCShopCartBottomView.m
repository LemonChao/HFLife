//
//  ZCShopCartBottomView.m
//  HFLife
//
//  Created by zchao on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartBottomView.h"

@interface ZCShopCartBottomView ()

@property(nonatomic, strong) UIButton *selectAllBtn;

@property(nonatomic, strong) UILabel *countLabel;

@property(nonatomic, strong) UIButton *jieSuanButton;

@property(nonatomic, strong) UILabel *priceLabel;

@end


@implementation ZCShopCartBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
     
        @weakify(self);
        [RACObserve(self, viewModel.selectCount) subscribeNext:^(NSNumber *_Nullable value) {
            @strongify(self);
            [self.jieSuanButton setTitle:[NSString stringWithFormat:@"结算(%@)",value] forState:UIControlStateNormal];
        }];
        
        RAC(self.priceLabel,text) = [RACObserve(self, viewModel.totalPrice) map:^id _Nullable(NSNumber *_Nullable value) {
            return [NSString stringWithFormat:@"￥%.2f", value.floatValue];
        }];
        RAC(self.selectAllBtn,selected) = [RACObserve(self, viewModel.selectAll) skip:1];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *hejiLab = [UITool labelWithText:@"合计" textColor:ImportantColor font:SystemFont(14)];
    UILabel *yunfeiLab = [UITool labelWithText:@"不含运费" textColor:AssistColor font:SystemFont(11)];
    
    [self addSubview:self.selectAllBtn];
    [self addSubview:hejiLab];
    [self addSubview:self.countLabel];
    [self addSubview:yunfeiLab];
    [self addSubview:self.jieSuanButton];
    [self addSubview:self.priceLabel];
    
    [self.selectAllBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).inset(ScreenScale(12));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(ScreenScale(58), ScreenScale(49)));
    }];
    [hejiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(ScreenScale(10));
        make.bottom.equalTo(self.selectAllBtn.mas_centerY);
    }];
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(hejiLab);
        make.left.equalTo(hejiLab.mas_right).offset(ScreenScale(6));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countLabel);
        make.left.equalTo(self.countLabel);
    }];
    
    [yunfeiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectAllBtn.mas_right).offset(ScreenScale(12));
        make.top.equalTo(self.selectAllBtn.mas_centerY).offset(ScreenScale(2));
    }];
    [self.jieSuanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).inset(ScreenScale(15));
        make.size.mas_equalTo(CGSizeMake(ScreenScale(90), ScreenScale(33)));
        make.centerY.equalTo(self);
    }];
    
    [self layoutIfNeeded];
    [_selectAllBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(10)];
    
}



- (void)selectAllButtonAction:(UIButton *)button {
    //购物车为空直接返回
    if (!self.viewModel.cartArray.count) return;
    
    
    BOOL selected = ![self.viewModel.selectAll boolValue];
    self.viewModel.selectAll = [NSNumber numberWithBool:selected];
    [self.viewModel.cartArray enumerateObjectsUsingBlock:^(__kindof ZCShopCartModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        model.selectAll = selected;
        for (ZCShopCartGoodsModel *goods in model.goods) {
            goods.selected = selected;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];

}

- (void)jieSuanButtonAction:(UIButton *)button {
}

#pragma mark - setter && getter
- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
    }
    return _countLabel;
}

- (UIButton *)selectAllBtn {
    if (!_selectAllBtn) {
        _selectAllBtn = [UITool richButton:UIButtonTypeCustom title:@"全选" titleColor:ImportantColor font:SystemFont(14) bgColor:[UIColor clearColor] image:image(@"cart_gods_normal")];
        [_selectAllBtn setImage:image(@"cart_gods_select") forState:UIControlStateSelected];
        [_selectAllBtn addTarget:self action:@selector(selectAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllBtn;
}

- (UIButton *)jieSuanButton {
    if (!_jieSuanButton) {
        _jieSuanButton = [UITool richButton:UIButtonTypeCustom title:@"结算(0)" titleColor:[UIColor whiteColor] font:MediumFont(17) bgColor:GeneralRedColor image:nil];
        _jieSuanButton.layer.cornerRadius = ScreenScale(17);
        _jieSuanButton.clipsToBounds = YES;
        [_jieSuanButton setBackgroundImage:[UIImage imageWithColor:GeneralRedColor] forState:UIControlStateNormal];
        [_jieSuanButton setBackgroundImage:[UIImage imageWithColor:AssistColor] forState:UIControlStateDisabled];
        [_jieSuanButton addTarget:self action:@selector(jieSuanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _jieSuanButton;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UITool labelWithTextColor:GeneralRedColor font:SystemFont(14)];
    }
    return _priceLabel;
}
@end
