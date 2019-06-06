//
//  receiptRecordListView.h
//  HFLife
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface receiptRecordListView : UIView

@property (nonatomic, strong) baseTableView *tableView;

//改版后会使用
@property (nonatomic , strong) NSArray <reciveModel *>*reciveModelArr;
@property (nonatomic, strong)void(^refreshData)(NSInteger page, NSString *dateStr);

@property (nonatomic, strong)NSArray <payRecordModel *>*dataSourceArr;
@end

NS_ASSUME_NONNULL_END
