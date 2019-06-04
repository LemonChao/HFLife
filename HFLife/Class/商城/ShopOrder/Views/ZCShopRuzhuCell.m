//
//  ZCShopRuzhuCell.m
//  HFLife
//
//  Created by zchao on 2019/5/30.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopRuzhuCell.h"

@interface ZCShopRuzhuCell ()

@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIButton *allButton;

@property(nonatomic, copy) NSArray<__kindof UIButton*> *subButtons;


@end


@implementation ZCShopRuzhuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIView *lineView = [UITool viewWithColor:LineColor];
        UIView *cornerBGView = [UITool viewWithColor:[UIColor whiteColor]];
        [cornerBGView addShadowForViewColor:GeneralRedColor offSet:CGSizeMake(0, 2) shadowRadius:3 cornerRadius:ScreenScale(5) opacity:0.1];
        UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:self.subButtons];
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.alignment = UIStackViewAlignmentFill;
        stack.spacing = ScreenScale(20);//ScreenScale(10);
        
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
            make.right.equalTo(cornerBGView).inset(ScreenScale(15));
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

- (void)allButtonAction:(UIButton *)button {
    ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"apply-record" parameters:@{@"type":@"0"}];
    [self.viewController.navigationController pushViewController:webVC animated:YES];
}

- (void)orderButtonAction:(UIButton *)button {
    if ([button.currentTitle isEqualToString:@"个人入住"]) {
        ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"enter-select-gr" parameters:nil];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }else if ([button.currentTitle isEqualToString:@"商家入驻"]) {
        ZCShopWebViewController *webVC = [[ZCShopWebViewController alloc] initWithPath:@"enter-select-qy" parameters:nil];
        [self.viewController.navigationController pushViewController:webVC animated:YES];
    }
    
    
}

- (void)setModel:(NSObject *)model {
    for (UIButton *button in self.subButtons) {
        [button setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(10)];
    }
    
    [self.allButton setImagePosition:ImagePositionTypeRight spacing:ScreenScale(10)];
}



- (NSArray<UIButton *> *)subButtons {
    if (!_subButtons) {
        NSArray *titls = @[@"个人入住",@"商家入驻"];
        NSArray *imageNames = @[@"orderCenter_gerenruzhu",@"orderCenter_shangjiaruzhu"];
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
        _titleLabel.text = @"我的入驻";
    }
    return _titleLabel;
}

- (UIButton *)allButton {
    if (!_allButton) {
        _allButton = [UITool richButton:UIButtonTypeCustom title:@"查看" titleColor:AssistColor font:SystemFont(14) bgColor:[UIColor clearColor] image:image(@"orderCenter_arrow_right")];
        [_allButton addTarget:self action:@selector(allButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allButton;
}


@end
