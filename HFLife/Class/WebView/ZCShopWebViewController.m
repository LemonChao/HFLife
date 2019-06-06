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
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MapViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UMSPPPayUnifyPayPlugin.h"
#import <AFURLResponseSerialization.h>
#import "WeakWebViewScriptMessageDelegate.h"

@interface ZCShopWebViewController ()<WKUIDelegate,WKScriptMessageHandler,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate>
{
    UIImagePickerController *imagePickerController;
    
}
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
        if (DictIsEmpty(self.parameters)) {
            self.urlString = StringFormat(@"%@#/%@",shopWebHost,self.pathForH5);
        }else {
            self.urlString = StringFormat(@"%@#/%@?%@",shopWebHost,self.pathForH5,AFQueryStringFromParameters(self.parameters));
        }
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom).priority(1000);
        make.top.equalTo(self.view).offset(self.topInset).priority(900);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).inset(HomeIndicatorHeight);
    }];
    
    
    [self loadWKwebViewData];
    
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    if (self.isNavigationHidden) {
        [self.customNavBar removeFromSuperview];
    }
    
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

    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
}


-(void)loadWKwebViewData{
    [[WBPCreate sharedInstance]showWBProgress];
    if (![NSString isNOTNull:self.urlString]) {
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        [self.webView loadRequest:request];
        NSLog(@"url:%@", self.urlString);
    }else{
        [self loadFailed];
    }
}
#pragma mark - WKWebView代理
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
    [self loadFailed];
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页开始接收网页内容");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"网页导航加载完毕");
    [self loadSuccess];

}
- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败,失败原因:%@",[error description]);
    [self loadFailed];
}
- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    NSLog(@"网页加载内容进程终止");
    [self loadFailed];
}
#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
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
    NSLog(@"body:%@",message.body);
    if ([message.name isEqualToString:@"Call"]) {
        [self CallParameter:message.body];
    }else if ([message.name isEqualToString:@"getStatus"]){
        [self getStatusParameter:message.body];
    }else if ([message.name isEqualToString:@"getAddress"]){
        [self getAddressParameter:message.body];
    }else if ([message.name isEqualToString:@"getNear"]){
        [self getNearParameter:message.body];
    }else if ([message.name isEqualToString:@"pageJump"]){
        [self pageJumpParameter:message.body];
    }else if ([message.name isEqualToString:@"goShopping"]){
        [self goShoppingParameter:message.body];
    }else if ([message.name isEqualToString:@"nativeToJump"]){
        [self nativeToJumpParameter:message.body];
    }else if ([message.name isEqualToString:@"rushBuy"]){
        [self rushBuyParameter:message.body];
    }else if ([message.name isEqualToString:@"orderHotel"]){
        [self orderHotelParameter:message.body];
    }else if ([message.name isEqualToString:@"submitOrder"]){
        [self submitOrderParameter:message.body];
    }else if ([message.name isEqualToString:@"goPay"]){
        [self goToPayParameter:message.body];
    }else if ([message.name isEqualToString:@"goBackToShopHome"]){
        [self goBackToShopHome];
    }else if ([message.name isEqualToString:@"goToHome"]){
        [self goBack:message.body];
    }
}

