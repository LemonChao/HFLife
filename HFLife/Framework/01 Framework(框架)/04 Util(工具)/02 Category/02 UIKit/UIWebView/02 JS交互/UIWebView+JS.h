
/*~!
 | @FUNC  JS捕获OC方法
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface UIWebView (JS)

//1.0 JS捕获OC方法 | methodName:方法名
- (void)JSCatchOCMethodName:(NSString *)methodName handle:(void(^)(NSDictionary *para, NSArray <JSValue *>*arguments))handle;

@end
