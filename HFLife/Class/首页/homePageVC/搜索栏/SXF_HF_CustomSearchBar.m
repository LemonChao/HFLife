//
//  SXF_HF_CustomSearchBar.m
//  HFLife
//
//  Created by mac on 2019/5/7.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_CustomSearchBar.h"
#import "customItemView.h"
@interface SXF_HF_CustomSearchBar()

@property (nonatomic, strong)UIView *searchBgView;
@property (nonatomic, strong)UIImageView *searchImageV;
@property (nonatomic, strong)UILabel *seatchTitle;

@property (nonatomic, strong)UIView *btnBgView;
@property (nonatomic, strong)NSMutableArray *btnArrM;
@end



@implementation SXF_HF_CustomSearchBar
{
    NSArray *_imageViewArr;
}
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
    self.seatchTitle    = [UILabel new];
    self.searchBgView   = [UIView new];
    self.searchImageV   = [UIImageView new];
    self.btnBgView      = [UIView new];
    
    [self addSubview:self.searchBgView];
    [self addSubview:self.btnBgView];
    [self.searchBgView addSubview:self.searchImageV];
    [self.searchBgView addSubview:self.seatchTitle];
    
    self.seatchTitle.font = MyFont(13);
    self.seatchTitle.textColor = [UIColor colorWithHexString:@"#1D1B1B"];
    self.seatchTitle.text = @"搜索";
    
    self.searchImageV.image = [UIImage imageNamed:@"搜索"];
    self.searchBgView.backgroundColor =  HEX_COLOR(0xF5F5F5);
    self.searchBgView.layer.cornerRadius = 4;
    self.searchBgView.layer.masksToBounds = YES;
    self.searchImageV.contentMode = UIViewContentModeScaleAspectFit;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSearchView:)];
    [self.searchBgView addGestureRecognizer:tap];
    self.searchBgView.tag = 4;
    
    
    _imageViewArr = @[@"扫一扫", @"fukuan", @"shouqian", @"我的卡包"];
    self.btnArrM = [NSMutableArray array];
    for (int i = 0; i < _imageViewArr.count; i++) {
        UIButton *btn = [UIButton new];
        btn.tag = i;
        [self.btnBgView addSubview:btn];
        [self.btnArrM addObject:btn];
        [btn setImage:MY_IMAHE(_imageViewArr[i]) forState:UIControlStateNormal];
        [btn setTitle:@"" forState:UIControlStateNormal];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn addTarget:self action:@selector(clickItemBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.btnBgView.backgroundColor = [UIColor clearColor];
    self.btnBgView.alpha = 0.0f;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenSearchBar:) name:@"hiddenSearchBar" object:nil];
    
    
    
}
- (void)hiddenSearchBar:(NSNotification *)notifi{
//    NSLog(@"%@", notifi.object);
    self.searchBgView.alpha = [notifi.object floatValue];
    self.btnBgView.alpha = 1-[notifi.object floatValue];
    //透明度低于0.5不交互
    self.searchBgView.userInteractionEnabled = self.searchBgView.alpha <= 0.5 ? NO : YES;
    self.btnBgView.userInteractionEnabled = self.btnBgView.alpha <= 0.5 ? NO : YES;
}
- (void) tapSearchView:(UITapGestureRecognizer *)tap{
    !self.topBarBtnClick ? : self.topBarBtnClick(tap.view.tag);
}
- (void)clickItemBtn:(UIButton *)sender{
    !self.topBarBtnClick ? : self.topBarBtnClick(sender.tag);
}
- (void)layoutSubviews{
    [super layoutSubviews];
     
    [self.searchBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(8);
        make.bottom.mas_equalTo(self).offset(-8);
        make.left.mas_equalTo(self).offset(12);
        make.right.mas_equalTo(self).offset(-12);
    }];
    [self.btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).offset(8);
        make.bottom.mas_equalTo(self).offset(-8);
        make.left.mas_equalTo(self).offset(12);
        make.width.mas_equalTo(self.searchBgView.mas_width).multipliedBy(0.6);
    }];
    [self.searchImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.searchBgView.mas_left).offset(12);
        make.top.bottom.mas_equalTo(self.searchBgView);
        make.width.mas_equalTo(13);
    }];
     
     [self.seatchTitle mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(self.searchImageV.mas_right).offset(9);
         make.centerY.mas_equalTo(self.searchImageV.mas_centerY);
     }];
    
    //对数组进行布局
//    [self.btnArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:ScreenScale(30) leadSpacing:0 tailSpacing:0];
    [self.btnArrM mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    [self.btnArrM mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.btnBgView.mas_top).offset(ScreenScale(5));
        make.bottom.mas_equalTo(self.btnBgView.mas_bottom).offset(ScreenScale(-5));
//        make.width.mas_equalTo(ScreenScale(30));
    }];
    
    
}

@end
