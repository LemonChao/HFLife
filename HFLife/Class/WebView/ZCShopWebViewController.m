//
//  ZCShopWebViewController.m
//  HFLife
//
//  Created by zchao on 2019/5/28.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopWebViewController.h"
#import <WebKit/WebKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import "UMSPPPayUnifyPayPlugin.h"
#import <AFURLResponseSerialization.h>
#import "WeakWebViewScriptMessageDelegate.h"
#import "JMTabBarController.h"

@interface ZCShopWebViewController ()<WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate>

@property(nonatomic, strong)WKWebView *webView;
@end

@implementation ZCShopWebViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.topInset = 0;
        self.bottomInset = HomeIndicatorHeight;
        self.isNavigationHidden = self.isHidenLeft = YES;
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path parameters:(nullable NSDictionary *)parameters
{
    self = [super init];
    if (self) {
        self.topInset = 0;
        self.bottomInset = HomeIndicatorHeight;
        self.isNavigationHidden = self.isHidenLeft = YES;
        self.pathForH5 = path;
        self.parameters = parameters;//
//        if (DictIsEmpty(self.parameters)) {
//            self.urlString = StringFormat(@"%@/mall/#/%@",shopWebHost,self.pathForH5);
//        }else {
//            self.urlString = StringFormat(@"%@/mall/#/%@?%@",shopWebHost,self.pathForH5,AFQueryStringFromParameters(self.parameters));
//        }
        self.urlString = StringFormat(@"%@/mall/#/%@?%@",shopWebHost,self.pathForH5,AFQueryStringFromParameters(self.parameters));

    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(self.topInset);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).inset(HomeIndicatorHeight);
    }];
    
    [self loadWKwebViewData];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self addUserScript];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = self.webTitle;
    [self.customNavBar wr_setContentViewColor:[UIColor clearColor]];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}


-(void)loadWKwebViewData{
    [[WBPCreate sharedInstance]showWBProgress];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
    [self.webView loadRequest:request];
}
#pragma mark - WKWebView代理 WKUIDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //    Decides whether to allow or cancel a navigation after its response is known.
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");

    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"开始加载");
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"跳转到其他的服务器");
    
}
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"网页由于某些原因加载失败");
    [[WBPCreate sharedInstance] hideAnimated];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页开始接收网页内容");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页导航加载完毕");
    //判断 银联外链
    if ([webView.URL.host containsString:@"chinaums"]) {
        self.customNavBar.hidden = NO;
        NSString *injectionJSString = @"var script = document.createElement('meta');"
        "script.name = 'viewport';"
        "script.content=\"width=device-width, user-scalable=yes\";"
        "document.getElementsByTagName('head')[0].appendChild(script);";
        [webView evaluateJavaScript:injectionJSString completionHandler:nil];
        
    }else{
        self.customNavBar.hidden = YES;//加载成功隐藏 使用web导航
    }

    [[WBPCreate sharedInstance] hideAnimated];

}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败,失败原因:%@",[error description]);
    [[WBPCreate sharedInstance] hideAnimated];
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"网页加载内容进程终止");
    [[WBPCreate sharedInstance] hideAnimated];
}

- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - JS调用OC方法
- (void)loginApp:(NSString *)body {
    [LoginVC login];
}

#pragma mark -跳转设置支付密码
-(void)goSetPayPassword:(NSString *)body{
    [self.navigationController pushViewController:[NSClassFromString(@"YYB_HF_setDealPassWordVC") new] animated:YES];
}
#pragma mark -返回--
- (void)goToHome:(NSString *)body{
    if (StringIsEmpty(body) || body.integerValue == 0) { //有时会传NSNull
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)goBackToShopHome:(NSUInteger)idx {
    
    JMTabBarController *tabBarVC = [JMConfig config].tabBarController;
    NSUInteger index = [tabBarVC.viewControllers indexOfObject:self.navigationController];
    
    [self.navigationController popViewControllerAnimated:YES];
    if (idx == index) return; //当前选中就为目标Home
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC));
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{

        [[JMConfig config].tabBarController setSelectedIndex:idx];
    });
}

#pragma mark --银联商务调起支付宝支付---
-(void)goToPayParameter:(NSDictionary *)dict{
    NSString *type = [NSString stringWithFormat:@"%@", dict[@"payType"] ? dict[@"payType"] : @""];
    NSDictionary *payInfo = dict[@"pullPayInfo"];
    if (DictIsEmpty(payInfo)) {
        [WXZTipView showBottomWithText:@"支付参数错误"];
        return;
    }
    
    NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:payInfo options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
 
    if ([type isEqualToString:@"0"]) { // 余额支付
    }
    else if ([type isEqualToString:@"1"]) { //支付宝
        //开启轮询订单
        __weak typeof(self) weak_self = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [[WBPCreate sharedInstance] showWBProgress];
            [weak_self pollingOrderResult:dict[@"orderId"]];
        }];
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {}];
    }
    else if ([type isEqualToString:@"2"]) { //微信
        
        [UMSPPPayUnifyPayPlugin registerApp:payInfo[@"appid"]];
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_WEIXIN payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            [self handlePayResultL:resultCode info:resultInfo];
        }];
    }
    else if ([type isEqualToString:@"3"]){
        
        [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayHanPay" payData:payDataJsonStr viewController:self callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            [self handlePayResultL:resultCode info:resultInfo];
        }];
    }
}

