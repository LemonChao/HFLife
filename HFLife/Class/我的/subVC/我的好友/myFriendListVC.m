
//
//  myFriendListVC.m
//  HanPay
//
//  Created by mac on 2019/4/27.
//  Copyright © 2019 mac. All rights reserved.
//

#import "myFriendListVC.h"
#import "friendListView.h"
//#import "friendListNetApi.h"

@interface myFriendListVC ()
@property (nonatomic, strong)friendListView *listView;
@property (nonatomic, strong)NSMutableArray *dataSourceArray;
//@property (nonatomic, strong)friendListNetApi *friendNetApi;
@property (nonatomic, strong)UIView *bgView;

@end

@implementation myFriendListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavBar];
    [self.view addSubview:self.listView];
    [self axcBaseRequestData];
    self.listView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.bgView];
    self.bgView.hidden = YES;
}



-(void)axcBaseRequestData{
    WS(weakSelf);
    
    /*
    
    
    //    self.recordNetApi.requestUrl = @"";
    if (!self.friendNetApi) {
        self.friendNetApi = [[friendListNetApi alloc] init];
    }
    [self.friendNetApi startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf.listView.tableView endLoadMore];
        [weakSelf.listView.tableView endRefreshing];
        friendListNetApi *friendApi = (friendListNetApi *)request;
        if ([[friendApi getContent] isKindOfClass:[NSArray class]]) {
            self.bgView.hidden = YES;
            NSArray *requestArr = (NSArray *)[friendApi getContent];
            if (requestArr.count>0) {
                if ((self.friendNetApi.requestDataType == ListDropdownRefreshType)) {
                    [self.dataSourceArray removeAllObjects];
                }
                [self.dataSourceArray addObjectsFromArray:requestArr];
                self.bgView.hidden = YES;
                [self deleteEmptyDataView];
            }else{
                if (self.dataSourceArray.count == 0) {
                    self.bgView.hidden = NO;
                    [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                        [weakSelf axcBaseRequestData];
                    }];
                }else{
                    [self deleteEmptyDataView];
                    self.bgView.hidden = YES;
                }
            }
            weakSelf.listView.dataSourceArr = self.dataSourceArray;
//            if (self.dataSourceArray.count > 0) {
//                self.listView.totleTitle = [NSString stringWithFormat:@"%lu个好友", (unsigned long)self.dataSourceArray.count];
//            }
            NSDictionary *value = [friendApi responseJSONObject];
            if ([value isKindOfClass:[NSDictionary class]]) {
                if ([value[@"data"] isKindOfClass:[NSDictionary class]]) {
                    self.listView.totleTitle = [NSString stringWithFormat:@"%@个好友", value[@"data"][@"total"] ? value[@"data"][@"total"] : @"0"];
                }
            }
            
            
            if (requestArr.count<10) {
                [weakSelf.listView.tableView setLoadMoreViewHidden:YES];
            }
            
        }else{
            if (self.dataSourceArray.count == 0) {
                [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                    [weakSelf axcBaseRequestData];
                }];
            }
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
     
     */
}

























-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:NO];
    self.customNavBar.title = @"我的好友";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    
}
- (friendListView *)listView{
    if (!_listView) {
        _listView = [[friendListView alloc] initWithFrame:CGRectMake(0, self.navBarHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.navBarHeight)];
    }
    return _listView;
}
- (NSMutableArray *)dataSourceArray{
    if (!_dataSourceArray) {
        _dataSourceArray = [NSMutableArray array];
    }
    return _dataSourceArray;
}


- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.listView.frame];
        _bgView.backgroundColor = [UIColor whiteColor];
        UIButton *btn = [UIButton new];
        UILabel *titleLb = [UILabel new];
        titleLb.numberOfLines = 0;
        titleLb.text = [NSString stringWithFormat:@"还没有好友"];
        UILabel *titleLb2 = [UILabel new];
        titleLb2.text = @"快去分享邀请";
        
//        NSMutableAttributedString *attributedString =
//        [[NSMutableAttributedString alloc] initWithString:titleLb.text];
//        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
//        [paragraphStyle setLineSpacing:5];
//
//        //调整行间距
//        [attributedString addAttribute:NSParagraphStyleAttributeName
//                                 value:paragraphStyle
//                                 range:NSMakeRange(0, [titleLb.text length])];
//        titleLb.attributedText = attributedString;
        
        
        
        titleLb.textColor = HEX_COLOR(0x999999);
        titleLb.textAlignment = NSTextAlignmentCenter;
        titleLb.font = [UIFont systemFontOfSize:WidthRatio(30)];
        titleLb2.font = titleLb.font;
        titleLb2.textColor = titleLb.textColor;
        titleLb2.textAlignment = NSTextAlignmentCenter;
        
        [btn setBackgroundImage:[UIImage imageNamed:@"noDataImage"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:btn];
        [_bgView addSubview:titleLb];
        [_bgView addSubview:titleLb2];
        
        btn.frame = CGRectMake(0, 0, SCREEN_WIDTH - WidthRatio(142),WidthRatio(448));
        btn.center = CGPointMake(_bgView.centerX, _bgView.frame.size.height * 0.5);
        
        [titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self->_bgView);
            make.top.mas_equalTo(btn.mas_bottom).offset(-10);
        }];
        
        [titleLb2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self->_bgView);
            make.top.mas_equalTo(titleLb.mas_bottom).offset(6);
        }];
    }
    return _bgView;
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
}


- (void) reloadData{
    [self axcBaseRequestData];
}


@end
