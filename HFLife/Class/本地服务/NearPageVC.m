//
//  NearPageVC.m
//  HFLife
//
//  Created by mac on 2019/5/6.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "NearPageVC.h"
#import "YYB_HF_LocalHeadView.h"
#import "NearColumnCell.h"
#import "YYB_HF_guessLikeTableViewCell.h"
#import "NearColumnCell.h"

@interface NearPageVC ()<UITableViewDelegate, UITableViewDataSource> {
    int arc;
}
/** 容器TableView*/
@property (nonatomic,strong) baseTableView *containerTableView;
@property(nonatomic, strong) UIView *headView;
@property(nonatomic, strong) NSMutableDictionary *cellHeightDic;
@end

@implementation NearPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cellHeightDic = [NSMutableDictionary dictionary];
    
    YYB_HF_LocalHeadView *headView = [[YYB_HF_LocalHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NavBarHeight)];
    [self.view addSubview:headView];
    self.headView = headView;
    
    [self.view addSubview:self.containerTableView];
    self.containerTableView.backgroundColor = [UIColor whiteColor];
    [self.containerTableView setFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight - TabBarHeight)];
    //    self.locationManager.delegate = self;
//    [self.view insertSubview:self.customNavBar aboveSubview:self.containerTableView];
    
//    self.containerTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [self.containerTableView.mj_header endRefreshing];
//    }];
//
//    self.containerTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self.containerTableView.mj_footer endRefreshing];
//    }];
    
    WEAK(weakSelf);
    self.containerTableView.refreshHeaderBlock = ^{
        [weakSelf.containerTableView.mj_header endRefreshing];
        [weakSelf.containerTableView reloadData];
    };
    
    self.containerTableView.refreshFooterBlock = ^{
        [weakSelf.containerTableView.mj_footer endRefreshing];
        [weakSelf.containerTableView reloadData];
    };
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.customNavBar setHidden:YES];
    self.navigationController.navigationBarHidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    
}

#pragma mark 懒加载
- (UITableView *)containerTableView
{
    if (_containerTableView == nil) {
        _containerTableView = [[baseTableView alloc] initWithFrame:CGRectZero
                                                           style:UITableViewStyleGrouped];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _containerTableView.tableHeaderView = headView;
        if (@available(iOS 11.0, *)) {
            /** 上拉跳跃异常 */
            _containerTableView.estimatedRowHeight = 0;
            _containerTableView.estimatedSectionFooterHeight = 0;
            _containerTableView.estimatedSectionHeaderHeight = 0;
            _containerTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    return _containerTableView;
}

#pragma mark - table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return 2;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        arc = 1;
        CGFloat height = [tableView cellHeightForIndexPath:indexPath model:MMNSStringFormat(@"%d",arc) keyPath:@"dataModel" cellClass:[NearColumnCell class] contentViewWidth:[self cellContentViewWith]];
        NSLog(@"height = %f",height);
        return height - 30;
    }
    
    if ([self.cellHeightDic.allKeys containsObject:indexPath]) {
        return [self.cellHeightDic[indexPath] integerValue];
    }
    
//    if ((indexPath.row == 0 && indexPath.section == 1)) {
//        return 173;
//    }
    return 0.110;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (section==0) {
//        return 44;//HeightRatio(420);
//    }
//    else if (section==1){
////        if (self.nearShopListArr.count == 0) {
////            return 0.001;
////        }
//        return HeightRatio(63);
//    }
    
    if (section == 1) {
        return 40;
    }
    return 0.01;
    
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        UILabel *titleLabel = [UILabel new];
        UIView *view = [UIView new];
        [view addSubview:titleLabel];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(view).mas_offset(12);
            make.centerY.mas_equalTo(view);
            make.height.mas_equalTo(17);
        }];
        titleLabel.text = @"猜你喜欢";
        titleLabel.font = FONT(17);
        titleLabel.textColor = HEX_COLOR(0X131313);
        return view;
    }
    return [UIView new];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && indexPath.section == 0) {
        NearColumnCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NearColumnCell"];
        if (!cell) {
            cell = [[NearColumnCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NearColumnCell"];
        }
//        cell.delegate = self.delegateManage;
//        if (self.nearPageDict[@"banner"].count != 0) {
//            arc = 1;
//            cell.bannerListModel = self.nearPageDict[@"banner"];
//
//        }else{
//            arc = 0;
//        };
//        cell.dataModel = [NSString stringWithFormat:@"%d", arc];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.row == 0 && indexPath.section == 1){
        YYB_HF_guessLikeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YYB_HF_guessLikeTableViewCell"];
        if (!cell) {
            cell = [[YYB_HF_guessLikeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYB_HF_guessLikeTableViewCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.cellHeightDic setObject:@(173) forKey:indexPath];
        return cell;
    }else {
        YYB_HF_guessLikeTableViewCellRightPic *cell = [tableView dequeueReusableCellWithIdentifier:@"YYB_HF_guessLikeTableViewCellRightPic"];
        if (!cell) {
            cell = [[YYB_HF_guessLikeTableViewCellRightPic alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YYB_HF_guessLikeTableViewCellRightPic"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.cellHeightDic setObject:@(110) forKey:indexPath];
        return cell;
    }
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
