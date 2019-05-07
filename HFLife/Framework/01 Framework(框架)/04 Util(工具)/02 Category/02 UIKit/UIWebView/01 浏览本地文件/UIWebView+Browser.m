

#import "UIWebView+Browser.h"

@implementation UIWebView (Browser)

- (void)browseFile:(NSString *)localPath {
    NSURL *url = [NSURL fileURLWithPath:localPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

@end
