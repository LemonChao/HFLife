//
//  BalanceRecordModel.m
//  HanPay
//
//  Created by 张海彬 on 2019/4/18.
//  Copyright © 2019年 张海彬. All rights reserved.
//

#import "BalanceRecordModel.h"

@implementation BalanceRecordModel
-(id)init:(NSDictionary *)dict{
    self = [super init:dict];
    if (self) {
        self.idStr = dict[@"id"];
        self.log_type = MMNSStringFormat(@"%@",[NSString judgeNullReturnString:dict[@"log_type"]]);
    }
    return self;
}
-(NSString *)vcName{
    if ([self.log_type isEqualToString:@"0"]) {
            //其他
         return  @"BillDetailsVC";
    }else if ([self.log_type isEqualToString:@"1"]){
            //提现
        return @"balanceOrderDetaileVC";
    }else if ([self.log_type isEqualToString:@"2"]){
            //转账
        return @"TransferAccountsOrderDetails";
    }
    return @"";
}
@end
