

#import "NSDate+TimeStamp.h"

@implementation NSDate (TimeStamp)

//1.0 根据当前时间获取时间戳（10位，精确到秒）
+ (NSString *)currentTimeStamp10 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)[[NSDate date] timeIntervalSince1970]];
}

//1.1 根据当前时间获取时间戳（13位，精确到毫秒）
+ (NSString *)currentTimeStamp13 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)([[NSDate date] timeIntervalSince1970] * 1000)];
}

//1.2 根据指定时间获取时间戳（10位，精确到秒）
- (NSString *)timeStamp10 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)[self timeIntervalSince1970]];
}

//1.3 根据指定时间获取时间戳（13位，精确到秒）
- (NSString *)timeStamp13 {
    return [NSString stringWithFormat:@"%ld", (NSInteger)([self timeIntervalSince1970] * 1000)];
}



+(NSString *)timestampSwitchTime:(NSInteger)timestamp dateFormat:(NSString *)formatStr{
    NSString *format = [NSString stringWithFormat:@"%@", formatStr];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:format]; // （@"YYYY-MM-dd hh:mm:ss"）----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timestamp];
    
//    NSLog(@"1296035591  = %@",confromTimesp);
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    //NSLog(@"&&&&&&&confromTimespStr = : %@",confromTimespStr);
    return confromTimespStr;
    
}

+(NSString *)getNowTime:(NSInteger)time dateFormat:(NSString *)formatStr{
    //    NSLog(@"%@" , aTimeString);
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:formatStr];
    NSTimeInterval timeInterval = time;
    //带有天数
    //    int days = (int)(timeInterval/(3600*24));
    //    int hours = (int)((timeInterval-days*24*3600)/3600);
    //不带天数
    int days = 0;
    int hours = (int)((timeInterval)/3600);
    
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return [NSString stringWithFormat:@"%@" , @""];
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
        
        //        return [NSString stringWithFormat:@"%@-%@-%@-%@", dayStr,hoursStr, minutesStr,secondsStr];
    }
    //    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
    return [NSString stringWithFormat:@"%@-%@-%@", hoursStr, minutesStr,secondsStr];
}
+ (NSString *)intervalSinceNow: (NSString *) theDate
{
    NSString *timeString=@"";
    //    theDate = @"2014-04-18 17:25:00";
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate = [NSDate dateWithTimeIntervalSince1970:[theDate integerValue]];
    //    NSDate *fromdate=[NSDate dateFromString:theDate];
    NSTimeZone *fromzone = [NSTimeZone systemTimeZone];
    NSInteger frominterval = [fromzone secondsFromGMTForDate: fromdate];
    NSDate *fromDate = [fromdate  dateByAddingTimeInterval: frominterval];
    
    //获取当前时间
    NSDate *adate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: adate];
    NSDate *localeDate = [adate  dateByAddingTimeInterval: interval];
    
    double intervalTime = [fromDate timeIntervalSinceReferenceDate] - [localeDate timeIntervalSinceReferenceDate];
    long lTime = labs((long)intervalTime);
    NSInteger iYears = lTime/60/60/24/365;
    NSInteger iMonth = (lTime % (60*60*24*365))/60/60/24/30;
    NSInteger iDays = (lTime % (60*60*24*30))/60/60/24;
    NSInteger iHours = (lTime % (60*60*24))/60/60;
    NSInteger iMinutes = (lTime % (60*60))/60;
    NSInteger iSeconds = lTime % 60;
    
    NSLog(@"%ld---%ld----%ld---%ld---%ld---%ld", iYears, iMonth, iDays, iHours, iMinutes, iSeconds);
    
    if (iMinutes <= 10 && iHours == 0) {
        timeString = @"刚刚";
    }else if (iHours < 1 && iDays == 0){
        timeString = [NSString stringWithFormat:@"%ld分钟前", iMinutes];
    }else if (iHours <= 24 && iDays < 1 && iMonth == 0 && iYears == 0){
        timeString = [NSString stringWithFormat:@"%ld小时前", iHours];
    }else if (iDays <= 3 && iMonth == 0){
        timeString = [NSString stringWithFormat:@"%ld天前", iDays];
    }else {
        NSDateFormatter *mformat=[[NSDateFormatter alloc] init];
        [mformat setDateFormat:@"MM月dd日"];
        NSDate *mfromdate = [NSDate dateWithTimeIntervalSince1970:[theDate integerValue]];
        NSString *confromTimespStr = [mformat stringFromDate:mfromdate];
        timeString = confromTimespStr;
    }
    
    
    return timeString;
    
    
    
    
    NSLog(@"相差%ld年%ld月 或者 %ld日%ld时%ld分%ld秒", iYears,iMonth,iDays,iHours,iMinutes,(long)iSeconds);
    if (iMinutes < 1 && iSeconds > 0) {
        timeString=[NSString stringWithFormat:@"%ld秒前",(long)iSeconds];
    } else if (iHours<1 && iMinutes>0) {
        timeString=[NSString stringWithFormat:@"%ld分前",(long)iMinutes];
        
    }else if (iHours>0&&iDays<1 && iMinutes>0) {
        //        timeString=[NSString stringWithFormat:@"%ld时%ld分前",(long)iHours,iMinutes];
        timeString = @"刚刚";
    }
    else if (iHours>0&&iDays<1) {
        //        timeString=[NSString stringWithFormat:@"%ld时前",(long)iHours];
        timeString = @"刚刚";
    }else if (iDays>0 && iHours>0)
    {
        //        timeString=[NSString stringWithFormat:@"%ld天%ld时前",(long)iDays,iHours];
        timeString = @"刚刚";
    }
    else if (iDays>0)
    {
        timeString=[NSString stringWithFormat:@"%ld天前",(long)iDays];
    }
    return timeString;
}
@end
