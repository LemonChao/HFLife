//
//  ZCShopCouponsCell.m
//  HFLife
//
//  Created by zchao on 2019/5/27.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCouponsCell.h"

@interface ZCShopCouponsCell ()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIButton *allButton;

@property(nonatomic, copy) NSArray<__kindof UIButton*> *subButtons;


@end


@implementation ZCShopCouponsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UIView *lineView = [UITool viewWithColor:LineColor];
        UIView *cornerBGView = [UITool viewWithColor:[UIColor whiteColor]];
        [cornerBGView addShadowForViewColor:GeneralRedColor offSet:CGSizeMake(0, 2) shadowRadius:3 cornerRadius:ScreenScale(5) opacity:0.1];
        UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:self.subButtons];
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.alignment = UIStackViewAlignmentFill;
        stack.spacing = 0;//ScreenScale(10);

        [self.contentView addSubview:cornerBGView];
        [cornerBGView addSubview:self.titleLabel];
        [cornerBGView addSubview:self.allButton];
        [cornerBGView addSubview:lineView];
        [cornerBGView addSubview:stack];



        [cornerBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).inset(ScreenScale(0));
            make.left.right.equalTo(self.contentView).inset(ScreenScale(12));
            make.bottom.equalTo(self.contentView).inset(ScreenScale(10));
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(cornerBGView).inset(ScreenScale(10));
            make.top.equalTo(cornerBGView).inset(ScreenScale(15));
        }];
        
        [self.allButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleLabel);
            make.right.equalTo(cornerBGView).inset(ScreenScale(10));
        }];
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(cornerBGView);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScreenScale(12));
            make.height.mas_equalTo(1);
        }];
        
        [stack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(ScreenScale(15));
            make.left.right.equalTo(cornerBGView).inset(ScreenScale(15));
            make.bottom.equalTo(cornerBGView).inset(ScreenScale(15));
        }];

        
        [self layoutIfNeeded];
    }
    
    return self;
}

- (void)orderButtonAction:(UIButton *)button {
    
}

- (void)setModel:(NSObject *)model {
    for (UIButton *button in self.subButtons) {
        [button setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(10)];
    }
}



- (NSArray<UIButton *> *)subButtons {
    if (!_subButtons) {
        NSArray *titls = @[@"代金券",@"优惠券",@"领好券"];
        NSArray *imageNames = @[@"orderCenter_daijinquan",@"orderCenter_youhuiquan",@"orderCenter_lingquan"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < titls.count; i++) {
            UIButton *button = [UITool richButton:UIButtonTypeCustom title:titls[i] titleColor:ImportantColor font:SystemFont(14) bgColor:[UIColor whiteColor] image:image(imageNames[i])];
            [button addTarget:self action:@selector(orderButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [array addObject:button];
        }
        _subButtons = array.copy;
    }
    
    return _subButtons;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UITool labelWithTextColor:ImportantColor font:SystemFont(18)];
        [_titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        _titleLabel.text = @"我的优惠券";
    }
    return _titleLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UITool richButton:UIButtonTypeCustom title:@"查看优惠券" titleColor:AssistColor font:SystemFont(14) bgColor:[UIColor clearColor] image:image(@"orderCenter_arrow_right")];
    }
    return _allButton;
}


@end
