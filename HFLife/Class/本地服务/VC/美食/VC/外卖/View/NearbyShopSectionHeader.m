//
//  NearbyShopSectionHeader.m
//  HanPay
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "NearbyShopSectionHeader.h"

@implementation NearbyShopSectionHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"fujingshangjia"]];
    imageView.frame = CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(200));
    [self addSubview:imageView];
    
    UILabel *titleLabel = [UILabel new];
    titleLabel.text = @"附近\n商家";
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font  = [UIFont fontWithName:@"Helvetica-Bold" size:WidthRatio(30)];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(50));
        make.top.mas_equalTo(self.mas_top).offset(WidthRatio(25));
    }];
    
    UILabel *titleLabel1 = [UILabel new];
    titleLabel1.text = @"为您推荐更多美味";
    titleLabel1.textColor = HEX_COLOR(0xE3D5F9);
    titleLabel1.font  = [UIFont systemFontOfSize:WidthRatio(20)];
    [self addSubview:titleLabel1];
    [titleLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(WidthRatio(52));
        make.centerY.equalTo(titleLabel);
    }];
    
    
    JXCategoryTitleView *titleCategoryView = [[JXCategoryTitleView alloc] init];
    titleCategoryView.titleColor = HEX_COLOR(0xcc9af1);
    titleCategoryView.titleSelectedColor = [UIColor whiteColor];
    titleCategoryView.titleColorGradientEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 20;
    lineView.indicatorLineViewColor = [UIColor whiteColor];
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    titleCategoryView.indicators = @[lineView];

    [self addSubview:titleCategoryView];
    [titleCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(49));
        make.top.mas_equalTo(self.mas_top).offset(HeightRatio(117));
        make.right.mas_equalTo(self.mas_right).offset(-HeightRatio(49));
        make.height.mas_equalTo(HeightRatio(51));
    }];
    titleCategoryView.delegate = self;
    
    titleCategoryView.titles = @[@"螃蟹", @"麻辣小龙虾", @"苹果", @"营养胡萝卜", @"葡萄", @"美味西瓜", @"香蕉", @"香甜菠萝", @"鸡肉", @"鱼", @"海星"];
    [titleCategoryView reloadData];
}

@end
