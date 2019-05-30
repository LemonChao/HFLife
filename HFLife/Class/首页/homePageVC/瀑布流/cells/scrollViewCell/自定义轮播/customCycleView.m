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
//自定义cell
#import "bannerCollectionViewCell.h"
#import "SXF_HF_CycleContentCell.h"
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
    }else{
        
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
    
    if ([self.cellClass isEqualToString:NSStringFromClass([bannerCollectionViewCell class])]) {
         [self.carousel registerViewClass:[bannerCollectionViewCell class] identifier:NSStringFromClass([bannerCollectionViewCell class])];
    }else if ([self.cellClass isEqualToString:NSStringFromClass([SXF_HF_CycleContentCell class])]){
        [self.carousel registerViewClass:[SXF_HF_CycleContentCell class] identifier:NSStringFromClass([SXF_HF_CycleContentCell class])];
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
    if ([self.cellClass isEqualToString:NSStringFromClass([bannerCollectionViewCell class])]) {
        bannerCollectionViewCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([bannerCollectionViewCell class]) forIndexPath:indexPath];
        if (self.dataSourceArr.count - 1 >= index) {
            //        [cell setModelForCell:self.dataSourceArr[index] index:index];
        }
        
        cell.contentView.backgroundColor = [UIColor whiteColor];
        return cell;
    }else if ([self.cellClass isEqualToString:NSStringFromClass([SXF_HF_CycleContentCell class])]){
        SXF_HF_CycleContentCell *cell = [carousel.carouselView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SXF_HF_CycleContentCell class]) forIndexPath:indexPath];
        
        //给cell复制
//        NSLog(@"%ld   ---   %lf", indexPath.row, indexPath.section);
        mainScrollModel *model = self.dataSourceArr[index];
        cell.titleLb.text = model.title;
        cell.subTitleLb.text = model.subTitle;
        cell.moneyLb.text = model.money;
        if (index == 0) {
            cell.bgImageV.image = MY_IMAHE(@"bg余额");
        }else if (index == 1){
            cell.bgImageV.image = MY_IMAHE(@"bg可兑换富权");
        }else if(index == 2){
            cell.bgImageV.image = MY_IMAHE(@"bg富权");
        }
        
        return cell;
    }
    

    
    return nil;
    
    
}


- (void)setPausePlay:(BOOL)pausePlay{
    _pausePlay = pausePlay;
    if (_pausePlay) {
        //暂停
        [self.carousel pause];
    }else{
        //开始
        [self.carousel resumePlay];//暂停后继续播放
    }
}

//点击
- (void)CWCarousel:(CWCarousel *)carousel didSelectedAtIndex:(NSInteger)index {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickItemFromIndex:)]) {
        [self.delegate clickItemFromIndex:index];
    }
}

//点击item
- (void)clickItemAtindex:(NSInteger)index{
//    NSLog(@"点击的item是    %ld", index);
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickItemFromIndex:)]) {
        [self.delegate clickItemFromIndex:index];
    }
}




- (void)CWCarousel:(CWCarousel *)carousel didStartScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
//    NSLog(@"开始滑动: %ld", index);
}


- (void)CWCarousel:(CWCarousel *)carousel didEndScrollAtIndex:(NSInteger)index indexPathRow:(NSInteger)indexPathRow {
//    NSLog(@"结束滑动: %ld", index);
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectIndex:)]) {
        [self.delegate selectIndex:index];
    }
}







- (void)dealloc{
    [self.carousel controllerWillDisAppear];
}

@end
