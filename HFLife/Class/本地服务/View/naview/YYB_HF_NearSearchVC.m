//
//  YYB_HF_NearSearchVC.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "YYB_HF_NearSearchVC.h"
#import "XPCollectionViewWaterfallFlowLayout.h"
#import "baseCollectionView.h"
@interface YYB_HF_NearSearchVC ()<XPCollectionViewWaterfallFlowLayoutDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong) baseCollectionView *collectionView;
@property (nonatomic ,strong) XPCollectionViewWaterfallFlowLayout *layout;

@end

@implementation YYB_HF_NearSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavBar];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
    WEAK(weakSelf)
    self.collectionView.refreshHeaderBlock = ^{
        [weakSelf.collectionView endRefreshData];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.collectionView reloadData];
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    //    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"NearFoodSousuo"]];
    //    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    //    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"搜索";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[baseCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    }
    return _collectionView;
}
- (XPCollectionViewWaterfallFlowLayout *)layout{
    if (!_layout) {
        _layout = [[XPCollectionViewWaterfallFlowLayout alloc] init];
        
        // 头部视图悬停
        //        XPCollectionViewWaterfallFlowLayout *layout = (XPCollectionViewWaterfallFlowLayout *)self.collectionView.collectionViewLayout;
        //        layout.sectionHeadersPinToVisibleBounds = NO;
        
        _layout.sectionHeadersPinToVisibleBounds = NO;//不悬停
        _layout.dataSource = self;//设置数据源代理
    }
    return _layout;
}

#pragma mark - collctionview


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor brownColor];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


#pragma mark - XPCollectionViewWaterfallFlowLayout

/// 列数
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout numberOfColumnInSection:(NSInteger)section {
    return 2;
}
/// item高度
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout itemWidth:(CGFloat)width
 heightForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 100;
        
    }
    return 10;
}

/// 列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
/// 行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}
///
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
/// Return per section header view height.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout referenceHeightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}
/// Return per section footer view height.
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(XPCollectionViewWaterfallFlowLayout*)layout referenceHeightForFooterInSection:(NSInteger)section {
    return 10;
}




/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
