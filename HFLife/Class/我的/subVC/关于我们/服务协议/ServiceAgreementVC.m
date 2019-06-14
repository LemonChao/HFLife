//
//  ServiceAgreementVC.m
//  HanPay
//
//  Created by mac on 2019/3/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ServiceAgreementVC.h"
#import <WebKit/WebKit.h>
@interface ServiceAgreementVC ()<WKUIDelegate,WKScriptMessageHandler,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,WKNavigationDelegate,UIGestureRecognizerDelegate>
{
    UIView *maskView;
}
@property(nonatomic, strong)WKWebView *webView;



@property (nonatomic, strong)NSString *htmlStr;


@end

@implementation ServiceAgreementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.customNavBar.title = self.title;
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    [self.view addSubview:self.webView];
    
    
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    tv.backgroundColor = [UIColor orangeColor];
    
    
    NSString *subUrl;
    if (self.row == 0) {
        subUrl = SXF_LOC_URL_STR(VersionContent);//版本说明
    }else{
        subUrl = SXF_LOC_URL_STR(ServiceAgreement);
    }
    
    
    //加载 html字符串
    [networkingManagerTool requestToServerWithType:POST withSubUrl:ServiceAgreement withParameters:@{} withResultBlock:^(BOOL result, id value) {
        if (result) {
            if (value) {
                if (self.row == 0) {
                    self.htmlStr = value[@"data"][@"content"];
                }else{
                    self.htmlStr = value[@"data"][@"app_service_agreement"];
                }
                
                
                
//                NSString *newStr = [NSString stringWithFormat:@""]
                
                
                
                [self.webView loadHTMLString:self.htmlStr baseURL:nil];
            }
        }
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
//    [self removeWebCache];
//    [self initWKWebView];
//    maskView = [UIView new];
//    [self.view addSubview:maskView];
//    [maskView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.mas_equalTo(self.view);
//    }];
//
//    [self loadWKwebViewData];
}

- (void)initWKWebView{
    
        //创建并配置WKWebView的相关参数
        //1.WKWebViewConfiguration:是WKWebView初始化时的配置类，里面存放着初始化WK的一系列属性；
        //2.WKUserContentController:为JS提供了一个发送消息的通道并且可以向页面注入JS的类，WKUserContentController对象可以添加多个scriptMessageHandler；
        //3.addScriptMessageHandler:name:有两个参数，第一个参数是userContentController的代理对象，第二个参数是JS里发送postMessage的对象。添加一个脚本消息的处理器,同时需要在JS中添加，window.webkit.messageHandlers.<name>.postMessage(<messageBody>)才能起作用。
    
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    
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
        //调起支付
    [userContentController addScriptMessageHandler:self name:@"goToApp"];
        //返回首页
    [userContentController addScriptMessageHandler:self name:@"goHome"];
    configuration.userContentController = userContentController;
    
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 9.0;
        //    preferences.minimumFontSize = 40.0;
    configuration.preferences = preferences;
  
    
    NSMutableDictionary *dic = [NSMutableDictionary new];
    dic[@"tabbarHeight"] = MMNSStringFormat(@"%f",self.navBarHeight);
        //    dic[@"token"] = [UserInfoTool token];
        //    dic[@"avatar"] = [UserInfoTool avatar];
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:(NSJSONWritingPrettyPrinted) error:nil];
    
    NSString *jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSString *js = [NSString stringWithFormat:@"window.iOSInfo = %@", jsonStr];
    
    WKUserScript *script = [[WKUserScript alloc] initWithSource:js injectionTime:(WKUserScriptInjectionTimeAtDocumentStart) forMainFrameOnly:YES];
    [configuration.userContentController addUserScript:script];
    
    self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0,self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT-self.navBarHeight) configuration:configuration];
    
    
    
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
    
}
-(void)loadWKwebViewData{
    
    if (![NSString isNOTNull:self.htmlPath]) {
        [[WBPCreate sharedInstance]showWBProgress];
        NSURL *fileUrl = [NSURL fileURLWithPath:self.htmlPath];
        [self.webView loadRequest:[NSURLRequest requestWithURL:fileUrl]];
    }else if (![NSString isNOTNull:self.url]){
        [[WBPCreate sharedInstance]showWBProgress];
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]];
    }
  
   
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
}
#pragma mark - WKWebView代理
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
        //    Decides whether to allow or cancel a navigation after its response is known.
    NSLog(@"知道返回内容之后，是否允许加载，允许加载");
    
    decisionHandler(WKNavigationResponsePolicyAllow);
}
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler{
    WKNavigationResponsePolicy policy = WKNavigationResponsePolicyAllow;
    NSURL  *url = navigationAction.request.URL;
    if (WKNavigationTypeLinkActivated == navigationAction.navigationType && [url.scheme isEqualToString:@"https"]) {
        [[UIApplication sharedApplication]openURL:url];
        policy = WKNavigationResponsePolicyCancel;
    }
    decisionHandler(policy);
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
    [self loadSuccess];
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
    [webView evaluateJavaScript:@"document.readyState" completionHandler:^(id _Nullable readyState, NSError * _Nullable error) {
        
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
        //goToHome
    if ([message.name isEqualToString:@"pageJump"]){
        [self pageJumpParameter:message.body];
    }else if ([message.name isEqualToString:@"goHome"]){
        [self goHome];
    }
}
#pragma mark -URL跳转
-(void)pageJumpParameter:(NSDictionary *)dict{
  
}
-(void)goHome{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ==加载失败
-(void)loadFailed{
    [[WBPCreate sharedInstance]hideAnimated];
    maskView.hidden = YES;
    self.fd_interactivePopDisabled = NO;
//    [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
//        NSLog(@"123456");
//        [self loadWKwebViewData];
//    }];
}
#pragma mark ==加载成功
-(void)loadSuccess{
    [[WBPCreate sharedInstance]hideAnimated];
    maskView.hidden = YES;
    self.fd_interactivePopDisabled = YES;
//    [self deleteEmptyDataView];
}
@end
