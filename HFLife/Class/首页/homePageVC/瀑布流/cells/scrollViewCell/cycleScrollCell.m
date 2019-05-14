//
//  cycleScrollCell.m
//  News
//
//  Created by 史小峰 on 2019/5/8.
//

#import "cycleScrollCell.h"
#import "customCycleView.h"//自定义轮播
#import "bannerCollectionViewCell.h"
#import "LWDPageControl.h"

@interface cycleScrollCell ()<customCycleViewDelegate>

@property (nonatomic ,strong) customCycleView *cycleV;
@property (nonatomic ,strong) LWDPageControl *pageControl;
@property (nonatomic , assign) NSInteger nums;//个数
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
    self.cycleV.dataSourceArr = _modelArr;
    self.nums = self.cycleV.dataSourceArr.count;
    self.cycleV.pageNumbers = self.nums;
    self.pageControl.numberOfPages = self.nums;
    [self.cycleV refreshData];
    [self addPageControl];
    
}


- (void)setPausePlay:(BOOL)pausePlay{
    _pausePlay = pausePlay;
    
    self.cycleV.pausePlay = _pausePlay;
    
}




- (void) addPageControl{
    [self.contentView addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cycleV.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(5);
    }];
    self.pageControl.backgroundColor = [UIColor whiteColor];
}




- (void) addChildrenViews{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.cycleV];
    [self.contentView addSubview:self.pageControl];
    
    
    self.cycleV.backgroundColor = [UIColor clearColor];
    self.cycleV.scrollStyle = CWCarouselStyle_Normal;
    self.cycleV.pageControlHidden = YES;//默认NO
    self.cycleV.openCustomPageControl = NO;
    self.cycleV.pageNumbers = self.nums;
    self.cycleV.delegate = self;
    //    self.cycleV.canAutoScroll = YES;//不自动轮播
    self.cycleV.cellClass = NSStringFromClass([bannerCollectionViewCell class]);
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
    //    NSLog(@"滚动到section3  %ld", index);
    self.pageControl.currentPage = index;
}
//点击item
- (void)clickItemFromIndex:(NSInteger)index{
    !self.selectItemBlock ? : self.selectItemBlock(index);
}


- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.cycleV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.contentView);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(-15);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.cycleV.mas_bottom);
        make.bottom.mas_equalTo(self.contentView.mas_bottom).offset(ScreenScale(5));
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
