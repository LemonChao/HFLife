//
//  receiptRecordListCell.h
//  HFLife
//
//  Created by mac on 2019/4/12.
//  Copyright © 2019 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface receiptRecordListCell : UITableViewCell
- (void) setDataForCell:(payRecordModel *) model;
@property (nonatomic, assign)BOOL payType;
@end

NS_ASSUME_NONNULL_END