/**
 处理支付结果
 0000 支付成功
 1000 用户取消支付
 1001 参数错误
 1002 网络连接错误
 1003 支付客户端未安装
 2001 订单处理中，支付结果未知(有可能已经支付成功)，请通过后台接口查询订单状态
 2002 订单号重复
 2003 订单支付失败
 9999 其他支付错误
 */
-(void)handlePayResultL:(NSString *)resultCode info:(NSString *)resultInfo {
    
    if ([resultCode isEqualToString:@"0000"]) {
        [self.webView evaluateJavaScript:@"payState('success')" completionHandler:nil];
    }else {
        [self.webView evaluateJavaScript:@"payState('fail')" completionHandler:nil];
    }
    
    if ([resultCode isEqualToString:@"1003"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [WXZTipView showBottomWithText:@"客户端未安装" duration:1.5];
        }];
        return;
    }
}


- (void)pollingOrderResult:(NSString *)orderId {
    static NSInteger pollingCount = 0;
    @weakify(self);
    [networkingManagerTool requestToServerWithType:POST withSubUrl:pollingOrderState withParameters:@{@"pay_id":orderId} withResultBlock:^(BOOL result, id value) {
        @strongify(self);
        if (result || pollingCount >= 4) {
            [[WBPCreate sharedInstance] hideAnimated];
            [self handlePayResultL:result ? @"0000" : @"2001" info:@"订单处理中"];
            
        }else {
            pollingCount++;
            [self performSelector:@selector(pollingOrderResult:) withObject:orderId afterDelay:2.f];
        }
    }];
}

//更新插入的JavaScript
- (void)addUserScript {
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"tabbarHeight"] = MMNSStringFormat(@"%f",self.heightStatus);
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN];
    dic[@"device"] = [SFHFKeychainUtils GetIOSUUID];
    dic[@"locationCity"] = [[NSUserDefaults standardUserDefaults] valueForKey:LocationCity];
    
    NSLog(@"window.iOSInfo:%@", dic);
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSString *js = [NSString stringWithFormat:@"window.iOSInfo = %@", jsonStr];
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
    
    [self.webView.configuration.userContentController addUserScript:script];
}

#pragma mark -- WKScriptMessageHandler
/**
 *  JS 调用 OC 时 webview 会调用此方法
 *
 *  @param userContentController  webview中配置的userContentController 信息
 *  @param message                JS执行传递的消息
 */

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //JS调用OC方法
    //message.boby就是JS里传过来的参数
    NSLog(@"name:%@ body:%@", message.name, message.body);
    if ([message.name isEqualToString:@"loginApp"]){
        [self loginApp:message.body];
    }else if ([message.name isEqualToString:@"goSetPayPassword"]){
        [self goSetPayPassword:message.body];
    }else if ([message.name isEqualToString:@"goPay"]){
        [self goToPayParameter:message.body];
    }else if ([message.name isEqualToString:@"goToHome"]){
        [self goToHome:message.body];
    }else if ([message.name isEqualToString:@"goBackToShopHome"]){
        [self goBackToShopHome:0];
    }else if ([message.name isEqualToString:@"goBackToClassifyHome"]){
        [self goBackToShopHome:1];
    }else if ([message.name isEqualToString:@"goBackToShopCarHome"]){
        [self goBackToShopHome:2];
    }
}


#pragma mark - setter && getter

- (WKWebView *)webView {
    if (!_webView) {
        
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goToHome"];//H5返回按钮事件
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goBackToShopHome"];// 返回到商城首页
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goBackToClassifyHome"];// 返回到分类首页
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goBackToShopCarHome"];// 返回到购物车首页
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goPay"];// 商城确认支付按钮
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goSetPayPassword"];//设置余额支付密码
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"loginApp"];//重新登陆

        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = wkUController;
        //    preferences.minimumFontSize = 40.0;
        config.preferences = preferences;
        
        /*
         禁止长按(超链接、图片、文本...)弹出效果
         document.documentElement.style.webkitTouchCallout='none';
         去除长按后出现的文本选取框
         document.documentElement.style.webkitUserSelect='none'; */
        NSString *jsString = @"document.documentElement.style.webkitTouchCallout='none';document.documentElement.style.webkitUserSelect='none';";
        WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:jsString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
        [config.userContentController addUserScript:noneSelectScript];
        
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        if (@available(iOS 11.0, *)) {
            _webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            [self setAutomaticallyAdjustsScrollViewInsets:NO];
        }
        self.navigationController.edgesForExtendedLayout = UIRectEdgeTop;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.allowsLinkPreview = NO;
    }
    return _webView;
}

@end
