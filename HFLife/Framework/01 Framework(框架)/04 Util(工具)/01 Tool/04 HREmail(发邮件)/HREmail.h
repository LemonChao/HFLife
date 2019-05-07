

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, HREamilStatus) {
    HREamilCancelStatus, // 取消发送
    HREamilSaveStatus, // 已保存
    HREamilSendedStatus, // 已发送
    HREamilFailStatus // 发送失败
};

@interface HREmail : NSObject


+ (instancetype)shareInstance;


+ (void)receiver:(NSString *)emailAddress;


- (void)receivers:(NSArray <NSString *>*)receivers copy:(NSArray <NSString *>*)copiers secret:(NSArray <NSString *>*)secreters subject:(NSString *)subject message:(NSString *)message completed:(void(^)(HREamilStatus status))completed;


@end
