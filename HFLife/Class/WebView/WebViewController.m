//
//  GCTViewController.m
//  GCT
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "WebViewController.h"
#import "WebViewJavascriptBridge.h"
#import "UIViewController+LKBubbleView.h"
#import <Masonry/Masonry.h>
#import "WXZTipView.h"
#import "NSString+Helper.h"

#import "CommonTools.h"

#import <SafariServices/SafariServices.h>

#import "ShareProductInfoView.h"
#import <SDWebImageManager.h>
#import "BaseNavigationController.h"
#import "JFCityViewController.h"
static BOOL IsUpdateRemind = YES;


/** 获取 APP 名称 */

#define APP_NAME ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"])

/** 程序版本号 */

#define APP_VERSION [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

/** 获取 APP build 版本 */

#define APP_BUILD ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

/** User-Agent */

@interface WebViewController ()<UIWebViewDelegate,UIScrollViewDelegate,JFCityViewControllerDelegate>
{
    BOOL theBool;
    UIProgressView* myProgressView;
    NSTimer *myTimer;
    NSString *resultString;
    //城市选择block回调
    WVJBResponseCallback cityBlock;
    
    NSString *webTitle;
    
    UIView *maskView;
//    WVJBResponseCallback globalBlock;
}
@property (nonatomic,strong)UIWebView *webV;
//@property (nonatomic, strong) JSContext *jsContext;
@property WebViewJavascriptBridge *bridge;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//     self.edgesForExtendedLayout = UIRectEdgeNone;
        //controller中添加
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _webV = [UIWebView new];
    _webV.backgroundColor = [UIColor whiteColor];
    _webV.scrollView.bounces = NO;
    _webV.scrollView.showsVerticalScrollIndicator = NO;
    _webV.scrollView.showsHorizontalScrollIndicator = NO;
    _webV.dataDetectorTypes = UIDataDetectorTypeNone;
    _webV.delegate = self;
    _webV.scrollView.delegate = self;
     _webV.scrollView.contentInset = UIEdgeInsetsZero;
    [self.view addSubview:_webV];
    [_webV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.view);
//        make.top.m
    }];
    maskView = [UIView new];
    maskView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self loadingWeb];
    [self setupNavBar];
//    [];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [myProgressView removeFromSuperview];
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@""]];
//    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"tianjia")];
    self.customNavBar.barBackgroundImage = [self createImageWithColor:[UIColor whiteColor]];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar wr_setBackgroundAlpha:0 ];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
