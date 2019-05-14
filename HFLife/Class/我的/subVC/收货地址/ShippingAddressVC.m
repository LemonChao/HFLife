//
//  ShippingAddressVC.m
//  HanPay
//
//  Created by mac on 2019/1/19.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "ShippingAddressVC.h"
#import "AddressListCell.h"
#import "AddAddressVC.h"
#import "Per_MethodsToDealWithManage.h"
@interface ShippingAddressVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *dataArray;
    
}
@property (nonatomic,strong)UITableView *contentTableView;
@end

@implementation ShippingAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initWithUI];
    [self setupNavBar];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setRightButtonWithTitle:@"添加新地址" titleColor:[UIColor blackColor]];//HEX_COLOR(0x323232)
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"添加");
        [weakSelf.navigationController pushViewController:[[AddAddressVC alloc]init] animated:YES];
    }];
    self.customNavBar.title = @"收货地址";
    self.customNavBar.rightButton.setTitleFont(FONT(13));
    [self.customNavBar setRightBtnWidth:100];
    
}
-(void)initWithUI{
    [self.view addSubview:self.contentTableView];
    [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
    }];
}
-(void)axcBaseRequestData{
    WS(weakSelf);
    /*
    [[Per_MethodsToDealWithManage sharedInstance] getAddressListSuccessBlock:^(id  _Nonnull request) {
        if ([request isKindOfClass:[NSArray class]]) {
            NSArray *requestArr = (NSArray *)request;
            if (requestArr.count>0) {
                 self->dataArray = request;
                [self deleteEmptyDataView];
            }else{
                self->dataArray = nil;
                [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                    [weakSelf axcBaseRequestData];
                }];
            }
    		
        }else{
            self->dataArray = nil;
            [self initEmptyDataViewbelowSubview:self.customNavBar touchBlock:^{
                [weakSelf axcBaseRequestData];
            }];
        }
        [self.contentTableView reloadData];
    }];
     
     */
}

#pragma mark 列表代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddressListCell"];
    if (!cell) {
        cell = [[AddressListCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"AddressListCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    AddressModel *model = dataArray[indexPath.row];
    cell.userName = model.true_name;
    cell.phone = model.mob_phone;
    cell.isDefault = [model.is_default isEqualToString:@"1"]? YES : NO;
    cell.address = MMNSStringFormat(@"%@ %@",model.area_info,model.address);
    [cell setEditorBlock:^{
        AddAddressVC *addres = [[AddAddressVC alloc]init];
//        addres.isEditor = YES;
        addres.dataModel = model;
        [weakSelf.navigationController pushViewController:addres animated:YES];
    }];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return HeightRatio(164);
}
-(NSArray<UITableViewRowAction *>*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    WS(weakSelf);
    UITableViewRowAction *action = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        NSLog(@"删除");
        AddressModel *model = self->dataArray[indexPath.row];
        [[Per_MethodsToDealWithManage sharedInstance] deleteAddressParameter:@{@"address_id":model.address_id} SuccessBlock:^(id  _Nonnull request) {
            [weakSelf axcBaseRequestData];
        }];
        [tableView setEditing:NO animated:YES];
    }];
    return @[action];
}
#pragma mark 懒加载
-(UITableView *)contentTableView{
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] initWithFrame:CGRectZero
                                                         style:UITableViewStylePlain];
        _contentTableView.delegate = self;
        _contentTableView.dataSource = self;
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.backgroundColor = HEX_COLOR(0xffffff);
        _contentTableView.bounces = NO;
            //        _contentTableView.tableFooterView = [UIView new];
        _contentTableView.tableHeaderView = [UIView new];
    }
    return _contentTableView;
}

@end
