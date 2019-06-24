//
//  WKWebView+SXF_WKCacheManager.h
//  HFLife
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <WebKit/WebKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WKWebView (SXF_WKCacheManager)
//缓存 web 数据
- (void) cacheWebViewDataWithUrl:(NSString *)urlStr;
//加载缓存数据 没缓存 就去缓存
- (void) loadDataWithUrl:(NSString *)urlStr;
@end

NS_ASSUME_NONNULL_END
