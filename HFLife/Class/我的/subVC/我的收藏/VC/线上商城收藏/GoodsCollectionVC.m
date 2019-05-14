//
//  GoodsCollectionVC.m
//  HanPay
//
//  Created by mac on 2019/1/26.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "GoodsCollectionVC.h"
#import "GoodsCollectionCell.h"
//#import "HP_MyCollectionNetApi.h"


@interface GoodsCollectionVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *contentTableView;
@property (strong, nonatomic) UIView *editView;
@property (weak, nonatomic) UIButton *selectedBtn;

@property (weak, nonatomic) UIButton *deleteBtn;
@property (assign, nonatomic) NSInteger deleteNum;
@property (nonatomic,strong)NSMutableArray *deleteArray;
@property (nonatomic,strong)NSMutableArray *myDataArray;//数据
@property (nonatomic,strong)UILabel *noDataLabel;//暂无数据
//@property (nonatomic,strong)HP_MyCollectionNetApi *myRequest;//

@property (nonatomic, assign) BOOL isDataLoaded;
@end

@implementation GoodsCollectionVC
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = HEX_COLOR(0xf4f7f7);
    self.deleteArray = [NSMutableArray array];
    self.myDataArray = [NSMutableArray array];
    [self initWithUI];
}
-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@"viewDidLayoutSubviews");
    if (!self.isDataLoaded) {
//        [self.contentTableView beginRefreshing];
        self.isDataLoaded = YES;
    }
    
}
-(void)initWithUI{
    if (self.view.mj_w>SCREEN_WIDTH) {
        self.view.mj_w = SCREEN_WIDTH;
    }
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(SCREEN_WIDTH - 2*WidthRatio(20));
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.top.bottom.mas_equalTo(self.view);
    }];
    if (self.noDataLabel == nil) {
        self.noDataLabel = [UILabel new];
        self.noDataLabel.text = @"暂无数据";
        self.noDataLabel.textColor = [UIColor lightGrayColor];
        self.noDataLabel.hidden = YES;
        [self.view addSubview:self.noDataLabel];
        
        [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.contentTableView);
        }];
    }
//    [self.contentTableView refreshingData:^{
//        //        self->pag = 1;
//        //        [weakSelf.dataSource removeAllObjects];
//        self.myRequest.requestDataType = ListDropdownRefreshType;
//        [self.myDataArray removeAllObjects];
//        [self loadData];
//    }];
    
