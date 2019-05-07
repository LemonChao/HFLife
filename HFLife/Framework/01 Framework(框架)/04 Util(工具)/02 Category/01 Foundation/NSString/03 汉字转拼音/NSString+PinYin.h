

#import <Foundation/Foundation.h>

@interface NSString (PinYin)

//1.0 汉字转拼音（无音调，带空格）
- (NSString *)pinYin;

//1.1 汉字转拼音（有音调，带空格）
- (NSString *)pinYinWithTone;

//1.2字符串判空
+(BOOL)isEmpty:(NSString*)text;

@end
