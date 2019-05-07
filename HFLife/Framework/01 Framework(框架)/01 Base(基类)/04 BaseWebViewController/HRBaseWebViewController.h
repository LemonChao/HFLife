
#import "HRBaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface HRBaseWebViewController : HRBaseViewController <UIWebViewDelegate>
//webView
@property (strong, nonatomic) UIWebView *webView;
//url
@property (copy, nonatomic) NSString *url;
//context
@property (strong, nonatomic) JSContext *context;

@end
