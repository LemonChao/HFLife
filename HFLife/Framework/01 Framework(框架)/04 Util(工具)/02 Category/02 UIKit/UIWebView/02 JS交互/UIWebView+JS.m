

#import "UIWebView+JS.h"

@implementation UIWebView (JS)

//1.0 JS捕获OC方法 | methodName:方法名
- (void)JSCatchOCMethodName:(NSString *)methodName handle:(void(^)(NSDictionary *para, NSArray <JSValue *>*arguments))handle {
    JSContext *context = [self valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[methodName] = ^(NSDictionary *para){
        NSArray *arguments = [JSContext currentArguments];
        dispatch_async(dispatch_get_main_queue(), ^{
            handle(para, arguments);
        });
    };
}

@end
