//
//  AppConfiger.h
//  HFLife
//
//  Created by mac on 2019/5/18.
//  Copyright © 2019 luyukeji. All rights reserved.
//
#ifndef AppConfiger_h
#define AppConfiger_h


#pragma mark - 第三方Key
//微信
#define WX_APP_ID          @"wxf9817e2bc71f2351"
#define WX_APP_SECRET      @"755227d32d21a5ac8470bb22258f6bdd"
//QQ（空间，好友）
#define QQ_APP_ID          @"1108045627"
#define QQ_APP_SECRET      @"V2oDZX84Wrevt1iJ"

//融云
#define RY_APP_KEY  @"qd46yzrfqigrf"
//高德地图
#define MAP_KEY @"449fbe9edd1041405ee25e556ac9fb6c"
//极光推送
#define kJPAppKey @"097ab589f03a66f38e92ad0f"

#define ENCRYPTIONPUBLICKEY @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC5yqzvM4FICzIlQejoSDSDCRn/P6zwmVEKf787GveB6+pDu2+nanvemnZ75CeJftfRkjgpnoxW96uASss5KfJ7zvNQjEfEG6az2aaJtSQ2/CJXBuRL9FZgUzSnx3ofuTTYCygdCbJnUyz5GezYgh71zqO4C2TWVwL8Vw6YGafIYQIDAQAB"


//公钥
#define AMOUNTRSAPRIVATEKEY   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCsigA+SqY6GQJhpPh6Rxf8L6qm4qj/zozC+fl6H3e1tx40IY+UDBPz+6K1iHmwmUvo8Sl2szK1XllQv+sPrah2YaZb5+jC1ia5vCwSvz3gwqbOXccfPBptEGmdW0dkgcS9Ft6kQIgjZ85BVbYbec2shQ1N3Bt9l8aF/iUt39awpwIDAQAB"

//私钥
#define  AMOUNTRSAPUBLICKEY @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAKyKAD5KpjoZAmGk+HpHF/wvqqbiqP/OjML5+Xofd7W3HjQhj5QME/P7orWIebCZS+jxKXazMrVeWVC/6w+tqHZhplvn6MLWJrm8LBK/PeDCps5dxx88Gm0QaZ1bR2SBxL0W3qRAiCNnzkFVtht5zayFDU3cG32XxoX+JS3f1rCnAgMBAAECgYEAqT2EF5XpjztQ1q6W/HoX0MqAvcm+s4zLDcVdLKkJJzlDaycwSqu+NqgxZZdEpjD4ALntTf1gU/8D5O0biPlyL272hkUm6CichblWlHkRexzV+EmYKuXY8+1VvpxIpxtt5XQChwVSwKVLZ0a4XjttB6KfOsk35lDgzfehKHH6m2ECQQDjGs0l3Ho2aoUwOCxGRqjfr2i7VL0v0Y5Pp8ciK4NGoQkMQ8sTJ9+ScDpFFEfWCqTaG7bijAGyDIuzK60Z9V5FAkEAwn3mvKSsmSdWJm8bN0Py95ct8omfNWID9GjGtz16Ju/lzAjcLCydQqyOjR8C6zEa8ZAYw941YA0Z+XvWHBfn+wJBALqzDNXEVEAp/8ZtV5CKhEgn1uyyNDl8iAbaAi4IIYrN1jdcADWGQRkM5ApoKso+w9l+kTHbMYWjJLGuBUdi3RUCQGvnfgRbOIcgE+Pu8KKQyFQlRBCz2ei8IIWRO+6d5Q+FOXEh2UWI2xcKtWwGMJBcBh7PW24P8nz/x9Fqqzea69ECQCUbtPMJqNI2H/jvrcjoLZlzfALRtEb/FgmOJWrYIZ7oaYVlnh350lahsPttGzeJXOZr/mZqLKCBxUGH5YH42CU="




//城市存储
//选择的城市
static NSString *const selectedCity         = @"selectedCity";
static NSString *const selectedCityID       = @"selectedCityID";
//定位的城市
static NSString *const locationCity         = @"locationCity";
static NSString *const locationCityID       = @"locationCityID";



//登录配置
//static NSString *LogInSyccessFully         = @"logInSyccessFully";
//static NSString * LOGIN_APP                 = @"LOGIN_MYAPP";
//存储token
static NSString *const USER_TOKEN           = @"userToken";
//存储登录状态
static NSString *const LOGIN_STATES         = @"loginStates";



#pragma mark - notificationKey
// 购物车改变通知
#define cartValueChangedNotification     @"CartValueChangedNotification"


#pragma mark - NSUserDefaultsKey
#define LogIn_Success                  [[[NSUserDefaults standardUserDefaults] objectForKey:LOGIN_STATES] integerValue] == 1
#define GetUserToken                      [[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN]



#endif /* AppConfiger_h */
