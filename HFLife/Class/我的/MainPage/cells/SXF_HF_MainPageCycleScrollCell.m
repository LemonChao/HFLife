//
//  SXF_HF_MainPageCycleScrollCell.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_MainPageCycleScrollCell.h"
#import "customCycleView.h"//自定义轮播
#import "SXF_HF_CycleContentCell.h"
#import "LWDPageControl.h"

@interface SXF_HF_MainPageCycleScrollCell ()<customCycleViewDelegate>

@property (nonatomic ,strong) customCycleView *cycleV;
@property (nonatomic ,strong) LWDPageControl *pageControl;
@property (nonatomic , assign) NSInteger nums;//个数

@property (nonatomic, strong)UIImageView *animImageV;
@end

@implementation SXF_HF_MainPageCycleScrollCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}


- (void)setModelArr:(NSArray *)modelArr{
    _modelArr = modelArr;
    if (self.pageControl) {
        [self.pageControl removeFromSuperview];
        self.pageControl = nil;
    }
    //刷新轮播图
    self.cycleV.dataSourceArr = _modelArr;
    self.nums = self.cycleV.dataSourceArr.count;
    self.cycleV.pageNumbers = self.nums;
    self.pageControl.numberOfPages = self.nums;
    [self.cycleV refreshData];
//    [self addPageControl];
    
}

- (void) addPageControl{
    [self.contentView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cycleV.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(5);
    }];
    self.pageControl.backgroundColor = [UIColor whiteColor];
    self.pageControl.hidden = YES;
}




- (void) addChildrenViews{
    self.backgroundColor = rgb(245.0, 245.0, 245.0);
    
    [self.contentView addSubview:self.cycleV];
    [self.contentView addSubview:self.pageControl];
    
    self.cycleV.backgroundColor = rgb(245.0, 245.0, 245.0);
    
    self.animImageV = [[UIImageView alloc] init];
    self.animImageV.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.animImageV];
    self.animImageV.backgroundColor = [UIColor clearColor];
    
    self.cycleV.backgroundColor = [UIColor clearColor];
    self.cycleV.scrollStyle = CWCarouselStyle_H_4;
    self.cycleV.pageControlHidden = YES;//默认NO
    self.cycleV.openCustomPageControl = NO;
    self.cycleV.pageNumbers = self.nums;
    self.cycleV.delegate = self;
    //    self.cycleV.canAutoScroll = YES;//不自动轮播
    self.cycleV.cellClass = NSStringFromClass([SXF_HF_CycleContentCell class]);
    [self layoutIfNeeded];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.cycleV startAnimationView];
    });
}

- (void)currentPageChanged:(LWDPageControl *)pageControl{
    //点击小点
}


#pragma maek customCycleViewDelegate

- (void)selectIndex:(NSInteger)index{
    //滚动到
    self.pageControl.currentPage = index;
    //在当前cell播放动画
    NSString *iamgePath = [[NSBundle mainBundle] pathForResource:@"余额" ofType:@"gif"];
    
    

//    NSData  *imageData = [NSData dataWithContentsOfFile:iamgePath];
//    self.animImageV.image = [UIImage sd_animatedGIFWithData:imageData];
    
    
    
    [self.animImageV playGifImagePath:iamgePath repeatCount:1];
    !self.autoScrollItemBlock ? : self.autoScrollItemBlock(index);
}
//点击item
- (void)clickItemFromIndex:(NSInteger)index{
    !self.selectItemBlock ? : self.selectItemBlock(index);
    !self.autoScrollItemBlock ? : self.autoScrollItemBlock(index);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cycleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(5));
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(0));
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-0));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(-5));
    }];
    
    [self.animImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.contentView.mas_centerX);
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(100));
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
        make.width.mas_equalTo(ScreenScale(183));
    }];
    
}
- (customCycleView *)cycleV{
    if (!_cycleV) {
        _cycleV = [[customCycleView alloc] init];
    }
    return _cycleV;
}

- (LWDPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[LWDPageControl alloc] initWithFrame:CGRectMake(0, ScreenScale(100 - 80), SCREEN_WIDTH, 15) indicatorMargin:7.f indicatorWidth:6.f currentIndicatorWidth:6.f indicatorHeight:6];
        _pageControl.numberOfPages = self.nums;
        _pageControl.currentPageIndicatorColor = HEX_COLOR(0xCA1400);
        _pageControl.pageIndicatorColor = HEX_COLOR(0xCA1400);
        [_pageControl addTarget:self action:@selector(currentPageChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _pageControl;
}



@end