//    self.customNavBar.backgroundColor = [UIColor whiteColor];
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(scrollView.contentOffset.y <= 0){
       self.customNavBar.title = @"";
        [self.customNavBar wr_setBackgroundAlpha:0];
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@""]];
        return;
    }
        //移动的百分比
    CGFloat ratioY = scrollView.contentOffset.y / (self.navBarHeight); // y轴上移动的百分比
    if(ratioY > 1) {
        self.customNavBar.title = webTitle;
        [self.customNavBar wr_setBackgroundAlpha:1];
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
        return;
    }
    [self.customNavBar wr_setBackgroundAlpha:ratioY];
}
-(void)loadingWeb{
    
    NSURLRequest *request;
    if (self.localHTMLResources) {
        NSString *urlString = @"http://192.168.0.210:9997";
        NSString *url = MMNSStringFormat(@"%@//%@",urlString,self.localHTMLResources[@"targetUrl"]);
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    }else{
        // 获取本地资源路径
//        NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
//            //         通过路径创建本地URL地址
//        NSURL *url = [NSURL fileURLWithPath:pathStr];
//
//        @"/Users/apple/Library/Application Support/iPhone Simulator/6.0/Applications/EF63CAA5-F7A7-480C-B292-A58D5688FBA7/Documents/data/page/common/detail.html?i=1213" http:
//
//        NSString *fileHtml= @"/Users/apple/Library/Application Support/iPhone Simulator/6.0/Applications/EF63CAA5-F7A7-480C-B292-A58D5688FBA7/Documents/data/page/common/detail.html?i=1213";

        NSString *urlString = @"http://192.168.0.210:9997";
        NSString *fileHtml =  MMNSStringFormat(@"%@?cityName=%@&cityID=%@&title=%@",urlString,[MMNSUserDefaults objectForKey:SelectedCity],[MMNSUserDefaults objectForKey:@"cityNumber"],self.titleVC);
            //    NSURL *url = [NSURL URLWithString:@"http://192.168.0.210:9997"];
        NSString *encodString = [NSString stringWithFormat:@"%@",[fileHtml stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        
        request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:encodString]];
    }
    
  	
    
        // 创建请求
//    NSURLRequest * request = [NSURLRequest requestWithURL:url];
        // 通过webView加载请求
    [_webV loadRequest:request];
    
    CGFloat progressBarHeight = 2.f;
    CGFloat navigationBarBounds = 0;
    CGRect barFrame = CGRectMake(0, navigationBarBounds,SCREEN_WIDTH, progressBarHeight);
    myProgressView = [[UIProgressView alloc] initWithFrame:barFrame];
    myProgressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    myProgressView.progressTintColor = [UIColor colorWithRed:43.0/255.0 green:186.0/255.0  blue:0.0/255.0  alpha:1.0];
    [self.view addSubview:myProgressView];
    
        // 开启日志
    [WebViewJavascriptBridge enableLogging];
        // 给哪个webview建立JS与OjbC的沟通桥梁
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:_webV];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"getBlogNameFromObjC" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"js call getBlogNameFromObjC, data from js is %@", data);
#define mark 在这里吗可以实现OC这边的变化
        NSDictionary *dict =(NSDictionary *)data;
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSArray *array = dict[@"param"];
            NSString *selectorStr = dict[@"type"];
            NSLog(@"array = %@",array);
            NSLog(@"selectorStr = %@",selectorStr);
            WVJBResponseCallback response = ^(id results){
                responseCallback(results);
            };
            if (array.count == 0&&![selectorStr isEqualToString:@"realNameAuthenticationParam:"]) {
                SEL selector = NSSelectorFromString(selectorStr);
                IMP imp = [self methodForSelector:selector];
                id (*func)(id, SEL, WVJBResponseCallback) = (void *)imp;
                func(self, selector,response);
            }else if ([selectorStr isEqualToString:@"realNameAuthenticationParam:"]){
                SEL selector = NSSelectorFromString(selectorStr);
                IMP imp = [self methodForSelector:selector];
                    //                id (*func)(id,SEL) = (void *)imp;
                void (*func)(id,SEL,NSArray *) = (void *)imp;
                func(self,selector,array);
            }else if ([selectorStr isEqualToString:@"savePictureParamParam:"]){
                SEL selector = NSSelectorFromString(selectorStr);
                IMP imp = [self methodForSelector:selector];
                    //                id (*func)(id,SEL) = (void *)imp;
                void (*func)(id,SEL,NSArray *) = (void *)imp;
                func(self,selector,array);
            }else if ([selectorStr isEqualToString:@"goHotelDetailResponseCallback:"]){
                SEL selector = NSSelectorFromString(selectorStr);
                IMP imp = [self methodForSelector:selector];
                    //                id (*func)(id,SEL) = (void *)imp;
                void (*func)(id,SEL,NSArray *) = (void *)imp;
                func(self,selector,array);
            }else if ([selectorStr isEqualToString:@"goViewMapResponseCallback:"]){
                SEL selector = NSSelectorFromString(selectorStr);
                IMP imp = [self methodForSelector:selector];
                    //                id (*func)(id,SEL) = (void *)imp;
                void (*func)(id,SEL,NSArray *) = (void *)imp;
                func(self,selector,array);
            }else{
                
                SEL selector = NSSelectorFromString(selectorStr);
                IMP imp = [self methodForSelector:selector];
                id (*func)(id, SEL,NSArray *,WVJBResponseCallback) = (void *)imp;
                func(self, selector,array,response);
                
            }
        }else{
            NSDictionary *results = @{@"status":@"0",
                                      @"msg":@"操作失败"
                                      };
            if (responseCallback) {
                    // 反馈给JS
                /**
                 js调用网页里面的getBlogNameFromObjC方法。OC通过responseCallback数据回调传给js完成数据更新
                 这里面我们点击js里面的点击事件，然后到OC里面逛了一圈，在回调里面给一个
                 */
                responseCallback(results);
            }
        }
        
    }];
}

