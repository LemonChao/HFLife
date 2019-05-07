
/*~!
 | @FUNC  发短信
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

typedef NS_ENUM(NSUInteger, HRMessageStatus) {
    HRMessageCancelSendStatus, // 取消发送
    HRMessageSendedStatus, // 已经发送
    HRMessageSendFailureStatus, // 发送失败
};

@interface HRMessage : NSObject <MFMessageComposeViewControllerDelegate>

/*!
 *
 *  @author kk
 *  @brief 单例
 */
+ (instancetype)shareInstance;

/*!
 * @author kk
 *
 *  @brief 单人发送（无法返回到app、无法指定发送内容）
 */
+ (void)receiver:(NSString *)phoneNumber;

/*!
 *  @author kk
 *
 *  @brief 发送至多人（也可以一人）
 *
 *  @param phoneNumbers 收信人电话
 *  @param message      短信内容
 *  @param completed    发送完成回调
 */
- (void)receivers:(NSArray <NSString *>*)phoneNumbers message:(NSString *)message completed:(void(^)(HRMessageStatus status))completed;

@end