#pragma mark - JS调用OC方法
#pragma mark -拨打电话
-(void)CallParameter:(NSDictionary *)dict{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[NSString judgeNullReturnString:dict[@"tel"]]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
#pragma mark -网络数据是否请求成功
-(void)getStatusParameter:(NSDictionary *)dict{
    NSString *isSuccess = MMNSStringFormat(@"%@",dict[@"status"]);
    if ([isSuccess isEqualToString:@"1"]) {
        NSLog(@"数据请求成功");
        [self loadSuccess];
    }else{
        NSLog(@"数据请求失败");
        [self loadFailed];
    }
}
#pragma mark -获取地理位置
-(void)getAddressParameter:(NSDictionary *)dict{
//    MapViewController *map = [[MapViewController alloc]init];
//    CLLocationCoordinate2D gaocoor;
//    gaocoor.latitude = [MMNSStringFormat(@"%@",dict[@"latitude"]) floatValue];
//    gaocoor.longitude = [MMNSStringFormat(@"%@",dict[@"longitude"]) floatValue];
//    CLLocationCoordinate2D coor = [JZLocationConverter bd09ToGcj02:gaocoor];
//    map.latitude = coor.latitude;
//    map.longitude = coor.longitude;
//    map.isMark = YES;
//    [self.navigationController pushViewController:map animated:YES];
}
#pragma mark -参数跳转
-(void)getNearParameter:(NSDictionary *)dict{
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    //    NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
    //    NSString *coupon_id = MMNSStringFormat(@"%@",dict[@"coupon_id"]);
    wkWebView.isNavigationHidden = YES;
    NSString *shop_id = MMNSStringFormat(@"%@",dict[@"shop_id"]);
    
    wkWebView.jointParameter = MMNSStringFormat(@"?shop_id=%@",shop_id);
    //    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
    [self.navigationController pushViewController:wkWebView animated:YES];
}
#pragma mark -URL跳转
-(void)pageJumpParameter:(NSDictionary *)dict{
    NSLog(@"dict = %@",dict);
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"href"]];
    wkWebView.isNavigationHidden = [MMNSStringFormat(@"%@",dict[@"bar"]) isEqualToString:@"1"]?YES:NO;
    wkWebView.webTitle = [NSString judgeNullReturnString:dict[@"title"]];
    [self.navigationController pushViewController:wkWebView animated:YES];
}
#pragma mark -去购买
-(void)goShoppingParameter:(NSDictionary *)dict{
}
#pragma mark -跳转原生界面
-(void)nativeToJumpParameter:(NSDictionary *)dict{
    /**
     {
     VCName:@"LandlordInformationVC",
     data:{@"shop_id":@"1"}
     }
     */
    // 类名
    NSString *class = dict[@"VCName"];
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    // 从一个字串返回一个类
    Class newClass = objc_getClass(className);
    if (!newClass)
    {
        // 创建一个类
        Class superClass = [NSObject class];
        newClass = objc_allocateClassPair(superClass, className, 0);
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    // 创建对象
    id instance = [[newClass alloc] init];
    BaseViewController *vc = (BaseViewController *)instance;
    vc.dataParameter = dict[@"data"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark -返回--
- (void)goBack:(NSString *)body{
    if (body.integerValue == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (!body.integerValue || [body isEqualToString:@"返回"] || body.integerValue == 1) {
        
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)goBackToShopHome {
    
//    [self.navigationController popViewControllerAnimated:YES];
//    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC));
//    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
//
//        NSLog(@"tab:%@", self.tabBarController);
//        [self.tabBarController setSelectedIndex:0];
//    });
    
    [self.tabBarController setSelectedIndex:0];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark -抢购--
-(void)rushBuyParameter:(NSDictionary *)dict{
    NSLog(@"dict = %@",dict);
    if ([NSString isNOTNull:[HeaderToken getAccessToken]]) {
    }
}
#pragma mark -酒店预定(抢购)--
-(void)orderHotelParameter:(NSDictionary *)dict{
    WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"href"]];
    wkWebView.isNavigationHidden = [MMNSStringFormat(@"%@",dict[@"bar"]) isEqualToString:@"1"]?YES:NO;
    wkWebView.webTitle = [NSString judgeNullReturnString:dict[@"title"]];
    [self.navigationController pushViewController:wkWebView animated:YES];
}
#pragma mark --提交订单---
-(void)submitOrderParameter:(NSDictionary *)dict{
    if ([NSString isNOTNull:[HeaderToken getAccessToken]]) {
    }
    NSLog(@"dict = %@",dict);
    NSString *mobile = dict[@"mobile"];
    if ([NSString isNOTNull:mobile]) {
        [WXZTipView showCenterWithText:@"请填写手机号"];
        return;
    }
    NSString *namestr = dict[@"name"];
    
    NSArray *names = [self toArrayOrNSDictionary:[namestr dataUsingEncoding:NSUTF8StringEncoding]];
    if (names.count == 0) {
        [WXZTipView showCenterWithText:@"请填写入驻人姓名"];
        return;
    }
    for (NSString *str in names) {
        if (str.length==0) {
            [WXZTipView showCenterWithText:@"请填写入驻人姓名"];
            return;
        }
    }
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
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pollingOrderResult:) name:UIApplicationWillEnterForegroundNotification object:@""];
        
        __weak typeof(self) weak_self = self;
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
            [weak_self pollingOrderResult:dict[@"orderId"]];
        }];
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            // will not invoked
        }];
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
-(void)handlePayResultL:(NSString *)resultCode info:(NSString *)resultInfo { //1000 取消 0000支付成功
    
    if ([resultCode isEqualToString:@"0000"]) {
        [self.webView evaluateJavaScript:@"payState('success')" completionHandler:nil];
    }else {
        [self.webView evaluateJavaScript:@"payState('fail')" completionHandler:nil];
    }
    
    if ([resultCode isEqualToString:@"1003"]) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [WXZTipView showBottomWithText:@"客户端未安装" duration:1.5];
        }];
    }
}


