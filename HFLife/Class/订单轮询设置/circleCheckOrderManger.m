//
//  circleCheckOrderManger.m
//  HanPay
//
//  Created by mac on 2019/4/15.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "circleCheckOrderManger.h"
@interface circleCheckOrderManger()
@property (nonatomic ,strong) NSTimer *timer;
@property (nonatomic, assign)NSInteger searchNum;//轮询次数;
@property (nonatomic, assign)NSInteger searchMaxTime;//默认 最大 5;

//@property (nonatomic, assign)BOOL isHotel;
@property (nonatomic, copy)NSString *isHotel;
@property (nonatomic, copy)NSString *id_type;
@property (nonatomic ,assign) BOOL isNowPay;
/**
 订单ID
 */
@property (nonatomic,strong)NSString *orderID;
@end


@implementation circleCheckOrderManger

+ (instancetype) sharedInstence{
    static circleCheckOrderManger *instence;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instence) {
            instence = [[circleCheckOrderManger alloc] init];
            [instence.timer fire];
        }else{
            instence.searchNum = 0;
            [instence cancleTimer];
        }
    });
    return instence;
}

- (void)checkOrderStatus{
#pragma mark - s查询订单
    self.searchNum = 1;
    self.searchMaxTime = 5;
    if (self.orderSearchInfoDic && [self.orderSearchInfoDic isKindOfClass:[NSDictionary class]]) {
        [[circleCheckOrderManger sharedInstence] searchOrderWithOrderId:[self.orderSearchInfoDic[@"orderId"] stringValue]   isHotel:self.orderSearchInfoDic[@"orderType"] idType:self.orderSearchInfoDic[@"payType"] isNowPay:YES];
        self.orderSearchInfoDic = nil;
        
    }

}



- (NSTimer *)timer{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(fireTimer) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        //        [_timer fire];
    }
    
    return _timer;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.searchNum = 5;
        self.searchMaxTime = 0;
    }
    return self;
}

- (instancetype) searchOrderWithOrderId:(NSString *)orderID isHotel:(NSString *)isHotel idType:(NSString *)idType isNowPay:(BOOL)nowPay{
    if (orderID && [orderID isKindOfClass:[NSString class]] && orderID.length > 0) {
        
    }else {
        [WXZTipView showCenterWithText:@"订单id不存在"];
        return self;
    }
    self.isHotel = isHotel;
    self.id_type = idType;
    self.isNowPay = nowPay;
    self.orderID = orderID;
    [self cancleTimer];
   
     NSDictionary *param = @{
                         @"orderId" : orderID,
                         @"orderType" : isHotel,
                         };
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kGetOrderPayResult withParameters:param withResultBlock:^(BOOL result, id value) {
        NSLog(@"查询订单====");
        NSDictionary *dict = value;
        if (dict && [dict[@"status"] integerValue] == 1) {
            [self cancleTimer];
            if (self.searchOrderBlock) {
                self.searchOrderBlock(dict);
            }
        }else{
            
            if (self.searchNum == 5) {
                if (self.searchOrderBlock) {
                    self.searchOrderBlock(dict);
                }
            }
            if (nowPay) {
                
            }else {
                [WXZTipView showCenterWithText:@"订单查询失败"];
            }
            //继续轮询
            [self.timer fire];
        }
    }];
    
    
    return self;
}

- (UIViewController *)getCurrentVC{
    UIWindow *kw = [UIApplication sharedApplication].keyWindow;
    if (!kw) {
        kw = [UIApplication sharedApplication].windows.lastObject;
    }
    UIViewController *vc = kw.rootViewController;
    return vc;
}



- (void) fireTimer{
    NSLog(@"fier");
    //说明跳了支付
    if (self.searchNum >= self.searchMaxTime) {
        [self cancleTimer];
    }else{
        [self searchOrderWithOrderId:self.orderID isHotel:self.isHotel idType:self.id_type isNowPay:self.isNowPay];
    }
    self.searchNum ++;
}



- (void) cancleTimer{
    [self.timer invalidate];
    self.timer = nil;
}



- (void)dealloc{
    NSLog(@"dealloc");
}

@end
