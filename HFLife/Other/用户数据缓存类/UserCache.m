//
//  UserCache.m
//  MedicalMall
//
//  Created by mac on 2018/3/24.
//

#import "UserCache.h"
#import "YYCache/YYCache.h"
static NSString *const USERDATA = @"UserData";
@implementation UserCache
static YYCache *_dataUserCache;
+(void)initialize{
    _dataUserCache = [YYCache cacheWithName:USERDATA];
}

#pragma mark 存用户密码
+(void)setUserPass:(NSString *)pass{
    //    if (![NSString isNOTNull:pass]) {
    [_dataUserCache setObject:pass forKey:@"UserPass" withBlock:nil];
    //    }
}
#pragma mark 取用户密码
+(id)getUserPass{
    NSString *str = (NSString *)[_dataUserCache objectForKey:@"UserPass"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    return [_dataUserCache objectForKey:@"UserPass"];
    
}
#pragma mark 存用户ID
+(void)setUserId:(NSString *)userID{
    if (![NSString isNOTNull:userID]) {
        [_dataUserCache setObject:userID forKey:@"UserId" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserId" withBlock:nil];
    }
}
#pragma mark 获取用户ID
+(id)getUserId{
    NSString *str = (NSString *)[_dataUserCache objectForKey:@"UserId"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    return [_dataUserCache objectForKey:@"UserId"];
    
}
#pragma mark 存用户昵称
+(void)setUserNickName:(NSString *)nickName{
    if (![NSString isNOTNull:nickName]) {
        [_dataUserCache setObject:nickName forKey:@"UserNickName" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserNickName" withBlock:nil];
    }
}
#pragma mark 获取用户昵称
+(id)getUserNickName{
    NSString *nick = (NSString *)[_dataUserCache objectForKey:@"UserNickName"];
    if ([NSString isNOTNull:nick]) {
        return @"";
    }
    return nick;
}
#pragma mark 存用户名
+(void)setUserName:(NSString *)userName{
    if (![NSString isNOTNull:userName]) {
        [_dataUserCache setObject:userName forKey:@"userName" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"userName" withBlock:nil];
    }
}
#pragma mark 获取用户名
+(id)getUserName{
    NSString *str = (NSString *)[_dataUserCache objectForKey:@"userName"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    return [_dataUserCache objectForKey:@"userName"];
}
#pragma mark 存用户真实姓名
+(void)setUserRealName:(NSString *)realName{
    if (![NSString isNOTNull:realName]) {
        [_dataUserCache setObject:realName forKey:@"UserRealName" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserRealName" withBlock:nil];
    }
}
#pragma mark 获取用户真实姓名
+(id)getUserRealName{
    return [_dataUserCache objectForKey:@"UserRealName"];
}
#pragma mark 存用户头像
+(void)setUserPic:(NSString *)userPic{
    if (![NSString isNOTNull:userPic]) {
        [_dataUserCache setObject:userPic forKey:@"UserPic" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserPic" withBlock:nil];
    }
}
#pragma mark 存用户邀请码
+(void)setUserInviteCode:(NSString *)invite_code{
    if (![NSString isNOTNull:invite_code]) {
        [_dataUserCache setObject:invite_code forKey:@"invite_code" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"invite_code" withBlock:nil];
    }
}
#pragma mark 存用户等级
+(void)setUserLevelInfo:(NSDictionary *)level_info{
    if ([level_info isKindOfClass:[NSDictionary class]]) {
        [_dataUserCache setObject:level_info forKey:@"level_info" withBlock:nil];
    }
}
#pragma mark 获取用户邀请码
+(id)getUserInviteCode{
    return [_dataUserCache objectForKey:@"invite_code"];
}
#pragma mark 获取用户等级
+(id)getUserLevelInfo{
    return [_dataUserCache objectForKey:@"level_info"];
}
#pragma mark 存用户身份证号
+(void)setUserIdCard:(NSString *)idCard{
    if (![NSString isNOTNull:idCard]) {
        [_dataUserCache setObject:idCard forKey:@"UserIdCard" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserIdCard" withBlock:nil];
    }
}
#pragma mark 取用户身份证号
+(id)getUserIdCard{
    NSString *str = (NSString *)[_dataUserCache objectForKey:@"UserIdCard"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    return [_dataUserCache objectForKey:@"UserIdCard"];
}
#pragma mark 获取用户头像
+(id)getUserPic{
    NSString *str = (NSString *)[_dataUserCache objectForKey:@"UserPic"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    return str;
}
#pragma mark 存用户性别
+(void)setUserSex:(NSString *)sex{
    if (![NSString isNOTNull:sex]) {
        [_dataUserCache setObject:sex forKey:@"UserSex" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserSex" withBlock:nil];
    }
}
#pragma mark 获取用户性别
+(id)getUserSex{
    NSString *str =(NSString *) [_dataUserCache objectForKey:@"UserSex"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    if ([str isEqualToString:@"0"]) {
        return @"女";
    }else{
        return @"男";
    }
    return [_dataUserCache objectForKey:@"UserSex"];
}
#pragma mark 存用户是否实名
+(void)setUserXinXi:(NSString *)XinXi{
    //实名认证状态 0未认证   1已认证   2审核中   3未通过 ',
    if (![NSString isNOTNull:XinXi]) {
        [_dataUserCache setObject:XinXi forKey:@"UserXinXi" withBlock:nil];
    }
}
#pragma mark 获取用户是否实名
+(BOOL)getUserXinXi{
    if ([NSString isNOTNull:[_dataUserCache objectForKey:@"UserXinXi"]]) {
        return NO;
    }
    NSString *str =(NSString *) [_dataUserCache objectForKey:@"UserXinXi"] ;
    if (![str isEqualToString:@"1"]) {
        return NO;
    }else{
        return YES;
    }
}
#pragma mark 获取用户审核状态的状态码
+(NSString *)getUserXinXiCode{
    NSString *str =(NSString *) [_dataUserCache objectForKey:@"UserXinXi"] ;
    if ([NSString isNOTNull:str]) {
        return @"0";
    }
    return str;
}
#pragma mark 获取用户审核状态的title
+(NSString *)getUserXinXiTitle{
    NSString *str =(NSString *) [_dataUserCache objectForKey:@"UserXinXi"] ;
    if ([NSString isNOTNull:str]) {
        return @"未认证";
    }
    if ([str isEqualToString:@"0"]) {
        return @"未认证";
    }
    if ([str isEqualToString:@"1"]) {
        return @"已认证";
    }
    if ([str isEqualToString:@"2"]) {
        return @"审核中";
    }
    if ([str isEqualToString:@"3"]) {
        return @"未通过";
    }
    return @"未认证";
}
#pragma mark 存用户手机号 u_name
+(void)setUserPhone:(NSString *)phone{
    if (![NSString isNOTNull:phone]) {
        [_dataUserCache setObject:phone forKey:@"UserPhone" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserPhone" withBlock:nil];
    }
}
#pragma mark 取用户手机号
+(id)getUserPhone{
    NSString *str = (NSString *)[_dataUserCache objectForKey:@"UserPhone"];
    if ([NSString isNOTNull:str]) {
        return @"";
    }
    return [_dataUserCache objectForKey:@"UserPhone"];
    
}
#pragma mark 存是否设置用户交易密码
+(void)setUserTradePassword:(NSString *)tradePassword{
    if (![NSString isNOTNull:tradePassword]) {
        [_dataUserCache setObject:tradePassword forKey:@"UserTradePassword" withBlock:nil];
    }
}
#pragma mark 获取是否设置用户交易密码
+(BOOL)getUserTradePassword{
    if ([NSString isNOTNull:[_dataUserCache objectForKey:@"UserTradePassword"]]) {
        return NO;
    }
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"UserTradePassword"];
    if ([data isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
    
}
#pragma mark 存是否设置用户密码
+(void)setUserPassword:(NSString *)Password{
    if (![NSString isNOTNull:Password]) {
        [_dataUserCache setObject:Password forKey:@"UserPasswordStatus" withBlock:nil];
    }else{
        [_dataUserCache setObject:@"" forKey:@"UserPasswordStatus" withBlock:nil];
    }
}

#pragma mark 获取是否设置用户密码
+(BOOL)getUserPasswordStatus{
    if ([NSString isNOTNull:[_dataUserCache objectForKey:@"UserPasswordStatus"]]) {
        return NO;
    }
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"UserPasswordStatus"];
    if ([data isEqualToString:@"1"]) {
        return YES;
    }else{
        return NO;
    }
}

#pragma mark  存审核的状态
+(void)setReviewStatus:(NSString *)reviewStatus{
    if (![NSString isNOTNull:reviewStatus]) {
        [_dataUserCache setObject:reviewStatus forKey:@"reviewStatus" withBlock:nil];
    }
    
}
#pragma mark 获取审核状态
+(NSString *)getReviewStatusString{
    /**
     0已认证 1未认证 2未通过 3正在审核
     */
    //    if ([NSString isNOTNull:[_dataUserCache objectForKey:@"reviewStatus"]]) {
    //        return ChooseWord(@"暂未实名认证", [UserCache languageFile]);
    //    }
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"reviewStatus"];
    if ([data isEqualToString:@"0"]) {
        return ChooseWord(@"实名认证已审核", [UserCache languageFile]);;
    }else if ([data isEqualToString:@"1"]){
        return ChooseWord(@"暂未实名认证", [UserCache languageFile]);
    }else if ([data isEqualToString:@"2"]){
        return ChooseWord(@"实名认证审核未通过", [UserCache languageFile]);;
    }else if ([data isEqualToString:@"3"]){
        return ChooseWord(@"实名认证正在审核", [UserCache languageFile]);
    }else{
        return  ChooseWord(@"暂未实名认证", [UserCache languageFile]);
    }
}
+(NSString *)getReviewStatus{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"reviewStatus"];
    if ([NSString isNOTNull:data]) {
        return @"1";
    }
    return data;
}
+(void)setUsreAvailableCapital:(NSString *)availableCapital{
    if (![NSString isNOTNull:availableCapital]) {
        [_dataUserCache setObject:availableCapital forKey:@"UsreAvailableCapital" withBlock:nil];
    }
}
+(NSString *)getUsreAvailableCapital{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"UsreAvailableCapital"];
    if ([NSString isNOTNull:data]) {
        return @"0";
    }
    return data;
}
#pragma mark 存用户地址
+(void)setUserAddress:(NSString *)address{
    if (![NSString isNOTNull:address]) {
        [_dataUserCache setObject:address forKey:@"UserAddress" withBlock:nil];
    }
}
#pragma mark 获取用户地址
+(NSString *)getUserAddress{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"UserAddress"];
    if ([NSString isNOTNull:data]) {
        return @"";
    }
    return data;
}
#pragma mark 存是用户的Token
+(void)setUserToken:(NSString *)token{
    if (![NSString isNOTNull:token]) {
        [_dataUserCache setObject:token forKey:@"UserToken" withBlock:nil];
    }
}
#pragma mark 获取用户的Token
+(NSString *)getUserToken{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"UserToken"];
    if ([NSString isNOTNull:data]) {
        return @"";
    }
    return data;
    
}
#pragma mark 保存实名认证填写的名字
+(void)setSaveRealNameWriteName:(NSString *)name{
    if (![NSString isNOTNull:name]) {
        [_dataUserCache setObject:name forKey:@"RealNameWriteName" withBlock:nil];
    }
}
#pragma mark 获取实名认证填写的名字
+(NSString *)getSaveRealNameWriteName{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"RealNameWriteName"];
    if ([NSString isNOTNull:data]) {
        return @"";
    }
    return data;
}
#pragma mark 保存实名认证填选择的证件类型
+(void)setSaveCertificateType:(NSString *)type{
    if (![NSString isNOTNull:type]) {
        [_dataUserCache setObject:type forKey:@"certificateType" withBlock:nil];
    }
}
#pragma mark 获取实名认证的证件类型
+(NSString *)getSaveCertificateType{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"certificateType"];
    if ([NSString isNOTNull:data]) {
        return @"";
    }
    return data;
}

#pragma mark 保存实名认证填写的身份证号
+(void)setSaveRealNameWriteIDCare:(NSString *)idCare{
    if (![NSString isNOTNull:idCare]) {
        [_dataUserCache setObject:idCare forKey:@"RealNameWriteIDCare" withBlock:nil];
    }
}
#pragma mark 获取实名认证填写的身份证号
+(NSString *)getSaveRealNameWriteIDCare{
    NSString *data =(NSString *)[_dataUserCache objectForKey:@"RealNameWriteIDCare"];
    if ([NSString isNOTNull:data]) {
        return @"";
    }
    return data;
}
#pragma mark 保存实名认证获取的正面照
+(void)setSaveRealNamePositiveImage:(UIImage *)positiveImage{
    if (positiveImage != nil) {
        NSData *data = UIImagePNGRepresentation(positiveImage);
        [_dataUserCache setObject:data forKey:@"positiveImage" withBlock:nil];
    }
}
#pragma mark 获取实名认证填写保存的正面照
+(UIImage *)getSaveRealNamePositiveImage{
    NSData *data =(NSData *)[_dataUserCache objectForKey:@"positiveImage"];
    if (data != nil && [data isKindOfClass:[NSData class]]) {
        return [UIImage imageWithData:data];
    }
    return nil;
}

#pragma mark 保存实名认证获取的反面照
+(void)setSaveRealNameNegativeImage:(UIImage *)negativeImage{
    if (negativeImage != nil) {
        NSData *data = UIImagePNGRepresentation(negativeImage);
        [_dataUserCache setObject:data forKey:@"negativeImage" withBlock:nil];
    }
}
#pragma mark 获取实名认证填写保存的反面照
+(UIImage *)getSaveRealNameNegativeImage{
    NSData *data =(NSData *)[_dataUserCache objectForKey:@"negativeImage"];
    if (data != nil && [data isKindOfClass:[NSData class]]) {
        return [UIImage imageWithData:data];
    }
    return nil;
}
+(void)valueEmpty{
    [_dataUserCache setObject:@"" forKey:@"UserId"];
    [_dataUserCache setObject:@"" forKey:@"UserNickName"];
    [_dataUserCache setObject:@"" forKey:@"UserPic"];
    [_dataUserCache setObject:@"" forKey:@"UserSex"];
    [_dataUserCache setObject:@"" forKey:@"UserXinXi"];
    [_dataUserCache setObject:@"" forKey:@"UserTradePassword"];
    [_dataUserCache setObject:@"" forKey:@"UserPhone"];
    [_dataUserCache setObject:@"" forKey:@"UserIdCard"];
    [_dataUserCache setObject:@"" forKey:@"UserRealName"];
    [_dataUserCache setObject:@"" forKey:@"UserAddress"];
    
    [_dataUserCache setObject:@"" forKey:@"reviewStatus" withBlock:nil];
    
    [_dataUserCache setObject:@"" forKey:@"negativeImage"];
    [_dataUserCache setObject:@"" forKey:@"positiveImage"];
    [_dataUserCache setObject:@"" forKey:@"RealNameWriteIDCare"];
    [_dataUserCache setObject:@"" forKey:@"RealNameWriteName"];
    [_dataUserCache setObject:@"" forKey:@"level_info"];
    [_dataUserCache setObject:@"" forKey:@"invite_code"];
    
}
+(void)UserPassEmpty{
    [_dataUserCache setObject:@"" forKey:@"UserPass"];
}
+(NSString *)languageFile{
    NSString *file = [[NSUserDefaults standardUserDefaults] objectForKey:@"languageFile"];
    if ([NSString isNOTNull:file]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"multilingual" forKey:@"languageFile"];
        return @"multilingual";
    }else{
        return file;
    }
}
@end