- (void)pollingOrderResult:(NSString *)orderId {
    static NSInteger pollingCount = 0;
    @weakify(self);
    [networkingManagerTool requestToServerWithType:POST withSubUrl:pollingOrderState withParameters:@{@"pay_sn":orderId} withResultBlock:^(BOOL result, id value) {
        @strongify(self);
        if (result || pollingCount >= 4) {
            [self handlePayResultL:result ? @"0000" : @"2001" info:@"订单处理中"];
            
//            [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
        }else {
            pollingCount++;
            [self performSelector:@selector(pollingOrderResult:) withObject:orderId afterDelay:2.f];
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark ==加载失败
-(void)loadFailed{
    [[WBPCreate sharedInstance] hideAnimated];
}
#pragma mark ==加载成功
-(void)loadSuccess{
    [[WBPCreate sharedInstance] hideAnimated];
}
- (NSArray *)stringToJSON:(NSString *)jsonStr {
    if (jsonStr) {
        id tmp = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
        if (tmp) {
            
            if ([tmp isKindOfClass:[NSArray class]]) {
                return tmp;
            } else if([tmp isKindOfClass:[NSString class]]|| [tmp isKindOfClass:[NSDictionary class]]) {
                return [NSArray arrayWithObject:tmp];
            } else {
                return nil;
            }
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}
-  (id)toArrayOrNSDictionary:(NSData *)jsonData{
    
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingAllowFragments
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        // 解析错误
        return nil;
    }
}
-(void)refreshWebView{
    [self loadWKwebViewData];
}

#pragma mark - setter && getter

- (WKWebView *)webView {
    if (!_webView) {
        
        WKUserContentController * wkUController = [[WKUserContentController alloc] init];
        WeakWebViewScriptMessageDelegate *weakScriptMessageDelegate = [[WeakWebViewScriptMessageDelegate alloc] initWithDelegate:self];
        //注册一个name为jsToOcNoPrams的js方法 设置处理接收JS方法的对象
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goToHome"];//H5返回按钮事件
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goBackToShopHome"];// 返回到商城首页
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"goPay"];// 商城确认支付按钮
        [wkUController addScriptMessageHandler:weakScriptMessageDelegate name:@"logout"];

        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.userContentController = wkUController;
        
        //    preferences.minimumFontSize = 40.0;
        config.preferences = preferences;
        NSMutableDictionary *dic = [NSMutableDictionary new];
        dic[@"tabbarHeight"] = MMNSStringFormat(@"%f",self.heightStatus);
        dic[@"token"] = [[NSUserDefaults standardUserDefaults] valueForKey:@"Token"];
        dic[@"device"] = [SFHFKeychainUtils GetIOSUUID];

        NSLog(@"window.iOSInfo:%@", dic);
        NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
        NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *js = [NSString stringWithFormat:@"window.iOSInfo = %@", jsonStr];
        WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
        [config.userContentController addUserScript:script];
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
