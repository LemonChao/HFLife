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

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic , strong) NSArray <reciveModel *>*reciveModelArr;
@property (nonatomic ,strong) void (^reloadData)(BOOL isUp);
@end

NS_ASSUME_NONNULL_END
