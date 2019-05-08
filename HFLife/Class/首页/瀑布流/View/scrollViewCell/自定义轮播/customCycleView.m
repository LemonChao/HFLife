//
//  customCycleView.m
//  sxf_自定义pageControl
//
//  Created by sxf_pro on 2018/11/12.
//  Copyright © 2018年 sxf_pro. All rights reserved.
//

#define kViewTag 666
#define kCount 5
#import "customCycleView.h"
#import "privilageCollectionViewCell.h"
#import "CWPageControl.h"//自定义pageControll

@interface customCycleView()<CWCarouselDatasource, CWCarouselDelegate>
@property (nonatomic ,strong) CWPageControl *control;
@property (nonatomic, strong) CWCarousel *carousel;

@property (nonatomic ,assign) NSInteger count;

@end



@implementation customCycleView

- (instancetype)init{
    if (self = [super init]) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) startAnimationView{
    [self addChildrenViews];
}

- (void)setPageNumbers:(NSInteger)pageNumbers{
    _pageNumbers = pageNumbers;
    self.count = pageNumbers;
}

//数据源
- (void)setDataSourceArr:(NSArray *)dataSourceArr{
    _dataSourceArr = dataSourceArr;
    [self refreshData];
}

- (void) refreshData{
    [self.carousel freshCarousel];
}



//添加
- (void)addChildrenViews{
    
    //样式
    CWFlowLayout *flowLayout = [[CWFlowLayout alloc] initWithStyle:self.scrollStyle];
    if ([self.cellClass isEqualToString:@"KanjiaCollectionViewCell"]) {
//        flowLayout.itemSpace_H = 1;
        flowLayout.itemWidth = self.frame.size.width - 60;
    }
    self.carousel = [[CWCarousel alloc] initWithFrame:self.bounds delegate:self datasource:self flowLayout:flowLayout];
    self.carousel.isAuto = YES;
    self.carousel.autoTimInterval = 2;
    self.carousel.endless = YES;
    self.carousel.backgroundColor = [UIColor clearColor];
    
    
    if(self.openCustomPageControl) {
        CWPageControl *control = [[CWPageControl alloc] initWithFrame:CGRectMake(0, 0, 300, 20)];
        control.pageNumbers = self.pageNumbers;
        control.currentPage = 0;
        control.center = CGPointMake(self.centerX, self.frame.size.height + 33 * 0.5);
        self.control = control;
        self.carousel.customPageControl = control;
    }
    //注册cell
    
    if ([self.cellClass isEqualToString:NSStringFromClass([privilageCollectionViewCell class])]) {
         [self.carousel registerViewClass:[privilageCollectionViewCell class] identifier:@"cellId"];
    }
    
    
    self.carousel.pageControl.hidden = self.pageControlHidden;
    [self.carousel freshCarousel];
    //开启滚动
    [self.carousel controllerWillAppear];
    
    [self addSubview:self.carousel];
}
- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void)setPageControlHidden:(BOOL)pageControlHidden{
    _pageControlHidden = pageControlHidden;
    self.carousel.pageControl.hidden = pageControlHidden;
}


- (NSInteger)numbersForCarousel {
    return self.dataSourceArr.count;
}

#pragma mark - Delegate
- (UICollectionViewCell *)viewForCarousel:(CWCarousel *)carousel indexPath:(NSIndexPath *)indexPath index:(NSInteger)index{
    if ([self.cellClass isEqualToString:NSStringFromClass([privilageCollectionViewCell class])]) {
        
    }
    
    privilageCollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    if (self.dataSourceArr.count - 1 >= index) {
//        [cell setModelForCell:self.dataSourceArr[index] index:index];
    }
    
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
    
    return nil;
    
    
}

- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:index];
    }
}

//点击item
- (void)clickItemAtindex:(NSInteger)index{
//    NSLog(@"点击的item是    %ld", index);
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickItemFromIndex:)]) {
        [self.delegate clickItemFromIndex:index];
    }
}











- (void)dealloc{
    [self.carousel controllerWillDisAppear];
}

@end
