


#import "HRBaseRequest.h"

@interface HRBaseRequest (NetStautsMoniter)

//1.0 监测网络状态
- (void)moniterNetStatus:(void(^)(HRNetStatus netStatus))netStautsBlock;

@end