//    [self.contentTableView loadMoreDada:^{
//        self.myRequest.requestDataType = ListPullOnLoadingType;
//        [self loadData];
//    }];
    
    
    self.editView = [UIView new];
    [self.view addSubview:self.editView];
    [self.editView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(HeightRatio(100));
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    //    编辑区域
    UIImageView *editImageView = [[UIImageView alloc]init];
    [self.editView addSubview:editImageView];
    editImageView.userInteractionEnabled = YES;
    editImageView.image = [UIImage imageNamed:@"collectionBG"];
    [editImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_equalTo(self.editView);
    }];
    
    UIButton *selectedBtn = [UIButton new];
    [selectedBtn setTitle:@"全选" forState:(UIControlStateNormal)];
    [selectedBtn setTitle:@"取消全选" forState:UIControlStateSelected];
    [selectedBtn setImage:MMGetImage(@"meixuanzhong") forState:(UIControlStateNormal)];
    [selectedBtn setImage:MMGetImage(@"xuanzhong") forState:(UIControlStateSelected)];
    [selectedBtn setTitleColor:HEX_COLOR(0x666666) forState:UIControlStateNormal];
    selectedBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [selectedBtn setImagePosition:ImagePositionTypeLeft spacing:ScreenScale(23)];
    [selectedBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editView addSubview:selectedBtn];
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.editView.mas_centerY);
        make.left.mas_equalTo(self.editView.mas_left).offset(WidthRatio(41));
        make.height.mas_equalTo(HeightRatio(38));
        make.width.mas_equalTo(WidthRatio(170));
    }];
    self.selectedBtn = selectedBtn;
    
    UIButton *deleteBtn = [UIButton new];
    deleteBtn.backgroundColor = HEX_COLOR(0x9a38ed);
    [deleteBtn setTitle:@"删除(0)" forState:(UIControlStateNormal)];
    [deleteBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    deleteBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(26)];
    [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.editView addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.editView.mas_centerY);
        make.right.mas_equalTo(self.editView.mas_right).offset(-WidthRatio(24));
        make.height.mas_equalTo(HeightRatio(68));
        make.width.mas_equalTo(WidthRatio(180));
    }];
    MMViewBorderRadius(deleteBtn, HeightRatio(68)/2, 0, [UIColor clearColor]);
    self.deleteBtn = deleteBtn;
    
    self.editView.hidden = YES;
}
-(void)loadData{
    //    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            // 停止刷新
    //    });
    
    //    [self.contentTableView endRefreshing];
    
    /*
    
    if (self.myRequest == nil) {
        self.myRequest = [[HP_MyCollectionNetApi alloc]init];
        self.myRequest.requestDataType = ListDropdownRefreshType;
        
    }
    [self.myRequest startWithoutCacheCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self.contentTableView endLoadMore];
        [self.contentTableView endRefreshing];
        HP_MyCollectionNetApi *collectRequest = (HP_MyCollectionNetApi *)request;
        [self.noDataLabel setHidden:YES];
        if ([collectRequest getCodeStatus] == 1) {
            NSArray *dataArr = [collectRequest getContent];
            
            if (dataArr && [dataArr isKindOfClass:[NSArray class]]) {
                for (NSDictionary *dataDic in dataArr) {
                    MyCollectionModel *model = [[MyCollectionModel alloc]init];
                    [model setValuesForKeysWithDictionary:dataDic];
                    [self.myDataArray addObject:model];
                }
                [self.contentTableView reloadData];
                
                if (dataArr.count < 10) {
                    [self.contentTableView  setLoadMoreViewHidden:YES];
                }
            }
            //            if (self.myDataArray.count == 0 ) {
            //                NSDictionary *dataDic = @{
            //                    @"log_id": @"3",                        //收藏id
            //                    @"fav_id": @"100012",                    //商品id
            //                    @"fav_time": @"2019-01-30 16:37:46",    //收藏时间
            //                    @"store_id": @"1",                    //店铺id
            //                    @"store_name": @"汉富",                    //店铺名称
            //                    @"goods_name": @"女鞋平底鞋 蓝色 38",    //商品名称
            //                    @"goods_image": @"http://hf2.kim/system/upfiles/shop/store/goods/1/1_06009656186419023.png",
            //                    @"log_price": @"200.00"            //价格
            //                    };
            //                MyCollectionModel *model = [[MyCollectionModel alloc]init];
            //                [model setValuesForKeysWithDictionary:dataDic];
            //                [self.myDataArray addObject:model];
            //            }
        }else {
            [WXZTipView showCenterWithText:[collectRequest getMsg] duration:1.5];
        }
        
        if (self.myDataArray.count == 0) {
            [self.noDataLabel setHidden:NO];
        }
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (self.myDataArray.count == 0) {
            [self.noDataLabel setHidden:NO];
        }
        [WXZTipView showCenterWithText:@"网络错误" duration:1.5];
        
    }];
     
     */
    
    
}
#pragma mark 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.myDataArray) {
        return self.myDataArray.count;
    }
    return 0;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GoodsCollectionCell *cell = [GoodsCollectionCell GoodsCollectionCellWithTableView:tableView];
    if (self.myDataArray && self.myDataArray.count > indexPath.row) {
        MyCollectionModel *model = self.myDataArray[indexPath.row];
        cell.titleString = model.goods_name;
        cell.number = [NSString stringWithFormat:@"xxx人收藏"];
        cell.price = [NSString stringWithFormat:@"¥%@",model.log_price];//@"¥200";
        cell.img = model.goods_image;
    }else {
        cell.titleString = @"超级美味的泰式烧鹅吃啥都看了三大纪律回复";
        cell.number = @"151485698人收藏";
        cell.price = @"¥200";
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view =[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, HeightRatio(15))];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HeightRatio(15);
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(192);
}
#pragma mark - 系统编辑方法
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //      [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!tableView.editing) {
        //        [self.navigationController setNavigationBarHidden:YES animated:NO];
        //        PlayerViewController *playerVC = [[PlayerViewController alloc] init];
        //        playerVC.playerItem = item;
        //        [self.navigationController pushViewController:playerVC animated:true];
    }else{
        
        //        BOOL isbool = [self.deleteArray containsObject:item];
        //        if (!isbool) {
        //            [self.deleteArray addObject:item];
        //        }
        MyCollectionModel *model = self.myDataArray[indexPath.row];
        
        if (![self.deleteArray containsObject:model.log_id]) {
            [self.deleteArray addObject:model.log_id];
        }
        NSArray *subviews = [[tableView cellForRowAtIndexPath:indexPath] subviews];
        for (id subCell in subviews) {
            if ([subCell isKindOfClass:[UIControl class]]) {
                for (UIImageView *circleImage in [subCell subviews]) {
                    circleImage.image = [UIImage imageNamed:@"xuanzhong"];
                    
                }
            }
            
        }
        self.deleteNum += 1;
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(long)self.deleteNum] forState:UIControlStateNormal];
        
    }
}
//取消选中
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    //    YCDownloadItem *item = self.dataArray[indexPath.row];
    //    [self.deleteArray removeObject:item];
    MyCollectionModel *model = self.myDataArray[indexPath.row];
    
    if ([self.deleteArray containsObject:model.log_id]) {
        [self.deleteArray removeObject:model.log_id];
    }
    NSArray *subviews = [[tableView cellForRowAtIndexPath:indexPath] subviews];
    for (id subCell in subviews) {
        if ([subCell isKindOfClass:[UIControl class]]) {
            for (UIImageView *circleImage in [subCell subviews]) {
                circleImage.image = [UIImage imageNamed:@"weixuanzhong"];
            }
        }
    }
    self.deleteNum -= 1;
    if (self.deleteNum<0) {
        self.deleteNum = 0;
    }
    [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%ld)",(long)self.deleteNum] forState:UIControlStateNormal];
}
#pragma mark - 全选按钮被点击
- (void)selectedBtnClick {
    if (!self.selectedBtn.selected) {
        self.selectedBtn.selected = YES;
        for (int i = 0; i < self.myDataArray.count; i++) {
            MyCollectionModel *model = self.myDataArray[i];
            
            if (![self.deleteArray containsObject:model.log_id]) {
                [self.deleteArray addObject:model.log_id];
            }
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            [self.contentTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionBottom];
            GoodsCollectionCell *cell = [self.contentTableView cellForRowAtIndexPath:indexPath];
            cell.selected = YES;
            NSArray *subviews = [[self.contentTableView cellForRowAtIndexPath:indexPath] subviews];
            for (id subCell in subviews) {
                if ([subCell isKindOfClass:[UIControl class]]) {
                    for (UIImageView *circleImage in [subCell subviews]) {
                        circleImage.image = [UIImage imageNamed:@"xuanzhong"];
                    }
                }
            }
            
        }
        self.deleteNum = 10;
        [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
    }else{
        self.selectedBtn.selected = NO;
        [self.deleteArray removeAllObjects];
        for (int i = 0; i < self.myDataArray.count; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            [self.contentTableView deselectRowAtIndexPath:indexPath animated:NO];
            GoodsCollectionCell *cell = [self.contentTableView cellForRowAtIndexPath:indexPath];
            cell.selected = NO;
            [cell setEditing:YES animated:YES];
            self.deleteNum = 0;
            [self.deleteBtn setTitle:[NSString stringWithFormat:@"删除(%lu)",self.deleteNum] forState:UIControlStateNormal];
        }
    }
    
}
- (void)deleteBtnClick {
    
}
#pragma mark 懒加载
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xf4f7f7);
        _contentTableView.showsVerticalScrollIndicator = NO;
        //        _contentTableView.bounces = NO;
        //        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.tableHeaderView = [UIView new];
    }
    return _contentTableView;
}
-(void)setEditing:(BOOL)editing{
    _editing = editing;
    WS(weakSelf);
    self.contentTableView.editing = editing;
    self.editView.hidden =  !self.editView.hidden;
    [self.contentTableView mas_updateConstraints:^(MASConstraintMaker *make) {
        if (!weakSelf.editView.hidden) {
            make.width.mas_equalTo(SCREEN_WIDTH - 2*WidthRatio(20));
            make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
            make.top.mas_equalTo(self.view);
            make.bottom.mas_equalTo(self.view.mas_bottom).offset(-HeightRatio(100));
        }else{
            make.width.mas_equalTo(SCREEN_WIDTH - 2*WidthRatio(20));
            make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
            make.top.bottom.mas_equalTo(self.view);
        }
        
    }];
}

@end
