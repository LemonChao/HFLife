//
//  setCookiesTool.h
//  huzhu
//
//  Created by CTD－JJP on 2017/4/25.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface setCookiesTool : NSObject
-(void)saveHttpCookie;
-(void)loadHttpCookie;
- (void)clearHttpCookie;
- (NSArray *)cachedCookiesArray;
@end
