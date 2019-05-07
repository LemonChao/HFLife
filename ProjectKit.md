
#网络请求
[networkingManagerTool requestToServerWithType:POST withSubUrl:<#(NSString *)#> withParameters:<#(NSDictionary *)#> withResultBlock:<#^(BOOL result, id value)valueBlock#> witnVC:<#(UIViewController *)#>]

# 数据解析
[HR_dataManagerTool getTheRecordMsgWithArr:<#(NSArray *)#>  withClass:<#(__unsafe_unretained Class)#>]

#提示框
[WXZTipView showTopWithText:@"搜索"];


#baseTabele
@property (nonatomic, strong)baseTableView *tableView;
继承baseTableView  集成了刷新控件 page+-；

