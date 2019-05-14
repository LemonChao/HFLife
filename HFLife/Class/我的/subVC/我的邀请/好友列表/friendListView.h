//
//  friendListView.h
//  HanPay
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//


NS_ASSUME_NONNULL_BEGIN

@interface friendListView : UIView
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *dataSourceArr;
@property (nonatomic, strong)NSString *totleTitle;
@property (nonatomic, copy)void(^selectedItem)(NSInteger index, friengListModel *friendModel);
@end

NS_ASSUME_NONNULL_END
