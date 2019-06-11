//
//  YYB_HF_SearchHeadView.m
//  HFLife
//
//  Created by mac on 2019/6/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_SearchHeadView.h"
@interface YYB_HF_SearchHeadView()<UITextFieldDelegate>

/** 类别 */
@property(nonatomic, strong) UILabel *typeLabel;
/** 选择icon */
@property(nonatomic, strong) UIButton *selectBtn;
/** i点击搜索 */
@property(nonatomic, strong) UIButton *orderSearchBtn;

@property(nonatomic, strong) UIView *searchBgView;
@property(nonatomic, strong) UIImageView *searchIcon;
@property(nonatomic, strong) UIImageView *backIcon;
@property(nonatomic, strong) UIView *backBgView;

@end

@implementation YYB_HF_SearchHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.backIcon = [UIImageView new];
    self.typeLabel = [UILabel new];
    self.selectBtn = [UIButton new];
    self.searchT = [UITextField new];
    self.orderSearchBtn = [UIButton new];
    self.searchBgView = [UIView new];
    self.backBgView = [UIView new];
    
    [self addSubview:self.searchBgView];
    [self addSubview:self.typeLabel];
    [self addSubview:self.backIcon];
    [self addSubview:self.selectBtn];
    [self addSubview:self.searchT];
    [self addSubview:self.orderSearchBtn];
    [self addSubview:self.backBgView];
    
    //    self.backIcon.backgroundColor = [UIColor redColor];
    self.backIcon.image = MMGetImage(@"back");
    self.backIcon.clipsToBounds = YES;
    self.backIcon.layer.cornerRadius = ScreenScale(16);
    
    self.backBgView.userInteractionEnabled = YES;
    self.backBgView.backgroundColor = [UIColor clearColor];
    [self.backBgView wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.backClick) {
            self.backClick();
        }
    }];
    
    [self.selectBtn setImage:MMGetImage(@"icon_jiantou") forState:UIControlStateNormal];
    
    self.typeLabel.text = @"美食";
    self.typeLabel.font = FONT(14);
    
    //    self.selectBtn.backgroundColor = [UIColor redColor];
    
    self.searchBgView.backgroundColor = HEX_COLOR(0xF5F5F5);
    self.searchBgView.clipsToBounds = YES;
    self.searchBgView.layer.cornerRadius = ScreenScale(14);
    
    UIImageView *searchIcon = [UIImageView new];
    //    searchIcon.backgroundColor = [UIColor redColor];
    searchIcon.image = MMGetImage(@"搜索");
    [self.searchBgView addSubview:searchIcon];
    self.searchIcon = searchIcon;
    
    [self.searchBgView addSubview:self.searchT];
    self.searchT.text = @"海底捞";
    self.searchT.textColor = HEX_COLOR(0xAAAAAA);
    self.searchT.font = FONT(13);
    
    
    [self.orderSearchBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.orderSearchBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self.orderSearchBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
    
    self.searchBgView.backgroundColor = HEX_COLOR(0xF5F5F5);
    
    self.typeLabel.userInteractionEnabled = YES;
    //b类型列表
    [self.typeLabel wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self typeClick];
    }];
    
    [self.selectBtn wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self typeClick];
    }];
    
    [self.orderSearchBtn wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        if (self.searchClick) {
            self.searchClick();
        }else {
            [WXZTipView showCenterWithText:@"点击搜索"];
        }
    }];
}

//搜索类型
- (void)typeClick {
    if (self.typeSelect) {
        self.typeSelect();
    }else {
        [WXZTipView showCenterWithText:@"点击类型"];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.backIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(HeightStatus + ScreenScale(7));
        make.left.mas_equalTo(self).mas_offset(ScreenScale(10));
        make.width.height.mas_equalTo(ScreenScale(20));
    }];
    
    [self.backBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.backIcon);
        make.width.height.mas_equalTo(ScreenScale(40));
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backIcon);
        make.left.mas_equalTo(self.backIcon.mas_right).mas_offset(ScreenScale(40));
        make.height.mas_equalTo(ScreenScale(33));
        make.width.mas_equalTo(ScreenScale(50));
    }];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backIcon);
        make.left.mas_equalTo(self.typeLabel.mas_right).mas_offset(3);
        make.height.mas_equalTo(ScreenScale(14));
        make.width.mas_equalTo(ScreenScale(10));
    }];
    
    [self.searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backIcon);
        make.left.mas_equalTo(self.typeLabel).mas_offset(ScreenScale(-20));
        make.right.mas_equalTo(self).mas_offset(-ScreenScale(67));
        make.height.mas_equalTo(ScreenScale(28));
    }];
    
    [self.searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backIcon);
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(ScreenScale(22));
        make.width.height.mas_equalTo(ScreenScale(14));
    }];
    [self.searchT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backIcon);
        make.left.mas_equalTo(self.searchIcon.mas_right).mas_offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(28));
        make.right.mas_equalTo(self.searchBgView);
    }];
    
    [self.orderSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(ScreenScale(-25));
        make.centerY.mas_equalTo(self.searchBgView);
        make.height.mas_equalTo(25);
        make.width.mas_greaterThanOrEqualTo(1);
    }];
}

#pragma mark - setValue

- (void)setSetTypeStr:(NSString *)setTypeStr{
    self.typeLabel.text = setTypeStr;
    [self.typeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.backIcon);
        make.left.mas_equalTo(self.backIcon.mas_right).mas_offset(ScreenScale(40));
        make.height.mas_equalTo(ScreenScale(33));
        make.width.mas_equalTo(ScreenScale(16) * (self.typeLabel.text.length > 4 ? 4 : self.typeLabel.text.length));
    }];
}

- (void)setSetSearchStr:(NSString *)setSearchStr {
    self.searchT.text = setSearchStr;
}

- (void)setSetHeadImageStr:(NSString *)setHeadImageStr {
    [self.backIcon sd_setImageWithURL:[NSURL URLWithString:setHeadImageStr] placeholderImage:image(@"icon_touxiang")];
}

- (void)setSetHeadImage:(UIImage *)setHeadImage {
    if (setHeadImage && [setHeadImage isKindOfClass:[UIImage class]]) {
        [self.backIcon setImage:setHeadImage];
    }else {
        [self.backIcon sd_setImageWithURL:[NSURL URLWithString:[userInfoModel sharedUser].member_avatar] placeholderImage:image(@"icon_touxiang")];
    }
}




@end
