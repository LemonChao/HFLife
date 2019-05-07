
/*~!
 | @FUNC  UIWebView浏览本地文件
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <UIKit/UIKit.h>

@interface UIWebView (Browser)

//1.0 浏览本地文件(txt,word,excel,ppt,pdf,html,css)
- (void)browseFile:(NSString *)localPath;

@end
