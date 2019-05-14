//
//  ZC_HF_HomeRushPurchaseCell.m
//  HFLife
//
//  Created by zchao on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_HomeRushPurchaseCell.h"


@interface ZC_HF_HomeRushPurchaseCell ()
@property(nonatomic, strong) UILabel *titleLable;

@property(nonatomic, strong)NSArray<UIButton *> *subButtons;

@end


@implementation ZC_HF_HomeRushPurchaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIButton *imgButton = [self imageButton:@"zhendianzhibao"];
        UIButton *topLeftButton = [self imageButton:@"pinpaizhekou"];
        UIButton *topRightButton = [self imageButton:@"tiantiantemai"];
        UIButton *bottomLeftButton = [self imageButton:@"shihuihaohuo"];
        UIButton *bottomRightButton = [self imageButton:@"pinleimiaosha"];

        [self.contentView addSubview:self.titleLable];
        [self.contentView addSubview:imgButton];
        [self.contentView addSubview:topLeftButton];
        [self.contentView addSubview:topRightButton];
        [self.contentView addSubview:bottomLeftButton];
        [self.contentView addSubview:bottomRightButton];
        
        [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView);
            make.left.equalTo(self.contentView).offset(ScreenScale(12));
            make.height.mas_equalTo(ScreenScale(40));
        }];

        
        
        [imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLable.mas_bottom);
            make.left.right.equalTo(self.contentView).inset(ScreenScale(12));
            make.height.mas_equalTo(ScreenScale(100));
        }];
        
        [topLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgButton.mas_bottom).offset(ScreenScale(12));
            make.left.equalTo(self.contentView).inset(ScreenScale(12));
            make.size.mas_equalTo(CGSizeMake(ScreenScale(170), ScreenScale(100)));
        }];
        [topRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imgButton.mas_bottom).offset(ScreenScale(12));
            make.right.equalTo(self.contentView).inset(ScreenScale(12));
            make.size.equalTo(topLeftButton);
        }];

        [bottomLeftButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topLeftButton.mas_bottom).offset(ScreenScale(12));
            make.left.equalTo(self.contentView).inset(ScreenScale(12));
            make.size.equalTo(topLeftButton);
        }];

        [bottomRightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(topRightButton.mas_bottom).offset(ScreenScale(12));
            make.right.equalTo(self.contentView).inset(ScreenScale(12));
            make.size.equalTo(topLeftButton);
        }];

    }
    return self;
}

- (UIButton *)imageButton:(NSString *)imgName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:image(imgName) forState:UIControlStateNormal];
    [button setBackgroundImage:image(imgName) forState:UIControlStateHighlighted];
    button.imageView.contentMode = UIViewContentModeScaleToFill;
    [button addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}


- (void)imageButtonAction:(UIButton *)button {
    
}

- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UITool labelWithTextColor:ImportantColor font:MediumFont(18)];
        _titleLable.text = @"今日必抢";
    }
    return _titleLable;
}


@end
