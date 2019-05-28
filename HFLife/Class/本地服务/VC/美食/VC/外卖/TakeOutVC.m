//
//  TakeOutVC.m
//  HanPay
//
//  Created by 张海彬 on 2019/2/14.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "TakeOutVC.h"
#import "TableHeaderView.h"
#import "WaimaiCycleCell.h"
#import "WaimaiYouxuanCell.h"
#import "WaimaiRecommendCell.h"
#import "WaimaiZhiquCell.h"
#import "ContainerTableHeader.h"
#import "NearbyShopVC.h"

#define TableHeight (SCREEN_HEIGHT-NavBarHeight-HomeIndicatorHeight)


@interface TakeOutVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL canMove;
}
/** 定位栏*/
@property (nonatomic, strong) UIButton *addressButton;
@property(nonatomic, strong) UIButton *searchBtn;
@property(nonatomic,strong) UIScrollView *containerScrollView;

/** 容器TableView*/
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic, strong) UITableView *subTableView;

@property(nonatomic, strong) UIView *contentView;



@end

static NSString *cycleCellid = @"WaimaiCycleCell_id";
static NSString *youxuanCellid = @"youxuanCycleCell_id";
static NSString *recommendCellid = @"recommendCycleCell_id";
static NSString *zhiquCellid = @"zhiquCell_id";
static NSString *sectionHeadid = @"ContainerTableHeader";


@implementation TakeOutVC
{
    CGFloat _lastTableViewContentHeight;
    CGFloat _lastsubTableViewContentHeight;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"beijing_waimai"] forBarMetrics:UIBarMetricsDefault];

    [self setupNavigationItem];
    [self configViews];
    [self addObservers];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)configViews {
    [self.view addSubview:self.containerScrollView];
    [self.containerScrollView addSubview:self.contentView];
    [self.contentView addSubview:self.tableView];
    
    NearbyShopVC *nearbyShopVC = [NearbyShopVC new];
    nearbyShopVC.tableView.frame = CGRectMake(0, TableHeight, SCREEN_WIDTH, TableHeight);
    [self addChildViewController:nearbyShopVC];
    [self.contentView addSubview:nearbyShopVC.tableView];
    self.subTableView = nearbyShopVC.tableView;
    
    self.contentView.frame = CGRectMake(0, 0, self.view.width, TableHeight * 2);
    self.tableView.top = 0;
    self.tableView.height = self.view.height;
    self.subTableView.top = self.tableView.bottom;
}


#pragma mark - Observers
- (void)addObservers{
    [self.subTableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers{
    [self.subTableView removeObserver:self forKeyPath:@"contentSize"];
    [self.tableView removeObserver:self forKeyPath:@"contentSize"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (object == self.subTableView) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            NSLog(@"subTable-change:%@", change);
            
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }else if(object == _tableView) {
        if ([keyPath isEqualToString:@"contentSize"]) {
            NSLog(@"superTable-change:%@", change);
            
            [self updateContainerScrollViewContentSize:0 webViewContentHeight:0];
        }
    }
}

- (void)updateContainerScrollViewContentSize:(NSInteger)flag webViewContentHeight:(CGFloat)inWebViewContentHeight {
    
    CGFloat tableViewContentHeight = flag==1 ?inWebViewContentHeight :self.tableView.contentSize.height;
    CGFloat subTableViewContentHeight = self.subTableView.contentSize.height;
    
    if (tableViewContentHeight == _lastTableViewContentHeight && subTableViewContentHeight == _lastsubTableViewContentHeight) {
        return;
    }
    
    _lastTableViewContentHeight = tableViewContentHeight;
    _lastsubTableViewContentHeight = subTableViewContentHeight;
    
    self.containerScrollView.contentSize = CGSizeMake(self.view.width, tableViewContentHeight + subTableViewContentHeight);
    
    CGFloat webViewHeight = (tableViewContentHeight < TableHeight) ?tableViewContentHeight :TableHeight ;
    CGFloat subTableHeight = subTableViewContentHeight < TableHeight ?subTableViewContentHeight :TableHeight;
    self.tableView.height = webViewHeight <= 0.1 ?0.1 :webViewHeight;
    self.contentView.height = webViewHeight + subTableHeight;
    self.subTableView.height = subTableHeight;
    self.subTableView.top = self.tableView.bottom;
    
    //Fix:contentSize变化时需要更新各个控件的位置
    [self scrollViewDidScroll:self.containerScrollView];
    
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (_containerScrollView != scrollView) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat tableViewHeight = self.tableView.height;
    CGFloat subTableHeight = self.subTableView.height;
    
    CGFloat tableViewContentHeight = self.tableView.contentSize.height;
    CGFloat subTableViewContentHeight = self.subTableView.contentSize.height;
    if (offsetY <= 0) {//刚开始初始阶段
        self.contentView.top = 0;
        self.tableView.contentOffset = CGPointZero;
        self.subTableView.contentOffset = CGPointZero;
    }else if(offsetY < tableViewContentHeight - tableViewHeight){
        self.contentView.top = offsetY;
        self.tableView.contentOffset = CGPointMake(0, offsetY);
        self.subTableView.contentOffset = CGPointZero;
    }else if(offsetY < tableViewContentHeight){
        self.contentView.top = tableViewContentHeight - tableViewHeight;
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);
        self.subTableView.contentOffset = CGPointZero;
    }else if(offsetY < tableViewContentHeight + subTableViewContentHeight - subTableHeight){
        self.contentView.top = offsetY - tableViewHeight;
        self.subTableView.contentOffset = CGPointMake(0, offsetY - tableViewContentHeight);
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);
    }else if(offsetY <= tableViewContentHeight + subTableViewContentHeight ){
        self.contentView.top = self.containerScrollView.contentSize.height - self.contentView.height;
        self.tableView.contentOffset = CGPointMake(0, tableViewContentHeight - tableViewHeight);
        self.subTableView.contentOffset = CGPointMake(0, subTableViewContentHeight - subTableHeight);
    }else {
        //do nothing
        NSLog(@"do nothing");
    }
}




