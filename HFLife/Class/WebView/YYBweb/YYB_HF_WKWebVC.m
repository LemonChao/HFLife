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
#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MapViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UMSPPPayUnifyPayPlugin.h"
#import "YYB_HF_setDealPassWordVC.h"

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
    [self.customNavBar wr_setBottomLineHidden:YES];
    [self initWKWebView];
    
    maskView = [UIView new];
    [self.view addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
    [self loadWKwebViewData];
    //设置导航背景透明
    [self.customNavBar wr_setContentViewColor:[UIColor clearColor]];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self addUserScript];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initWKWebView{
    
    //创建并配置WKWebView的相关参数
    //1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
    //2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
    //3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
    //拨打电话
    [userContentController addScriptMessageHandler:self name:@"call"];
    //返回首页
    [userContentController addScriptMessageHandler:self name:@"goToHome"];
    [userContentController addScriptMessageHandler:self name:@"goBack"];
    //选择城市
    [userContentController addScriptMessageHandler:self name:@"choiceCity"];
    //调起支付 调起银联支付
    [userContentController addScriptMessageHandler:self name:@"goPay"];
    
    //调起h5界面
    [userContentController addScriptMessageHandler:self name:@"goToH5View"];
    //获取h5传值
    [userContentController addScriptMessageHandler:self name:@"sendTypeValue"];
    //调起设置支付密码
    [userContentController addScriptMessageHandler:self name:@"goSetPayPassword"];
    //去登陆
    [userContentController addScriptMessageHandler:self name:@"loginApp"];
    //更新余额
    [userContentController addScriptMessageHandler:self name:@"upDataUser"];
    //显示地图
    [userContentController addScriptMessageHandler:self name:@"actionMap"];
    configuration.userContentController = userContentController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - HomeIndicatorHeight) configuration:configuration];
    [self addUserScript];//配置WindowsInFo
    
    
    self.webView.UIDelegate = self;
    self.webView.navigationDelegate = self;
    //    self.webView.scalesPageToFit = YES;
    self.webView.multipleTouchEnabled = YES;
    self.webView.userInteractionEnabled = YES;
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scrollView.bounces = NO;
    self.webView.contentMode = UIViewContentModeScaleAspectFit;
    self.webView.scrollView.delegate = self;
    self.webView.allowsBackForwardNavigationGestures = YES;//允许侧滑返回

    [self.view addSubview:self.webView];
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        // Fallback on earlier versions
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
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
- (void)loadWKwebViewData {
    [[WBPCreate sharedInstance]showWBProgress];
    
//    //使用stringByAddingPercentEncodingWithAllowedCharacters处理
//    NSString *headImgURL = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet  URLQueryAllowedCharacterSet]];
//    NSLog(@"%@",headImgURL);
    
    
    if (![NSString isNOTNull:self.urlString] && self.urlString.length > 0) {
        //对地址参数编码
        NSArray *arr = [self.urlString componentsSeparatedByString:@"?"];
        NSString *baseUrl = arr.firstObject;
        NSString *subUrlStr = [self.urlString stringByReplacingOccurrencesOfString:baseUrl withString:@""];
        
        NSCharacterSet *encode_set= [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *urlString_encode = [subUrlStr stringByAddingPercentEncodingWithAllowedCharacters:encode_set];
        urlString_encode = [NSString stringWithFormat:@"%@%@",baseUrl,urlString_encode];
        
//        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString_encode]];
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString_encode] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:30];
        [self.webView loadRequest:request];
    }else{
        //         通过路径创建本地URL地址
        NSString *pathStr = [[NSBundle mainBundle] pathForResource:self.fileName ofType:@"html" inDirectory:self.folderName];
        
        if (pathStr) {
            NSString * urlString2 = [[NSString stringWithFormat:@"?token=%@",[HeaderToken getAccessToken]]stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
            [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString2 relativeToURL:[NSURL fileURLWithPath:pathStr]]]];
        }else {
            [self loadFailed];
        }
    }
    
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if (self.isNavigationHidden&&self.isHidenLeft==NO) {
//        if(scrollView.contentOffset.y <= 0){
//            self.customNavBar.title = @"";
//            [self.customNavBar wr_setBackgroundAlpha:0];
//            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
//            return;
//        }
//        //移动的百分比
//        CGFloat ratioY = scrollView.contentOffset.y / (self.navBarHeight ); // y轴上移动的百分比
//        if(ratioY > 1) {
//            self.customNavBar.title = _webTitle;
//            [self.customNavBar wr_setBackgroundAlpha:1];
//            [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
//            return;
//        }
//        [self.customNavBar wr_setBackgroundAlpha:ratioY];
//    }
    
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
    [self.customNavBar setHidden:NO];
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
    
    [self loadSuccess];
    //去除长按后出现的文本选取框
    //    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    //WKWebview 禁止长按(超链接、图片、文本...)弹出效果
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
    [self.webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';"completionHandler:nil];
    //    [self loadSuccess];
    
    
    [webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable readyState, NSError * _Nullable error) {
//        NSLog(@"----document.title:%@---webView title:%@",readyState,webView.title);
//        BOOL complete = [readyState isEqualToString:@"complete"];
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
    NSLog(@"name:%@ body:%@",message.name,message.body);
    if ([message.name isEqualToString:@"call"]) {
        //        [self ShareWithInformation:message.body];
        [self CallParameter:message.body];
    } else if ([message.name isEqualToString:@"Camera"]) {
        [self camera];
    } else if ([message.name isEqualToString:@"actionMap"]){
        [self getAddressParameter:message.body];
    }
//    else if ([message.name isEqualToString:@"getNear"]){
//        [self getNearParameter:message.body];
//    }else if ([message.name isEqualToString:@"pageJump"]){
//        [self pageJumpParameter:message.body];
//    }else if ([message.name isEqualToString:@"goShopping"]){
//        [self goShoppingParameter:message.body];
//    }else if ([message.name isEqualToString:@"nativeToJump"]){
//        [self nativeToJumpParameter:message.body];
//    }else if ([message.name isEqualToString:@"rushBuy"]){
//    [self rushBuyParameter:message.body];
//    }else if ([message.name isEqualToString:@"orderHotel"]){
//    [self orderHotelParameter:message.body];
//}
    else if ([message.name isEqualToString:@"goToHome"]){
        [self goToHome:message.body];
    }else if ([message.name isEqualToString:@"submitOrder"]){
        [self submitOrderParameter:message.body];
    }else if ([message.name isEqualToString:@"Share"]){
//        InviteVC *vc = [[InviteVC alloc]init];
//        [vc addShareViewForH5];
    }else if ([message.name isEqualToString:@"choiceCity"]){
        if (self.choiceCity) {
            self.choiceCity(message.body);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if ([message.name isEqualToString:@"goPay"]){
        [self goToPayParameter:message.body];
    }else if ([message.name isEqualToString:@"goBack"]){
        [self goToHome:message.body];
    }else if ([message.name isEqualToString:@"goSetPayPassword"]){
        [self jumPasswordVC];
    }else if ([message.name isEqualToString:@"goToH5View"]){//跳转h5
        [self gotoH5View:message.body];
    }else if ([message.name isEqualToString:@"sendTypeValue"]){//获取h5子界面传值并返回
        if (self.backH5) {
            self.backH5(message.body);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else if ([message.name isEqualToString:@"loginApp"]){//跳转登录
        [self.navigationController popToRootViewControllerAnimated:NO];
        [LoginVC login];
    }else if ([message.name isEqualToString:@"upDataUser"]) {
        //更新余额
    }
    
    //goToHome
}

#pragma mark - OC调用JS方法
- (void) evaluateJavaScript:(NSString *) JSMethod resultBlock:(void (^)(id _Nullable result))sucess{
    //OC反馈给JS分享结果
//    NSString *JSResult = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
    
    //OC调用JS
    if (JSMethod && [JSMethod isKindOfClass:[NSString class]]) {
        if (JSMethod && [JSMethod isKindOfClass:[NSString class]]) {
            [self.webView evaluateJavaScript:JSMethod completionHandler:^(id _Nullable result, NSError * _Nullable error) {
                NSLog(@"%@", error);
                sucess(result);
            }];
        }
    }
    
    
}

#pragma mark - JS调用OC方法
#pragma mark - 拨打电话
-(void)CallParameter:(NSDictionary *)dict{
    NSString *telStr = @"";
    if ([dict isKindOfClass:[NSDictionary class]]) {
        telStr = [[NSString alloc] initWithFormat:@"tel:%@",[NSString judgeNullReturnString:dict[@"tel"]]];
    }else if([dict isKindOfClass:[NSString class]]){
        telStr = [[NSString alloc] initWithFormat:@"tel:%@",[NSString judgeNullReturnString:dict]];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telStr]];
}
#pragma mark - 网络数据是否请求成功
-(void)getStatusParameter:(NSDictionary *)dict{
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSString *isSuccess = MMNSStringFormat(@"%@",dict[@"status"]);
        if (isSuccess && [isSuccess isEqualToString:@"1"]) {
            NSLog(@"数据请求成功");
            [self loadSuccess];
        }else{
            NSLog(@"数据请求失败");
            [self loadFailed];
        }
    }
}
#pragma mark -获取地理位置
-(void)getAddressParameter:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        
    }else if (dict && [dict isKindOfClass:[NSString class]]){
        dict = [dict mj_JSONObject];
    }
    
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        MapViewController *map = [[MapViewController alloc]init];
        CLLocationCoordinate2D gaocoor;
        gaocoor.latitude = [MMNSStringFormat(@"%@",dict[@"lat"]) floatValue];
        gaocoor.longitude = [MMNSStringFormat(@"%@",dict[@"lng"]) floatValue];
        CLLocationCoordinate2D coor = [JZLocationConverter bd09ToGcj02:gaocoor];
        map.latitude = coor.latitude;
        map.longitude = coor.longitude;
        map.isMark = YES;
        
        map.address = MMNSStringFormat(@"%@",dict[@"address"]);
        map.address_info = MMNSStringFormat(@"%@",dict[@"address_info"]);
        map.store_name = MMNSStringFormat(@"%@",dict[@"store_name"]);
        

        [self.navigationController pushViewController:map animated:YES];
    }
   
}
#pragma mark -参数跳转
-(void)getNearParameter:(NSDictionary *)dict{
    
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
        //    NSString *city = [MMNSUserDefaults objectForKey:selectedCity];
        //    NSString *coupon_id = MMNSStringFormat(@"%@",dict[@"coupon_id"]);
        wkWebView.isNavigationHidden = YES;
        NSString *shop_id = MMNSStringFormat(@"%@",dict[@"shop_id"]);
        
        wkWebView.jointParameter = MMNSStringFormat(@"?shop_id=%@",shop_id);
        //    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"url"]];
        [self.navigationController pushViewController:wkWebView animated:YES];
    }
}
#pragma mark -URL跳转
-(void)pageJumpParameter:(NSDictionary *)dict{
    NSLog(@"dict = %@",dict);
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
        wkWebView.urlString = [NSString judgeNullReturnString:dict[@"href"]];
        wkWebView.isNavigationHidden = [MMNSStringFormat(@"%@",dict[@"bar"]) isEqualToString:@"1"] ? YES : NO;
        wkWebView.webTitle = [NSString judgeNullReturnString:dict[@"title"]];
        [self.navigationController pushViewController:wkWebView animated:YES];
    }
}
#pragma mark -去购买
-(void)goShoppingParameter:(NSDictionary *)dict{
}
#pragma mark -跳转h5子界面
-(void)gotoH5View:(NSString *)url {
    
    if (url && [url isKindOfClass:[NSString class]] && url.length > 0) {
        //
        YYB_HF_WKWebVC *vc = [[YYB_HF_WKWebVC alloc]init];
        vc.urlString = url;
        vc.backH5 = ^(NSDictionary * _Nonnull dataDic) {
            //执行js 给h5传值
            NSString *JSResult = [NSString stringWithFormat:@"sendValue('%@')",dataDic];
            [self evaluateJavaScript:JSResult resultBlock:^(id  _Nullable result) {
                
            }];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        [WXZTipView showCenterWithText:@"链接错误"];
    }
}
#pragma mark -跳转原生界面
-(void)nativeToJumpParameter:(NSDictionary *)dict{
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
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
}
#pragma mark - h5跳转 搜索界面 goToSearch
-(void)jumSearchVC {
    [self.navigationController pushViewController:[NSClassFromString(@"YYB_HF_NearSearchVC") new] animated:YES];
}
#pragma mark - h5跳转 设置密码界面 goSetPayPassword
- (void)jumPasswordVC {
    YYB_HF_setDealPassWordVC *vc =[NSClassFromString(@"YYB_HF_setDealPassWordVC") new];
    vc.isLocal = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 返回首页--
-(void)goToHome:(NSString *)body{
    
    if ([body isKindOfClass:[NSNull class]]) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if ([body integerValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            if ([self.webView canGoBack]) {
                [self.webView goBack];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }
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
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        WKWebViewController *wkWebView = [[WKWebViewController alloc]init];
        wkWebView.urlString = [NSString judgeNullReturnString:dict[@"href"]];
        wkWebView.isNavigationHidden = [MMNSStringFormat(@"%@",dict[@"bar"]) isEqualToString:@"1"]?YES:NO;
        wkWebView.webTitle = [NSString judgeNullReturnString:dict[@"title"]];
        [self.navigationController pushViewController:wkWebView animated:YES];
    }
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
    
    if ([dict isKindOfClass:[NSDictionary class]]) {
        
    }else {
        [WXZTipView showCenterWithText:@"数据错误"];
        return;
    }
    
    NSString *type = [NSString stringWithFormat:@"%@", dict[@"payType"] ? dict[@"payType"] : @""];
    NSString *payDataJsonStr;
    if ([dict[@"pullPayInfo"] isKindOfClass:[NSDictionary class]]) {
        payDataJsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:dict[@"pullPayInfo"] options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }else{
        [WXZTipView showCenterWithText:@"数据错误"];
        return;
    }
    if ([type isEqualToString:@"0"]) {
        // 余额支付
    }
    else if ([type isEqualToString:@"1"]) {
        //支付宝
        //开启轮询订单
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkOrderStatus:) name:UIApplicationWillEnterForegroundNotification object:nil];
        [circleCheckOrderManger sharedInstence].orderSearchInfoDic = [dict copy];
        [circleCheckOrderManger sharedInstence].searchOrderBlock = ^(NSDictionary * _Nonnull orderInfo) {
            //查询支付结果
            NSString *JSResult;
            if (orderInfo && ([orderInfo[@"status"] intValue] == 1)) {
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"1"];
            }else {
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"0"];
            }
            [self evaluateJavaScript:JSResult resultBlock:^(id  _Nullable result) {
                
            }];
        };
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_ALIPAY payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            if ([resultCode isEqualToString:@"1003"]) {
                NSLog(@"%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
            }
        }];
        
    }
    else if ([type isEqualToString:@"2"]){
        
        //微信
        //开启轮询订单
        [UMSPPPayUnifyPayPlugin registerApp:dict[@"query"][@"appid"]];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxPayCallback:) name:@"wxPay" object:nil];
        [UMSPPPayUnifyPayPlugin payWithPayChannel:CHANNEL_WEIXIN payData:payDataJsonStr callbackBlock:^(NSString *resultCode, NSString *resultInfo) {
            NSLog(@"%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);

            NSString *JSResult;
            if ([resultCode isEqualToString:@"1003"]) {
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"0"];
            }else if ([resultCode isEqualToString:@"1000"]){
                [WXZTipView showCenterWithText:@"付款已取消"];
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"0"];
            }else if ([resultCode isEqualToString:@"0000"]){
                [WXZTipView showCenterWithText:@"支付成功"];
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"1"];
            }
            [self evaluateJavaScript:JSResult resultBlock:^(id  _Nullable result) {
                
            }];
        }];
    }
    else if ([type isEqualToString:@"3"]){
        
        [UMSPPPayUnifyPayPlugin cloudPayWithURLSchemes:@"unifyPayHanPay" payData:payDataJsonStr viewController:self callbackBlock:^(NSString *resultCode, NSString *resultInfo) {//1000 取消
            NSString *JSResult = [NSString stringWithFormat:@"payState('%@')",@"0"];
            if ([resultCode isEqualToString:@"1003"]) {
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"0"];
            }else if ([resultCode isEqualToString:@"1000"]){
                [WXZTipView showCenterWithText:@"付款已取消"];
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"0"];
            }else if ([resultCode isEqualToString:@"0000"]){
                [WXZTipView showCenterWithText:@"支付成功"];
                JSResult = [NSString stringWithFormat:@"payState('%@')",@"1"];
            }
            [self evaluateJavaScript:JSResult resultBlock:^(id  _Nullable result) {
                
            }];
            NSLog(@"=====%@",[NSString stringWithFormat:@"resultCode = %@\nresultInfo = %@", resultCode, resultInfo]);
            
        }];
    }
}

//查询订单
- (void)checkOrderStatus:(NSNotification *)not {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
    [[circleCheckOrderManger sharedInstence] checkOrderStatus];
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
        [self.customNavBar setHidden:NO];
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
