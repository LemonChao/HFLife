

#import <Foundation/Foundation.h>

@interface HRFirstEnter : NSObject

//1.0 第一次进入程序block回调
+ (void)isFirst:(void(^)())handle;

@end
