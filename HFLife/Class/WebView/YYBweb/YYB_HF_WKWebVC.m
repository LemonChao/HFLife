//
//  YYB_HF_WKWebVC.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

//
//  WKWebViewController.m
//  WKWebViewMessageHandlerDemo
//
//  Created by reborn on 16/9/12.
//  Copyright © 2016年 reborn. All rights reserved.
//

#import "YYB_HF_WKWebVC.h"
#import <WebKit/WebKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MapViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UMSPPPayUnifyPayPlugin.h"
@interface YYB_HF_WKWebVC()<WKUIDelegate,WKScriptMessageHandler,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate>
{
    UIImagePickerController *imagePickerController;
    UIView *maskView;
    
}
@property(nonatomic, strong)WKWebView *webView;
@end

@implementation YYB_HF_WKWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self wr_setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    
    
    //    [self removeWebCache];
    
    [self initWKWebView];
    
    maskView = [UIView new];
    [self.view addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    if (self.isNavigationHidden) {
        [self.navigationController.navigationBar setHidden:YES];
        [self.customNavBar setHidden:YES];
        UIView *topView = [UIView new];
        topView.backgroundColor = [UIColor whiteColor];;//
        [self.view addSubview:topView];
        [topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self.view);
            make.height.mas_equalTo(self.heightStatus);
        }];
    }else{
        [self setupNavBar];
        
    }
    [self loadWKwebViewData];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.fd_viewControllerBasedNavigationBarAppearanceEnabled = NO;
    self.navigationController.navigationBar.hidden = YES;
    self.fd_interactivePopDisabled = YES;
    //    //隐藏返回按钮
    //    self.navigationItem.hidesBackButton = YES;
    //    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    //    }
    //    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.delegate =self;
    //    }
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.fd_viewControllerBasedNavigationBarAppearanceEnabled = YES;
    self.fd_interactivePopDisabled = NO;
    self.navigationController.navigationBar.hidden = NO;
    //    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    //    }
    //    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
    //        self.navigationController.interactivePopGestureRecognizer.delegate =nil;
    //
    //    }
    
}
- (void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    if (self.isHidenLeft) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@""]];
    }else{
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    }
    
    //    [self.customNavBar wr_setRightButtonWithImage:MMGetImage(@"tianjia")];
    self.customNavBar.barBackgroundImage = [self createImageWithColor:[UIColor whiteColor]];
    [self.customNavBar setOnClickLeftButton:^{
        if (!weakSelf.isHidenLeft) {
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    [self.customNavBar wr_setBackgroundAlpha:self.isNavigationHidden?0:1];
    [self.customNavBar wr_setBottomLineHidden:YES];
    //    self.customNavBar.title = @"优惠券详情";
    self.customNavBar.title = [NSString isNOTNull:self.webTitle] ? @"":self.webTitle;
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    if (    !self.isNavigationHidden) {
        self.customNavBar.backgroundColor = [UIColor whiteColor];
    }
    
}
- (void)initWKWebView{
    
    //创建并配置WKWebView的相关参数
    //1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
    //2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
    //3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //分享
    [userContentController addScriptMessageHandler:self name:@"Share"];
    [userContentController addScriptMessageHandler:self name:@"Camera"];
    //拨打电话
    [userContentController addScriptMessageHandler:self name:@"Call"];
    //获取网页数据是否请求成功
    [userContentController addScriptMessageHandler:self name:@"getStatus"];
    //获取店铺的位置
    [userContentController addScriptMessageHandler:self name:@"getAddress"];
    //吃喝玩乐
    [userContentController addScriptMessageHandler:self name:@"getNear"];
    //链接跳转
    [userContentController addScriptMessageHandler:self name:@"pageJump"];
    //立即抢购
    [userContentController addScriptMessageHandler:self name:@"goShopping"];
    //原生跳转
    [userContentController addScriptMessageHandler:self name:@"nativeToJump"];
    //返回首页
    [userContentController addScriptMessageHandler:self name:@"goToHome"];
    //抢购
    [userContentController addScriptMessageHandler:self name:@"rushBuy"];
    //抢购
    [userContentController addScriptMessageHandler:self name:@"orderHotel"];
    //提交订单
    [userContentController addScriptMessageHandler:self name:@"submitOrder"];
    //调起支付
    [userContentController addScriptMessageHandler:self name:@"goToPay"];
    //调起银联支付
    [userContentController addScriptMessageHandler:self name:@"goToApp"];
    //选择城市
    [userContentController addScriptMessageHandler:self name:@"choiceCity"];
    
    configuration.userContentController = userContentController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"tabbarHeight"] = MMNSStringFormat(@"%f",self.navBarHeight);
    dic[@"token"] = [NSString judgeNullReturnString:[[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN]];
    dic[@"device"] = [SFHFKeychainUtils GetIOSUUID];
    //    dic[@"avatar"] = [UserInfoTool avatar];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
    
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *js = [NSString stringWithFormat:@"window.iOSInfo = %@", jsonStr];
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
    [configuration.userContentController addUserScript:script];
    
    CGFloat top = self.isTop?0:-self.heightStatus;
    CGFloat Hei = self.isTop?SCREEN_HEIGHT-self.heightStatus:SCREEN_HEIGHT;
    if (self.isHidenLeft) {
        top = 0;
        if (self.heightStatus > 20) {
            Hei = SCREEN_HEIGHT - self.heightStatus;
        }else{
            Hei = SCREEN_HEIGHT;
        }
        
    }else{
        if (self.heightStatus > 20) {
            top = -self.heightStatus;
            Hei = SCREEN_HEIGHT;
        }else{
            if (kiPhone6Plus == NO) {
                top = 0;
            }
            Hei = SCREEN_HEIGHT + self.heightStatus;
        }
    }
    
    if (self.heightStatus <= 20 && top == 0) {
        Hei = SCREEN_HEIGHT;
    }else{
        
    }
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,top, SCREEN_WIDTH, Hei) configuration:configuration];
    
    
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    //    self.webView.scalesPageToFit = YES;
    self.webView.multipleTouchEnabled = YES;
    self.webView.userInteractionEnabled = YES;
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
    self.webView.scrollView.delegate = self;
    [self.view addSubview:self.webView];
    if (@available(iOS 11.0, *)) {
        if (self.isTop) {//不是从状态栏开始布局
        }else {
            self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    
    
    //    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_equalTo(self.view);
    //    }];
}
- (void)loadWKwebViewData{
    [[WBPCreate sharedInstance]showWBProgress];
    
//    NSString *str = @"http://xxxxxx.com/uploads/image/20180813/20180813150735_\U5de5\U7a0b\U5e08\U5934\U50cf.png";
//    //使用stringByAddingPercentEncodingWithAllowedCharacters处理
//    NSString *headImgURL = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
//    NSLog(@"%@",headImgURL);
    
    
    if (![NSString isNOTNull:self.urlString]) {
//        NSURL *url = [NSURL URLWithString:[[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
//                NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        
//        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.urlString] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60];
        [self.webView loadRequest:request];
    }else{
        [self loadFailed];
        //        //loadFileURL方法通常用于加载服务器的HTML页面或者JS，而loadHTMLString通常用于加载本地HTML或者JS
        //        NSString *htmlPath = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"html" inDirectory:@"美食"];
        //        NSURL *fileUrl;
        //        if (![NSString isNOTNull:self.jointParameter]) {
        //            fileUrl = [NSURL URLWithString:[self.jointParameter stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]
        //                             relativeToURL:[NSURL fileURLWithPath:htmlPath]];
        //        }else{
        //            fileUrl = [NSURL fileURLWithPath:htmlPath];
        //        }
        //        [self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
    }
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.isNavigationHidden&&self.isHidenLeft==NO) {
        if(scrollView.contentOffset.y <= 0){
            self.customNavBar.title = @"";
            [self.customNavBar wr_setBackgroundAlpha:0];
            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
            return;
        }
        //移动的百分比
        CGFloat ratioY = scrollView.contentOffset.y / (self.navBarHeight ); // y轴上移动的百分比
        if(ratioY > 1) {
            self.customNavBar.title = _webTitle;
            [self.customNavBar wr_setBackgroundAlpha:1];
            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
            return;
        }
        [self.customNavBar wr_setBackgroundAlpha:ratioY];
    }
    
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer{
    return NO;
}
#pragma mark - WKWebView代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    //    Decides whether to allow or cancel a navigation after its response is known.
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    NSLog(@"url:====== %@",webView.URL);
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
    //    //OC反馈给JS导航栏高度
    //    NSString *JSResult = [NSString stringWithFormat:@"getTabbarHeight('%@')",MMNSStringFormat(@"%f",self.navBarHeight)];
    //    //OC调用JS
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            // OC 调用JS方法 method 的js代码可往下看
    //        [self.webView evaluateJavaScript:JSResult completionHandler:^(id _Nullable result, NSError * _Nullable error) {
    //             NSLog(@"result:%@,error:%@",result,error);
    //        }];
    //    });
    [self loadSuccess];
    //去除长按后出现的文本选取框
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    //WKWebview 禁止长按(超链接、图片、文本...)弹出效果
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
    //    [self loadSuccess];
    if (self.isNavigationHidden) {
        if([NSString isNOTNull:self.webTitle]){
            _webTitle =  webView.title;
        }
    }else{
        if ([NSString isNOTNull:self.webTitle]) {
            self.customNavBar.title = webView.title;
        }else{
            self.customNavBar.title = _webTitle;
        }
        
    }
    
    
    [webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable readyState, NSError * _Nullable error) {
        //        NSLog(@"----document.title:%@---webView title:%@",readyState,webView.title);
        //         BOOL complete = [readyState isEqualToString:@"complete"];
        //        if (complete) {
        //            [self loadSuccess];
        //        }else{
        //            [self loadFailed];
        //        }
    }];
    
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
    
    //    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    //    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //        completionHandler();
    //    }]];
    //
    //    [self presentViewController:alert animated:YES completion:nil];
    completionHandler();
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
        //        [self ShareWithInformation:message.body];
        [self CallParameter:message.body];
    } else if ([message.name isEqualToString:@"Camera"]) {
        [self camera];
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
    }else if ([message.name isEqualToString:@"goToHome"]){
        [self goToHome];
    }else if ([message.name isEqualToString:@"rushBuy"]){
        [self rushBuyParameter:message.body];
    }else if ([message.name isEqualToString:@"orderHotel"]){
        [self orderHotelParameter:message.body];
    }else if ([message.name isEqualToString:@"submitOrder"]){
        [self submitOrderParameter:message.body];
    }else if ([message.name isEqualToString:@"goToPay"]){
        [self goToPayParameter:message.body];
    }else if ([message.name isEqualToString:@"goToApp"]){
        [self goToHome];
    }else if ([message.name isEqualToString:@"Share"]){
        
    }else if ([message.name isEqualToString:@"choiceCity"]){
        if (self.choiceCity) {
            self.choiceCity(message.body);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    //goToHome
}

#pragma mark - JS调用OC方法
#pragma mark - 拨打电话
-(void)CallParameter:(NSDictionary *)dict{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",[NSString judgeNullReturnString:dict[@"tel"]]];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}
#pragma mark - 网络数据是否请求成功
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
    MapViewController *map = [[MapViewController alloc]init];
    CLLocationCoordinate2D gaocoor;
    gaocoor.latitude = [MMNSStringFormat(@"%@",dict[@"latitude"]) floatValue];
    gaocoor.longitude = [MMNSStringFormat(@"%@",dict[@"longitude"]) floatValue];
    CLLocationCoordinate2D coor = [JZLocationConverter bd09ToGcj02:gaocoor];
    map.latitude = coor.latitude;
    map.longitude = coor.longitude;
    map.isMark = YES;
    [self.navigationController pushViewController:map animated:YES];
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
#pragma mark - 返回首页--
-(void)goToHome{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -抢购--
-(void)rushBuyParameter:(NSDictionary *)dict{
    NSLog(@"dict = %@",dict);
    if ([NSString isNOTNull:[HeaderToken getAccessToken]]) {
        //        [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
        //        return;
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
        //        [[NSNotificationCenter defaultCenter] postNotificationName:LOG_BACK_IN object:nil userInfo:nil];
        //        return;
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
    //    NSString *orderId = dict[@"pay_sn"];
    NSString *type = [NSString stringWithFormat:@"%@", dict[@"type"] ? dict[@"type"] : @""];
    if ([type isEqualToString:@"3"]) {
        NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict[@"query"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayHanPay" payData:payDataJsonStr viewController:self callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            NSLog(@"=====%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
        }];
    }else{
        NSString *payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict[@"query"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
        
        //开启轮询订单
        //        [[circleCheckOrderManger sharedInstence] searchOrderWithOrderId:orderId isHotel:YES idType:NO isNowPay:YES];
        
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            if ([resultCode isEqualToString:@"1003"]) {
                NSLog(@"%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
            }
        }];
    }
    
}
- (void)ShareWithInformation:(NSDictionary *)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSString *title = [dic objectForKey:@"title"];
    NSString *content = [dic objectForKey:@"content"];
    NSString *url = [dic objectForKey:@"url"];
    
    //在这里写分享操作的代码
    NSLog(@"要分享了哦😯");
    
    //OC反馈给JS分享结果
    NSString *JSResult = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
    
    //OC调用JS
    [self.webView evaluateJavaScript:JSResult completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        NSLog(@"%@", error);
    }];
}

- (void)camera{
    NSLog(@"调用");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (UIImage*)createImageWithColor: (UIColor*) color{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}
#pragma mark ==加载失败
-(void)loadFailed{
    [[WBPCreate sharedInstance]hideAnimated];
    maskView.hidden = YES;
   
    __block LYEmptyView *empView = [LYEmptyView emptyActionViewWithImage:image(@"ic_empty_data") titleStr:nil detailStr:nil btnTitleStr:@"重新加载" btnClickBlock:^{
        [self loadWKwebViewData];
        [empView removeFromSuperview];
        [self.customNavBar setHidden:self.isNavigationHidden];
    }];
    [self.customNavBar setHidden:NO];
    [self.view addSubview:empView];
    
}
#pragma mark ==加载成功
-(void)loadSuccess{
    [[WBPCreate sharedInstance]hideAnimated];
    maskView.hidden = YES;
    //    [self deleteEmptyDataView];
}
-(NSArray *)stringToJSON:(NSString *)jsonStr {
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
-(id)toArrayOrNSDictionary:(NSData *)jsonData{
    
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
-(void)setTitleColor:(UIColor *)titleColor{
    
}
@end
