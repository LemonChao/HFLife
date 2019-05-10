//
//  YYB_HF_LocalHeadView.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "YYB_HF_LocalHeadView.h"
#import "CityChooseVC.h"
@interface YYB_HF_LocalHeadView()<CityChooseVCDelegate>
/** 头像 */
@property(nonatomic, strong) UIImageView *headImageV;
/** 位置 */
@property(nonatomic, strong) UILabel *localLabel;
/** 选择icon */
@property(nonatomic, strong) UIButton *selectBtn;
/** 搜索内容 */
@property(nonatomic, strong) UILabel *searchlabel;
@end
@implementation YYB_HF_LocalHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    self.headImageV = [UIImageView new];
    self.localLabel = [UILabel new];
    self.selectBtn = [UIButton new];
    self.searchlabel = [UILabel new];
    
    
    [self addSubview:self.headImageV];
    [self addSubview:self.localLabel];
    [self addSubview:self.selectBtn];
    
//    self.headImageV.backgroundColor = [UIColor redColor];
    self.headImageV.image = MMGetImage(@"icon_touxiang");
    [self.selectBtn setImage:MMGetImage(@"icon_jiantou") forState:UIControlStateNormal];
    
    [self.headImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).mas_offset(HeightStatus + ScreenScale(7));
        make.left.mas_equalTo(self).mas_offset(ScreenScale(20));
        make.width.height.mas_equalTo(ScreenScale(33));
    }];
    
    self.localLabel.text = @"郑州";
    self.localLabel.font = FONT(15);
    [self.localLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.headImageV.mas_right).mas_offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(33));
    }];
    
//    self.selectBtn.backgroundColor = [UIColor redColor];
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.localLabel.mas_right).mas_offset(3);
        make.height.mas_equalTo(ScreenScale(14));
        make.width.mas_equalTo(ScreenScale(10));
    }];
    
    UIView *searchBgView = [UIView new];
    searchBgView.backgroundColor = HEX_COLOR(0xF5F5F5);
    searchBgView.clipsToBounds = YES;
    searchBgView.layer.cornerRadius = ScreenScale(4);
    [self addSubview:searchBgView];
    [searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(ScreenScale(20));
        make.right.mas_equalTo(self).mas_offset(-ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(33));
    }];
    
    UIImageView *searchIcon = [UIImageView new];
//    searchIcon.backgroundColor = [UIColor redColor];
    searchIcon.image = MMGetImage(@"搜索");
    [searchBgView addSubview:searchIcon];
    [searchIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(searchBgView).mas_offset(ScreenScale(22));
        make.width.height.mas_equalTo(ScreenScale(14));
    }];
    [searchBgView addSubview:self.searchlabel];
    self.searchlabel.text = @"海底捞";
    self.searchlabel.textColor = HEX_COLOR(0xAAAAAA);
    self.searchlabel.font = FONT(13);
    [self.searchlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.headImageV);
        make.left.mas_equalTo(searchIcon.mas_right).mas_offset(ScreenScale(10));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    self.localLabel.userInteractionEnabled = YES;
    [self.localLabel wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self gotoCityVC];
    }];
    
    [self.selectBtn wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self gotoCityVC];
    }];
    
    searchBgView.userInteractionEnabled = YES;
    [searchBgView wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        NSLog(@"搜索");
        [self.viewController.navigationController pushViewController:[NSClassFromString(@"YYB_HF_NearSearchVC") new] animated:YES];
    }];
    
    
    
}

#pragma mark - method

- (void)gotoCityVC {
    NSLog(@"choseCity");
    CityChooseVC *cityChoose = [[CityChooseVC alloc]init];
    cityChoose.delegate = self;
    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:cityChoose];
    [self.viewController presentViewController:navigationController animated:YES completion:nil];
    //        [self.viewController.navigationController pushViewController:navigationController animated:YES];
}

#pragma mark - setValue
- (void)setSetLocalStr:(NSString *)setLocalStr {
    self.localLabel.text = setLocalStr;
}

- (void)setSetSearchStr:(NSString *)setSearchStr {
    self.searchlabel.text = setSearchStr;
}

- (void)setSetHeadImageStr:(NSString *)setHeadImageStr {
    [self.headImageV sd_setImageWithURL:[NSURL URLWithString:setHeadImageStr] placeholderImage:image(@"icon_touxiang")];
}


#pragma mark - cityDeleage
- (void)cityChooseName:(NSString *)name {
   
}
@end
