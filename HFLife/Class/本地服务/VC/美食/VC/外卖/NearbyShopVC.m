//
//  NearbyShopVC.m
//  HanPay
//
//  Created by mac on 2019/2/19.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "NearbyShopVC.h"
#import "NearbyShopCell.h"
#import "NearbyShopSectionHeader.h"
#import "ZCBaseTableView.h"

@interface NearbyShopVC ()

@end

static NSString *cellid = @"NearbyShopCell_id";
static NSString *headerid = @"NearbyShopSectionHeader_id";


@implementation NearbyShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NearbyShopCell class]) bundle:nil] forCellReuseIdentifier:cellid];
    [self.tableView registerClass:[NearbyShopSectionHeader class] forHeaderFooterViewReuseIdentifier:headerid];

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return HeightRatio(200);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NearbyShopSectionHeader *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerid];
    return header;

}


- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 169;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    return cell;
}


@end
