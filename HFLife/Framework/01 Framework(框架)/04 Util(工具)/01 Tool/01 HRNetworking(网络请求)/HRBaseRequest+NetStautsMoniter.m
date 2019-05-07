

#import "HRBaseRequest+NetStautsMoniter.h"
#import "AFNetworking.h"

@implementation HRBaseRequest (NetStatusMoniter)

//1.0 监测网络状态
- (void)moniterNetStatus:(void(^)(HRNetStatus netStatus))netStautsBlock {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                self.netStatus = HRNetStatusUnknown;
                netStautsBlock(HRNetStatusUnknown);
                break;
            case AFNetworkReachabilityStatusNotReachable:
                self.netStatus = HRNetStatusNotReachable;
                netStautsBlock(HRNetStatusNotReachable);
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                self.netStatus = HRNetStatusCellular;
                netStautsBlock(HRNetStatusCellular);
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                self.netStatus = HRNetStatusWiFi;
                netStautsBlock(HRNetStatusWiFi);
                break;
        }
    }];
    //开始监测
    [manager startMonitoring];
}

@end
