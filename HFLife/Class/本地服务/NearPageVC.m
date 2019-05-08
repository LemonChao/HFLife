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
@interface NearPageVC ()<UITableViewDelegate, UITableViewDataSource>
/** 容器TableView*/
@property (nonatomic,strong)UITableView *containerTableView;
@property(nonatomic, strong) UIView *headView;
@end

@implementation NearPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.customNavBar.title = @"本地服务";
    
    
    YYB_HF_LocalHeadView *headView = [[YYB_HF_LocalHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,NavBarHeight)];
    [self.view addSubview:headView];
    self.headView = headView;
    
    [self.view addSubview:self.containerTableView];
    self.containerTableView.backgroundColor = [UIColor whiteColor];
    [self.containerTableView setFrame:CGRectMake(0, NavBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - NavBarHeight)];
    //    self.locationManager.delegate = self;
//    [self.view insertSubview:self.customNavBar aboveSubview:self.containerTableView];
    
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
        _containerTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                           style:UITableViewStyleGrouped];
        _containerTableView.delegate = self;
        _containerTableView.dataSource = self;
        _containerTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _containerTableView.backgroundColor = HEX_COLOR(0xffffff);
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
        _containerTableView.tableHeaderView = headView;
    }
    return _containerTableView;
}

#pragma mark - table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0 && indexPath.section == 0) {
        CGFloat height = [tableView cellHeightForIndexPath:indexPath model:MMNSStringFormat(@"%d",1) keyPath:@"dataModel" cellClass:[NearColumnCell class] contentViewWidth:[self cellContentViewWith]];
        NSLog(@"height = %f",height);
        return height;
    }
    return 200;

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
    return 0.01;
    
    
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
