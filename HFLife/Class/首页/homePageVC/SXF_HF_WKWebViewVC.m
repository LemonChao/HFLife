
//
//  SXF_HF_WKWebViewVC.m
//  HFLife
//
//  Created by mac on 2019/5/31.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_WKWebViewVC.h"

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MapViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UMSPPPayUnifyPayPlugin.h"



#import "ShareProductInfoView.h"
#import "YYB_HF_submitDealPassWordVC.h"


@interface SXF_HF_WKWebViewVC ()<WKUIDelegate,WKScriptMessageHandler,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate>
{
    UIImagePickerController *imagePickerController;
    UIView *maskView;
    
}
@property(nonatomic, strong)WKWebView *webView;
@end

@implementation SXF_HF_WKWebViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.customNavBar wr_setBottomLineHidden:YES];
    
    //    [self removeWebCache];
    
    [self initWKWebView];
    
    maskView = [UIView new];
    [self.view addSubview:maskView];
    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    
    
    [self loadWKwebViewData];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initWKWebView{
    
    //创建并配置WKWebView的相关参数
    //1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
    //2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
    //3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    //分享
    [userContentController addScriptMessageHandler:self name:@"goToShare"];
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
    //原生跳转
    [userContentController addScriptMessageHandler:self name:@"goToSearch"];
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
    //调起QQ
    [userContentController addScriptMessageHandler:self name:@"goToQQ"];
    
    
    [userContentController addScriptMessageHandler:self name:@"goSetPayPassword"];
    
    
    
    configuration.userContentController = userContentController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"tabbarHeight"] = MMNSStringFormat(@"%f",self.heightStatus);
    dic[@"token"] = [[NSUserDefaults standardUserDefaults] valueForKey:USER_TOKEN];
    dic[@"device"] = [SFHFKeychainUtils GetIOSUUID];
    //    dic[@"avatar"] = [UserInfoTool avatar];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
    
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *js = [NSString stringWithFormat:@"window.iOSInfo = %@", jsonStr];
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
    [configuration.userContentController addUserScript:script];
    
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT - HomeIndicatorHeight) configuration:configuration];
    
    
    
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
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    

}
-(void)loadWKwebViewData{
    [[WBPCreate sharedInstance]showWBProgress];
    if (![NSString isNOTNull:self.urlString]) {
//        NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] ;
        
       NSURL *url = [NSURL URLWithString:self.urlString];
        //        NSURL *url = [NSURL URLWithString:[self.urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
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
    self.customNavBar.hidden = YES;//加载成功隐藏 使用web导航
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
    if([NSString isNOTNull:self.webTitle]){
        _webTitle =  webView.title;
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
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    completionHandler(YES);
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
        [self goToHome:message.body];
    }else if ([message.name isEqualToString:@"rushBuy"]){
        [self rushBuyParameter:message.body];
    }else if ([message.name isEqualToString:@"orderHotel"]){
        [self orderHotelParameter:message.body];
    }else if ([message.name isEqualToString:@"submitOrder"]){
        [self submitOrderParameter:message.body];
    }else if ([message.name isEqualToString:@"goToPay"]){
        [self goToPayParameter:message.body];
    }else if ([message.name isEqualToString:@"goToApp"]){
        [self goToHome:message.body];
    }
    else if ([message.name isEqualToString:@"goToShare"]){
        //分享
        [self goToShare:message.body];
        
    }else if ([message.name isEqualToString:@"goSetPayPassword"]){
        //去设置支付密码
        YYB_HF_submitDealPassWordVC *vc = [YYB_HF_submitDealPassWordVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([message.name isEqualToString:@"goToSearch"]){
        [self jumSearchVC];
    }else if ([message.name isEqualToString:@"goToQQ"]){
        [self jumQQVC:message.body];
    }
    //goToHome
}

#pragma mark - JS调用OC方法


#pragma mark - 分享
- (void) goToShare:(id)message{
    NSLog(@"%@", message);
    
    SSDKPlatformType type;
    NSInteger index = [message integerValue];
    switch (index) {
        case 1:
            //微信
            type = SSDKPlatformSubTypeWechatSession;
            break;
        case 2:
            //微信朋友圈
            type = SSDKPlatformSubTypeWechatTimeline;
            break;
        case 3:
            //qq好友
            type = SSDKPlatformSubTypeQQFriend;
            break;
        case 4:
            //QQ空间
            type = SSDKPlatformSubTypeQZone;
            break;
        default:
            type = SSDKPlatformTypeUnknown;
            break;
    }
    
    
    NSString *sharedUrlStr = [NSString stringWithFormat:shareUrl, ([userInfoModel sharedUser].invite_code ? [userInfoModel sharedUser].invite_code : @"")];
    
    [ShareProductInfoView shareBtnClick:type ShareImage:MY_IMAHE(@"shareLogo") title:@"一个可以购物又可赚钱的APP" url:sharedUrlStr context:@"下载汉富生活APP一起做老板" shareBtnClickBlock:^(BOOL isSucceed, NSString *msg) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [WXZTipView showCenterWithText:msg];
        }];
    }];
}


#pragma mark - 拨打电话
-(void)CallParameter:(NSString *)phone{
    NSString *str = [[NSString alloc] initWithFormat:@"tel:%@",[NSString judgeNullReturnString:phone]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
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
    SXF_HF_WKWebViewVC *wkWebView = [[SXF_HF_WKWebViewVC alloc]init];
    wkWebView.urlString = [NSString judgeNullReturnString:dict[@"href"]];
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

#pragma mark - h5跳转 搜索界面 goToSearch
-(void)jumSearchVC {
    
    [self.navigationController pushViewController:[NSClassFromString(@"YYB_HF_NearSearchVC") new] animated:YES];
    
}
#pragma mark - h5跳转 QQ界面 与陌生人聊天 goToQQ
- (void)jumQQVC:(NSString *)qqStr {
    //qqNumber就是你要打开的QQ号码， 也就是你的客服号码。
    NSString  *qqNumber = qqStr;
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"mqq://"]]) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
        NSURL * url=[NSURL URLWithString:[NSString stringWithFormat:@"mqq://im/chat?chat_type=wpa&uin=%@&version=1&src_type=web",qqNumber]];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [webView loadRequest:request];
        [self.view addSubview:webView];
    }else{
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"nil" message:@"对不起，您还没安装QQ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            return ;
        }];
        
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
    
#pragma mark - 返回首页--
-(void)goToHome:(id)type{
    if ([type integerValue] == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if ([self.webView canGoBack]) {
            [self.webView goBack];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
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
    //    [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
    //        NSLog(@"123456");
    //        [self loadWKwebViewData];
    //    }];
}
#pragma mark ==加载成功
-(void)loadSuccess{
    [[WBPCreate sharedInstance]hideAnimated];
    maskView.hidden = YES;
    //    [self deleteEmptyDataView];
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
-(void)setTitleColor:(UIColor *)titleColor{
    
}
@end
