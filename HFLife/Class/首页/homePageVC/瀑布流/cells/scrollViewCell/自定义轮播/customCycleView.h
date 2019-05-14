//
//  customCycleView.h
//  sxf_自定义pageControl
//
//  Created by sxf_pro on 2018/11/12.
//  Copyright © 2018年 sxf_pro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWCarousel.h"

@protocol customCycleViewDelegate <NSObject>
- (void) selectIndex:(NSInteger)index;
- (void) clickItemFromIndex:(NSInteger)index;//点击
- (void) clickCustomBtn:(UIButton *)sender index:(NSInteger) index;
@end


@interface customCycleView : UIView
@property (nonatomic ,strong) NSArray *dataSourceArr;//数据源
@property (nonatomic ,assign) CWCarouselStyle scrollStyle;//滚动样式
@property (nonatomic ,assign) BOOL pageControlHidden;//是否显示pagecontrol 默认NO

@property (nonatomic ,strong) NSString *cellClass;
@property (nonatomic, assign) BOOL openCustomPageControl;//是否显示自定义
@property (nonatomic ,assign) NSInteger pageNumbers;
@property (nonatomic, weak) id<customCycleViewDelegate>delegate;
@property (nonatomic, assign)BOOL pausePlay;//暂停、开启

//开启动画
- (void) startAnimationView;
- (void) refreshData;//刷新数据
@end
