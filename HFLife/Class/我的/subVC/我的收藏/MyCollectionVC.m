//
//  MyCollectionVC.m
//  HanPay
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "MyCollectionVC.h"
#import "JXCategoryView.h"
#import "LocalMallCollectionVC.h"
#import "GoodsCollectionVC.h"
@interface MyCollectionVC ()<UIScrollViewDelegate,JXCategoryViewDelegate>
@property (nonatomic, strong)JXCategoryTitleView *myCategoryView;
@property (nonatomic,strong)UIScrollView *containerScrollView;
@property (nonatomic, strong) NSMutableArray *listVCArray;
@end

@implementation MyCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = HEX_COLOR(0xf4f9f9);
     self.listVCArray  = [NSMutableArray array];
    [self _setupChildController];
    [self initWithUI];
    [self setupNavBar];
    [self categoryView:self.myCategoryView didSelectedItemAtIndex:0];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhuianniu"]];
//    [self.customNavBar wr_setRightButtonWithTitle:@"管理" titleColor:[UIColor whiteColor]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"myOrderBG"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        LocalMallCollectionVC *vc = (LocalMallCollectionVC *)weakSelf.listVCArray[0];
        vc.editing = !vc.editing;
        [weakSelf categoryView:weakSelf.myCategoryView didSelectedItemAtIndex:1];
        GoodsCollectionVC *goodsVC = (GoodsCollectionVC *)weakSelf.listVCArray[1];
        goodsVC.editing = !goodsVC.editing;
        
//        if (vc.editing) {
//            [weakSelf.customNavBar wr_setRightButtonWithTitle:@"完成" titleColor:[UIColor whiteColor]];
//        }else{
//            [weakSelf.customNavBar wr_setRightButtonWithTitle:@"管理" titleColor:[UIColor whiteColor]];
//        }
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"我的收藏";
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
}
-(void)initWithUI{
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(HeightRatio(100)+self.navBarHeight);
    }];
    
    
    JXCategoryTitleView *titleCategoryView = self.myCategoryView;
    _myCategoryView.titleColor = [UIColor blackColor];
    _myCategoryView.titleSelectedColor = HEX_COLOR(0x8E3DF1);
    titleCategoryView.titleColorGradientEnabled = YES;
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineWidth = 20;
    lineView.indicatorLineViewColor = HEX_COLOR(0x8E3DF1);
    lineView.lineStyle = JXCategoryIndicatorLineStyle_JD;
    titleCategoryView.indicators = @[lineView];
    self.myCategoryView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.myCategoryView];
    self.myCategoryView.frame = CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, HeightRatio(88));
    [self.myCategoryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
        make.height.mas_equalTo(HeightRatio(100));
    }];
    self.myCategoryView.delegate = self;
    self.myCategoryView.titles = @[@"商家收藏",@"商城收藏"];
    self.myCategoryView.contentScrollView = self.containerScrollView;
    
    
    
}
#pragma mark JXCategoryViewDelegate 滑动菜单代理
//点击选中或者滚动选中都会调用该方法。适用于只关心选中事件，不关心具体是点击还是滚动选中的。
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
        //侧滑手势处理
        //    if (_shouldHandleScreenEdgeGesture) {
        //        self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);
        //    }
    NSLog(@"1111");
    if (index >= self.listVCArray.count) {
        return;
    }
    UIViewController *willShowVc = self.listVCArray[index];
    
        // 如果当前位置的位置已经显示过了，就直接返回，这里是小细节，其实同一个view被添加N次 == 添加一次
    if ([willShowVc isViewLoaded]) return;
    willShowVc.view.mh_x = index * SCREEN_WIDTH;
    willShowVc.view.mh_y = 0; // 设置控制器view的y值为0(默认是20)
    willShowVc.view.mh_width = SCREEN_WIDTH;
    willShowVc.view.mh_height = self.containerScrollView.mh_height; // 设置控制器view的height值为整个屏幕的高度(默认是比屏幕高度少个20)
    [self.containerScrollView addSubview:willShowVc.view];
}

#pragma mark 懒加载
- (JXCategoryTitleView *)myCategoryView {
    if (_myCategoryView == nil) {
        _myCategoryView = [[[JXCategoryTitleView class] alloc] init];
        _myCategoryView.delegate = self;
        _myCategoryView.backgroundColor = [UIColor whiteColor];
    }
    return _myCategoryView;
}
-(UIScrollView *)containerScrollView{
    if (!_containerScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.delegate = self;
        scrollView.pagingEnabled = YES;
        scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*2,scrollView.height);
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        _containerScrollView = scrollView;
    }
    return _containerScrollView;
}
- (void)_setupChildController{
    LocalMallCollectionVC *listVC = [[LocalMallCollectionVC alloc] init];
//    listVC.orderState = i;
    [self addChildViewController:listVC];
    [self.listVCArray addObject:listVC];
    
    GoodsCollectionVC *goodsVC = [[GoodsCollectionVC alloc] init];
        //    listVC.orderState = i;
    [self addChildViewController:goodsVC];
    [self.listVCArray addObject:goodsVC];
}
@end
