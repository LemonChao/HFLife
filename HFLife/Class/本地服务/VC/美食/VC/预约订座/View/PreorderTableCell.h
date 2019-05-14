//
//  PreorderTableCell.h
//  HanPay
//
//  Created by zchao on 2019/2/22.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PreorderTableCell : UITableViewCell
@property (nonatomic,strong)NSDictionary *dataDict;
@property (nonatomic,copy) void (^reservationBlock) (NSDictionary *dict);
@end

NS_ASSUME_NONNULL_END
