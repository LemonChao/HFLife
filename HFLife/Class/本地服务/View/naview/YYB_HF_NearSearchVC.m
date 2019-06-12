//
//  YYB_HF_NearSearchVC.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "YYB_HF_NearSearchVC.h"
#import "YYB_HF_HotSearchCollectionCell.h"
#import "YYb_HF_CollReusableView.h"
#import "YYB_HF_SearchHeadView.h"
#import "YYB_HF_SearchResultC.h"
@interface YYB_HF_NearSearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *layout;
@property(nonatomic, strong) NSArray *searArr;//热门搜索数组
@property(nonatomic, strong) YYB_HF_SearchHeadView *headView;

@property(nonatomic, copy) NSString *searchType;//热搜类型
@end

@implementation YYB_HF_NearSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    YYB_HF_SearchHeadView *headView = [[YYB_HF_SearchHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NavBarHeight)];
    [self.view addSubview:headView];
    self.headView = headView;
    
    self.searchType = @"1";
    WEAK(weakSelf)
    self.headView.backClick = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    weakSelf.headView.setTypeStr = @"美食";
    self.headView.typeSelect = ^{
        NSArray *arr = @[@"美食",@"酒店"];
        
        ZHB_HP_PreventWeChatPopout *check = [[ZHB_HP_PreventWeChatPopout alloc]initWithTitle:@"选择搜索类型" cancelButtonTitle:@"取消" destructiveButtonTitle:weakSelf.headView.setTypeStr otherButtonTitles:arr actionSheetBlock:^(NSInteger index) {
            weakSelf.headView.setTypeStr = arr[index];
            NSString *typeStr = arr[index];
            NSString *searType;
            if ([typeStr isEqualToString:@"美食"]) {
                searType = @"1";
            }else if ([typeStr isEqualToString:@"酒店"]){
                searType = @"2";
            }
            if (![weakSelf.searchType isEqualToString:searType]) {
                weakSelf.searchType = searType;
                [weakSelf getData];
            }
        }];
        [check show];
    };
    self.headView.setSearchStr = self.searchStrDe;
    self.headView.searchClick = ^{
        YYB_HF_SearchResultC *vc = [[YYB_HF_SearchResultC alloc]init];
        vc.searchType = weakSelf.searchType;
        vc.searchStr = weakSelf.headView.searchT.text;
        
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    
    

    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headView.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
        
    self.searArr = @[@"xxxx",@"xxx",@"xx",@"x"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self.customNavBar setHidden:YES];
    [self getData];
    
}

- (void)getData {
    [[WBPCreate sharedInstance]showWBProgress];
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kGetHotSearchList withParameters:@{@"type":_searchType} withResultBlock:^(BOOL result, id value) {
        [[WBPCreate sharedInstance]hideAnimated];
        if (result) {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                NSArray *dataArr = value[@"data"];
                if (dataArr && [dataArr isKindOfClass:[NSArray class]]) {
                    self.searArr = dataArr;
                    [self.collectionView reloadData];
                }
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络错误"];
            }
            self.searArr = nil;
            [self.collectionView reloadData];
        }
    }];
}



- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[YYB_HF_HotSearchCollectionCell class] forCellWithReuseIdentifier:@"YYB_HF_HotSearchCollectionCell"];
        [_collectionView registerClass:[YYb_HF_HotCollReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YYb_HF_HotCollReusableView"];
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout =  [[UICollectionViewFlowLayout alloc] init];
        double width = (self.view.width - ScreenScale(10)*6) / 5.0;
        _layout.itemSize = CGSizeMake(width, ScreenScale(60));
        _layout.minimumLineSpacing = ScreenScale(10);
        _layout.minimumInteritemSpacing = ScreenScale(30);

        
        // 头部视图悬停
        //        XPCollectionViewWaterfallFlowLayout *layout = (XPCollectionViewWaterfallFlowLayout *)self.collectionView.collectionViewLayout;
        //        layout.sectionHeadersPinToVisibleBounds = NO;
        
        _layout.sectionHeadersPinToVisibleBounds = NO;//不悬停
    }
    return _layout;
}

#pragma mark - collctionview


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYB_HF_HotSearchCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYB_HF_HotSearchCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.title.text = self.searArr[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    YYB_HF_SearchResultC *vc = [[YYB_HF_SearchResultC alloc]init];
    vc.searchType = self.searchType;
    vc.searchStr = [self.searchType isEqualToString:@"1"] ? @"美食" : @"酒店";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searArr.count;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    double width = [self fitWidth:self.searArr[indexPath.row]];
    return CGSizeMake(width, ScreenScale(30));
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(5, 10, 5, 10);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 && self.searArr.count > 0) {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }else {
        return CGSizeZero;
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = (kind==UICollectionElementKindSectionHeader) ? @"YYb_HF_HotCollReusableView" : @"foot";
    YYb_HF_HotCollReusableView *view = (YYb_HF_HotCollReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    view.backgroundColor = [UIColor whiteColor];
    view.textLabel.text = @"热门搜索";
    if (kind == UICollectionElementKindSectionFooter) {
        view.hidden = YES;
    }else{
        if (indexPath.section != 0) {
            view.hidden = YES;
        }else{
            view.hidden = NO;
            if (self.searArr.count == 0) {
                view.hidden = YES;
            }
        }
    }
    
    return view;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}


//获取文本宽度
- (CGFloat)fitWidth:(NSString *)str {
    CGSize size = [str sizeWithAttributes:[NSDictionary dictionaryWithObjectsAndKeys:FONT(15),NSFontAttributeName, nil]];
    return size.width + 1;
}


@end
