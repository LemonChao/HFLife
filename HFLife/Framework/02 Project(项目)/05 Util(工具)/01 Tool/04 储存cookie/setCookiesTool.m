//
//  setCookiesTool.m
//  huzhu
//
//  Created by CTD－JJP on 2017/4/25.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "setCookiesTool.h"
#import <Foundation/NSHTTPCookieStorage.h>
@implementation setCookiesTool



-(void)saveHttpCookie{
    
    NSData *cookies = [NSKeyedArchiver archivedDataWithRootObject:[NSHTTPCookieStorage sharedHTTPCookieStorage].cookies];
    [[NSUserDefaults standardUserDefaults] setObject:cookies forKey:@"cookies"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)loadHttpCookie{
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (NSHTTPCookie *cookie in [self cachedCookiesArray]) {
        [cookieStorage setCookie:cookie];
    }
}

- (void)clearHttpCookie{
    
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    
    for (id cookie in cookies) {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"cookies"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)cachedCookiesArray
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:@"cookies"]];
}





@end
