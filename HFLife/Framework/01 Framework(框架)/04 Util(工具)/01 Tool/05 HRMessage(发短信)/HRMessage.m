
#import "HRMessage.h"

@interface HRMessage () 

@property (copy, nonatomic) void(^messageStatusBlock)(HRMessageStatus); // 发送信息状态

@end

@implementation HRMessage

#pragma mark - ---------- Singleton ----------

+ (instancetype)shareInstance {
    static HRMessage *instance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [[self class] shareInstance];
}

- (instancetype)copyWithZone:(struct _NSZone *)zone{
    return [[self class] shareInstance];
}

#pragma mark - ---------- Public Methods ----------

+ (void)receiver:(NSString *)phoneNumber {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"sms://%@", phoneNumber]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}

- (void)receivers:(NSArray <NSString *>*)phoneNumbers message:(NSString *)message completed:(void (^)(HRMessageStatus status))completed {
    self.messageStatusBlock = completed;
    // 显示发短信的控制器
    MFMessageComposeViewController *messageVC = [[MFMessageComposeViewController alloc] init];
    // 设置短信内容
    messageVC.body = message;
    // 设置收件人列表
    messageVC.recipients = phoneNumbers;
    // 设置代理
    messageVC.messageComposeDelegate = self;
    // 显示控制器
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window.rootViewController presentViewController:messageVC animated:YES completion:nil];
}

// 代理方法，当短信界面关闭的时候调用，发完后会自动回到原应用
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    // 关闭短信界面
    [controller dismissViewControllerAnimated:YES completion:nil];
    if (result == MessageComposeResultCancelled) {
        // NSLog(@"取消发送");
        self.messageStatusBlock(HRMessageCancelSendStatus);
    } else if (result == MessageComposeResultSent) {
        // NSLog(@"已经发出");
        self.messageStatusBlock(HRMessageSendedStatus);
    } else {
        // NSLog(@"发送失败");
        self.messageStatusBlock(HRMessageSendFailureStatus);
    }
}

@end
