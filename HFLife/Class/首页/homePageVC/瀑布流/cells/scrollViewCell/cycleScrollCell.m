//
//  cycleScrollCell.m
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import "cycleScrollCell.h"
#import "LWDPageControl.h"
#import "SDCycleScrollView.h"
@interface cycleScrollCell ()< SDCycleScrollViewDelegate>

@property (nonatomic ,strong) LWDPageControl *pageControl;
@property (nonatomic , assign) NSInteger nums;//个数

@property (nonatomic ,strong) SDCycleScrollView *cycleScroll;
@end

@implementation cycleScrollCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
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
    self.nums = _modelArr.count;

    self.pageControl.numberOfPages = self.nums;
    self.cycleScroll.imageURLStringsGroup = @[@"http://img0.imgtn.bdimg.com/it/u=260329114,3367670618&fm=26&gp=0.jpg", @"http://img1.3lian.com/img013/v5/21/d/84.jpg", @"http://img1.imgtn.bdimg.com/it/u=2917799186,1224386513&fm=26&gp=0.jpg"];
    [self addPageControl];
    
}


- (void)setPausePlay:(BOOL)pausePlay{
    _pausePlay = pausePlay;
    
//    self.cycleV.pausePlay = _pausePlay;
    
}




- (void) addPageControl{
    [self.contentView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cycleScroll.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(5);
    }];
    self.pageControl.backgroundColor = [UIColor whiteColor];
}




- (void) addChildrenViews{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.pageControl];
    
    [self.contentView addSubview:self.cycleScroll];
    self.cycleScroll.layer.cornerRadius = ScreenScale(5);
    self.cycleScroll.layer.masksToBounds = YES;
    self.cycleScroll.clipsToBounds = YES;

    

}

- (void)currentPageChanged:(LWDPageControl *)pageControl{
    //点击小点
}


#pragma maek customCycleViewDelegate


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    !self.selectItemBlock ? : self.selectItemBlock(index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.pageControl.currentPage = index;
}







- (void)layoutSubviews{
    [super layoutSubviews];
    
   
    
    
    [self.cycleScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(6));
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cycleScroll.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(5));
    }];
    
}
//- (customCycleView *)cycleV{
//    if (!_cycleV) {
//        _cycleV = [[customCycleView alloc] init];
//    }
//    return _cycleV;
//}

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

//广告位
-(SDCycleScrollView *)cycleScroll{
    if (_cycleScroll == nil) {
        _cycleScroll = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"banner"]];
        _cycleScroll.isCustom = YES;
        _cycleScroll.distance = HeightRatio(47);
        _cycleScroll.delegate = self;
        _cycleScroll.tag = -4000;
        _cycleScroll.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
        _cycleScroll.imageURLStringsGroup = @[];
        _cycleScroll.showPageControl = NO;
    }
    return _cycleScroll;
}


@end
