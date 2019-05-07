
#import "HREmail.h"
#import <MessageUI/MessageUI.h>

@interface HREmail () <MFMailComposeViewControllerDelegate>

@property (copy, nonatomic) void(^mailResultBlock)(HREamilStatus); // 邮件回调结果block

@end

@implementation HREmail

#pragma mark - ---------- Singleton ----------

+ (instancetype)shareInstance {
    static HREmail *instance = nil;
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
// 发送至个人
+ (void)receiver:(NSString *)emailAddress {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@", emailAddress]];
    [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
}
// 发送至多人
- (void)receivers:(NSArray <NSString *>*)receivers copy:(NSArray <NSString *>*)copiers secret:(NSArray <NSString *>*)secreters subject:(NSString *)subject message:(NSString *)message completed:(void(^)(HREamilStatus status))completed {
    self.mailResultBlock = completed;
    if (![MFMailComposeViewController canSendMail]) {
         NSLog(@"不能发送邮件");
        self.mailResultBlock(HREamilFailStatus);
        return;
    }
    MFMailComposeViewController *vc = [[MFMailComposeViewController alloc] init];
    // 主题
    [vc setSubject:subject];
    // 内容
    [vc setMessageBody:message isHTML:NO];
    // 收件人
    [vc setToRecipients:receivers];
    // 抄送
    [vc setCcRecipients:copiers];
    // 密送
    [vc setBccRecipients:secreters];
    // 设置代理
    vc.mailComposeDelegate = self;
    // 显示邮件界面
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    [window.rootViewController presentViewController:vc animated:YES completion:nil];
}

#pragma mark - ---------- Protocol Methods ----------

#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
    switch (result) {
        case MFMailComposeResultCancelled:
            self.mailResultBlock(HREamilCancelStatus);
            break;
        case MFMailComposeResultSaved:
            self.mailResultBlock(HREamilSaveStatus);
            break;
        case MFMailComposeResultSent:
            self.mailResultBlock(HREamilSendedStatus);
            break;
        case MFMailComposeResultFailed:
            self.mailResultBlock(HREamilFailStatus);
            break;
    }
}

@end
