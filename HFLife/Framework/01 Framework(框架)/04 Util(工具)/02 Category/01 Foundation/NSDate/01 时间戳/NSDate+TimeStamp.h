
/*~!
 | @FUNC  时间戳
 | @AUTH  Nobility
 | @DATE  2016-10-17
 | @BRIF  <#brif#>
 */

#import <Foundation/Foundation.h>
#define  DateFormatStr @"yyyy-MM-dd HH:mm:ss"//24小时计时法
@interface NSDate (TimeStamp)

//1.0 根据当前时间获取时间戳（10位，精确到秒）
+ (NSString *)currentTimeStamp10;

//1.1 根据当前时间获取时间戳（13位，精确到毫秒）
+ (NSString *)currentTimeStamp13;

//1.2 根据指定时间获取时间戳（10位，精确到秒）
- (NSString *)timeStamp10;

//1.3 根据指定时间获取时间戳（13位，精确到秒）
- (NSString *)timeStamp13;



/**
 时间戳 转字符串

 @param timestamp <#timestamp description#>
 @param formatStr <#formatStr description#>
 @return <#return value description#>
 */
+(NSString *)timestampSwitchTime:(NSInteger)timestamp dateFormat:(NSString *)formatStr;

+(NSString *)getNowTime:(NSInteger)time dateFormat:(NSString *)formatStr;
+ (NSString *)intervalSinceNow: (NSString *) theDate;
@end
