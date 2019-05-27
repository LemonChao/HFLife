
# 网络请求
1.
[networkingManagerTool requestToServerWithType:POST withSubUrl:<#(NSString *)#> withParameters:<#(NSDictionary *)#> withResultBlock:<#^(BOOL result, id value)valueBlock#> witnVC:<#(UIViewController *)#>]
2.
[networkingManagerTool requestToServerWithType:<#(NSString *)#> withSubUrl:<#(NSString *)#> withParameters:<#(NSDictionary *)#> withResultBlock:<#^(BOOL result, id value)valueBlock#>]


# 数据解析
[HR_dataManagerTool getTheRecordMsgWithArr:<#(NSArray *)#>  withClass:<#(__unsafe_unretained Class)#>]

#提示框
[WXZTipView showTopWithText:@"搜索"];


#baseTabele
@property (nonatomic, strong)baseTableView *tableView;
继承baseTableView  集成了刷新控件 page+-；

#适应屏幕 缩放比例
ScreenScale(<#x#>)



#必须真机调试的代码 放到  这里（加上宏定义）
#if TARGET_IPHONE_SIMULATOR// 模拟器
#elif TARGET_OS_IPHONE// 真机
#endif

#缺省页
[weakSelf.tableView showAlertViewToViewImageTYpe:IMAGETYPE_NOLIST msg:@"暂无数据" forView:TYPE_VIEW imageCenter:0 errorBlock:^{

}];

#登录提示y弹窗
[SXF_HF_AlertView showAlertType:AlertType_save Complete:^(BOOL btnBype) {
if (btnBype) {
NSLog(@"right");
}else{
NSLog(@"left");
}
}];

/**系统提示*/
#define ServiceAlertMsg