-(void)versionUpdateRequest{
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
//     [self showRoundProgressWithTitle:@"加载中"];
    //开始加载网页调用此方法
    myProgressView.progress = 0;
    theBool = false;
    myTimer = [NSTimer scheduledTimerWithTimeInterval:0.01667 target:self selector:@selector(timerCallback) userInfo:nil repeats:YES];
}
-(void)timerCallback {
    if (theBool) {
        if (myProgressView.progress >= 1) {
            myProgressView.hidden = true;
            [myTimer invalidate];
        }
        else {
            myProgressView.progress += 0.1;
        }
    }
    else {
        myProgressView.progress += 0.05;
        if (myProgressView.progress >= 0.95) {
            myProgressView.progress = 0.95;
        }
    }
}
#pragma mark ====扫一扫====
-(void)scanResponseCallback:(WVJBResponseCallback)responseCallback{
   
}
#pragma mark ====复制====
-(void)copyParam:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback{
    
}
#pragma mark ====获取版本号====
-(void)getVersionNumberResponseCallback:(WVJBResponseCallback)responseCallback{
    NSLog(@"APP_VERSION=%@",APP_VERSION);
    // 获取 Plist 文件路径
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    // 获取 Plist 文件内容
//    NSDictionary *rootDict = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSLog(@"rootDict = %@",rootDict);
//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow(CFBridgingRetain(infoDictionary));
        // app版本
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

//    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
        // app版本
//    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    if (responseCallback) {
        NSDictionary *dict = @{@"status":@"1",
                               @"data"  :@{@"value":MMNSStringFormat(@"%@",APP_VERSION)},
                               @"msg"    :@"操作成功"
                               };
        responseCallback(dict);
    }
}
#pragma mark ====获取日期====
-(void)calendarResponseCallback:(WVJBResponseCallback)responseCallback{
   
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ====城市选择====
-(void)selectCityResponseCallback:(WVJBResponseCallback)responseCallback{
    cityBlock = responseCallback;
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.delegate = self;
    cityViewController.title = @"城市";
    BaseNavigationController *navigationController = [[BaseNavigationController alloc] initWithRootViewController:cityViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}
#pragma mark ====分享朋友圈====
-(void)shareParamResponseCallback:(WVJBResponseCallback)responseCallback{
    NSLog(@"分享");
    [self addGuanjiaShareView];
}
#pragma mark ====实名认证====
-(void)realNameAuthenticationParam:(NSArray *)parm{
    NSLog(@"realNameAuthentication");

}
#pragma mark ====点击跳转====
-(void)goHotelDetailResponseCallback:(NSArray *)parm{
    WebViewController *web = [[WebViewController alloc]init];
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    for (NSDictionary *dict in parm) {
        [muDict setDictionary:dict];
    }
    web.localHTMLResources = muDict;
    [self.navigationController pushViewController:web animated:YES];
}
#pragma mark ====地图点击====
-(void)goViewMapResponseCallback:(NSArray *)parm{
    NSLog(@"parm = %@",parm);
}
#pragma mark ====保存图片到本地====
-(void)savePictureParamParam:(NSArray *)parm{
   
}
#pragma mark ====保存图片到本地====
-(void)saveScreenCallback:(WVJBResponseCallback)responseCallback{
}
#pragma mark ====清除缓存====
-(void)clearWebViewCacheCallback:(WVJBResponseCallback)responseCallback{
        //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]){
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache * cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];[cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];

}
#pragma mark ====返回首页====
-(void)goHomeCallback:(WVJBResponseCallback)responseCallback{
        // 获取本地资源路径
    NSString *pathStr = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"dist"];
        //        // 通过路径创建本地URL地址
    NSURL *url = [NSURL fileURLWithPath:pathStr];
        //     NSURL *url = [NSURL URLWithString:@"http://192.168.0.220:8085/login"];
        // 创建请求
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
        // 通过webView加载请求
    [_webV loadRequest:request];
//    if ([_webV canGoBack]) {
//        [_webV goBack];
//    }
    
}
#pragma mark ====支付宝支付====
-(void)alipayPayment:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback{
    
   
}
#pragma mark ====微信支付====
-(void)weChatPay:(NSArray *)parm ResponseCallback:(WVJBResponseCallback)responseCallback{
   
}
-(void)detectionUpdateResponseCallback:(WVJBResponseCallback)responseCallback{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
//    CFShow((__bridge CFTypeRef)(infoDictionary));
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSLog(@"当前版本是：%@",app_Version);
}
- (void)toSaveImage:(NSString *)urlString {
    [self showRoundProgressWithTitle:@"加载中"];
    NSURL *url = [NSURL URLWithString: urlString];
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    __block UIImage *img;
    [manager diskImageExistsForURL:url completion:^(BOOL isInCache) {
        if (isInCache) {
             img =  [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
        }else{
            //从网络下载图片
            NSData *data = [NSData dataWithContentsOfURL:url];
            img = [UIImage imageWithData:data];
        }
            // 保存图片到相册中
        UIImageWriteToSavedPhotosAlbum(img,self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
    }];
//    if ([manager diskImageExistsForURL:url])
//    {
//        img =  [[manager imageCache] imageFromDiskCacheForKey:url.absoluteString];
//    }
//    else
//    {
//            //从网络下载图片
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        img = [UIImage imageWithData:data];
//    }
    
    
}
//保存图片完成之后的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    [self hideBubble];
        // Was there an error?
    if (error != NULL)
    {
        [WXZTipView showCenterWithText:@"图片保存失败"];
    }
    else  // No errors
    {
         [WXZTipView showCenterWithText:@"图片保存成功"];
    }
}

//网页加载完成调用此方法
-(void) webViewDidFinishLoad:(UIWebView *)webView {
//    [self hideBubble];
    //获取当前页面的title
    webTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    [myProgressView removeFromSuperview];
    NSDictionary *dict = @{@"status":@"1",
                           @"data"  :@{@"cityName":[MMNSUserDefaults objectForKey:SelectedCity],
                                       @"cityID":[MMNSUserDefaults objectForKey:@"cityNumber"]
                                       },
                           @"msg"    :@"操作成功"
                           };
    [self.bridge callHandler:@"getCityInfo" data:dict responseCallback:^(id responseData) {
        NSLog(@"from js: %@", responseData);
    }];
    //去除长按后出现的文本选取框
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    if (!maskView.hidden) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self->maskView.hidden = YES;
        });
    }
}
#pragma mark JFCityViewControllerDelegate 选择城市定位
- (void)cityName:(NSString *)name {
    NSDictionary *dict = @{@"status":@"1",
                           @"data"  :@{@"cityName":name,@"cityID":@"1010110"},
                           @"msg"    :@"操作成功"
                           };
    cityBlock(dict);
}

-(void)setTitleVC:(NSString *)titleVC{
    _titleVC = titleVC;
    
}
-(void)axcBaseClickBaseRightImageBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)addGuanjiaShareView {
   
}

-(void)cleanCacheAndCookie{
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    //清除UIWebView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLCache *cache = [NSURLCache sharedURLCache];
    [cache removeAllCachedResponses];
    [cache setDiskCapacity:0];
    [cache setMemoryCapacity:0];
}
- (UIImage*)createImageWithColor: (UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();return theImage;
    
}
-(void)dealloc{
    [self cleanCacheAndCookie];
}
@end
