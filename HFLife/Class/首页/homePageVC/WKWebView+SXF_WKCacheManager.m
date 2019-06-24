//
//  WKWebView+SXF_WKCacheManager.m
//  HFLife
//
//  Created by mac on 2019/6/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "WKWebView+SXF_WKCacheManager.h"

@implementation WKWebView (SXF_WKCacheManager)




- (void) cacheWebViewDataWithUrl:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr ? urlStr : @""];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"response:%@",response);
        NSLog(@"data:%@",data);
        NSLog(@"error:%@",error.description);
        
        if (error == nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self loadData:data MIMEType:@"text/html" characterEncodingName:@"utf-8" baseURL:[NSURL URLWithString:urlStr]];
                
                
                
                //存储data
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:urlStr];
                
                
            });
        }
    }];
    [task resume];
}

- (void) loadDataWithUrl:(NSString *)urlStr{
    //取出缓存
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:urlStr];
    if (data) {
        [self loadData:data MIMEType:@"text/html" characterEncodingName:@"utf-8" baseURL:[NSURL URLWithString:urlStr]];
    }else{
        //添加缓存
        [self cacheWebViewDataWithUrl:urlStr];
    }
}



@end