- (void)setupNavigationItem {
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"waimai_sousuo"] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0, 0, 44, 44);
    searchBtn.hidden = YES;
    self.searchBtn = searchBtn;
    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = searchItem;
    self.navigationItem.titleView = self.addressButton;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 120;
    }
    else if (indexPath.section == 1) {
        return 250;
    }
    else if (indexPath.section == 2) {
        return 170;
    }
    else {
        return 160;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.001;
    }else {
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *headerTitles = @[@"为你而选",@"甄选推荐",@"到店自取"];
    ContainerTableHeader *headView = (ContainerTableHeader *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:sectionHeadid];
    headView.hidden = !section;
    headView.rightbgView.hidden = section != 3;
    if (section != 0) {
        headView.titleLable.text = headerTitles[section-1];
    }
    if (section == 3) {
        headView.countLable.text = @"共185家";
    }
    
    return headView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        WaimaiCycleCell *cell = [tableView dequeueReusableCellWithIdentifier:cycleCellid];
        return cell;
    }
    else if (indexPath.section == 1) {
        WaimaiYouxuanCell *cell = [tableView dequeueReusableCellWithIdentifier:youxuanCellid];
        return cell;
    }
    else if (indexPath.section == 2) {
        WaimaiRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:recommendCellid];
        return cell;
    }
    else {
        WaimaiZhiquCell *cell = [tableView dequeueReusableCellWithIdentifier:zhiquCellid];
        return cell;
    }

}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TableHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = HEX_COLOR(0xffffff);
        _tableView.tableFooterView = [UIView new];
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        UIView *headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableHeaderView class])  owner:self options:nil].firstObject;
        headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 260)];
        [view addSubview:headerView];
        _tableView.tableHeaderView = view;
        [_tableView registerClass:[WaimaiCycleCell class] forCellReuseIdentifier:cycleCellid];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([WaimaiYouxuanCell class]) bundle:nil] forCellReuseIdentifier:youxuanCellid];
        [_tableView registerClass:[WaimaiRecommendCell class] forCellReuseIdentifier:recommendCellid];
        [_tableView registerClass:[WaimaiZhiquCell class] forCellReuseIdentifier:zhiquCellid];
        [_tableView registerClass:[ContainerTableHeader class] forHeaderFooterViewReuseIdentifier:sectionHeadid];
        
    }
    return _tableView;
}

- (UIButton *)addressButton {
    if (!_addressButton) {
        _addressButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addressButton setImage:[UIImage imageNamed:@"waimai_dingwei"] forState:UIControlStateNormal];
        _addressButton.frame = CGRectMake(0, 0, WidthRatio(560), 44);
        [_addressButton setTitle:@"新世界百货" forState:UIControlStateNormal];
        // !!!:[_addressButton setImagePositionWithType:SSImagePositionTypeLeft spacing:8]
//        [_addressButton setImagePositionWithType:SSImagePositionTypeLeft spacing:8];
    }
    return _addressButton;
}

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, TableHeight)];
        _containerScrollView.backgroundColor = [UIColor whiteColor];
        _containerScrollView.showsVerticalScrollIndicator = NO;
        _containerScrollView.alwaysBounceVertical = YES;

        _containerScrollView.delegate = self;
        if (@available(iOS 11.0, *)) {
            [_containerScrollView adjustedContentInsetDidChange];
            _containerScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _containerScrollView;
}

- (UIView *)contentView{
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    
    return _contentView;
}

- (void)dealloc {
    [self removeObservers];
}



@end
