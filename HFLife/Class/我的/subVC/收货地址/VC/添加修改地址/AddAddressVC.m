//
//  AddAddressVC.m
//  HanPay
//
//  Created by mac on 2019/1/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "AddAddressVC.h"
#import "UITextView+ZWPlaceHolder.h"
#import "ZHFAddTitleAddressView.h"
#import "Per_MethodsToDealWithManage.h"
@interface AddAddressVC ()<ZHFAddTitleAddressViewDelegate>
{
    NSArray *_titleIDs;
    NSString *is_default;
    UISwitch *_switch;
}
/** 用户名 */
@property (nonatomic,strong) UITextField *userNameTextField;
/** 手机号码 */
@property (nonatomic,strong) UITextField *phoneTextField;
/** 所在地区 */
@property (nonatomic,strong) UITextField *addressTextField;
/** 详细地址 */
@property (nonatomic,strong) UITextView *detailedAddressTextView;

@property(nonatomic,strong)ZHFAddTitleAddressView * addTitleAddressView;
/** 是否是默认*/
@property (nonatomic ,strong)NSString *isDetauled;
@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    is_default = @"0";
    self.view.backgroundColor = HEX_COLOR(0xf4f7f7);
    [self initWithUI];
    [self setupNavBar];
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
    [self.customNavBar wr_setRightButtonWithTitle:@"保存" titleColor:HEX_COLOR(0x9b2ce6)];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        NSLog(@"保存");
        [weakSelf saveAddress];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"我的收货地址";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    
    
}
-(void)initWithUI{
    self.userNameTextField = [self getTextFieldPlaceholder:@"收货人姓名" imageName:@"" rightTitle:@""];
    [self.view addSubview:self.userNameTextField];
    [self.userNameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(HeightRatio(96));
        make.top.mas_equalTo(self.view.mas_top).offset(self.navBarHeight);
    }];
    
    self.phoneTextField = [self getTextFieldPlaceholder:@"手机号码" imageName:@"addAddress" rightTitle:@"+86"];
    self.phoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    [self.view addSubview:self.phoneTextField];
    [self.phoneTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(HeightRatio(96));
        make.top.mas_equalTo(self.userNameTextField.mas_bottom);
    }];
    
    self.addressTextField = [self getTextFieldPlaceholder:@"所在地区" imageName:@"addAddress" rightTitle:@""];
    self.addressTextField.userInteractionEnabled = NO;
    [self.view addSubview:self.addressTextField];
    [self.addressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left);
        make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(HeightRatio(96));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom);
    }];
    
    UIButton *button = [UIButton new];
    button.backgroundColor = [UIColor clearColor];
    [button addTarget:self action:@selector(addAddressClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.view.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(96));
        make.top.mas_equalTo(self.phoneTextField.mas_bottom);
    }];
    
    [self.view addSubview:self.detailedAddressTextView];
    [self.detailedAddressTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(0);
        make.right.mas_equalTo(self.view.mas_right).offset(0);
        make.height.mas_equalTo(HeightRatio(139));
        make.top.mas_equalTo(self.addressTextField.mas_bottom);
    }];
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.detailedAddressTextView.mas_bottom).offset(HeightRatio(51));
        make.height.mas_equalTo(HeightRatio(90));
    }];
    
    UILabel *label = [UILabel new];
    label.text = @"设为默认地址";
    label.font = [UIFont systemFontOfSize:WidthRatio(27)];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left).offset(WidthRatio(20));
        make.centerY.mas_equalTo(view.mas_centerY);
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_equalTo(HeightRatio(27));
    }];

    UISwitch * swi = [[UISwitch alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - WidthRatio(133), HeightRatio(17), WidthRatio(113), HeightRatio(60))];
        // 设置控件开启状态填充色
    swi.onTintColor = HEX_COLOR(0x952aef);
    // 设置控件关闭状态填充色
    swi.tintColor = [UIColor lightGrayColor];
    // 设置控件开关按钮颜色
    swi.thumbTintColor = [UIColor whiteColor];
    
    swi.backgroundColor = [UIColor lightGrayColor];
    swi.layer.cornerRadius = swi.height/2.0;
    swi.layer.masksToBounds = YES;
        // 当控件值变化时触发changeColor方法
    [swi addTarget:self action:@selector(changeColor:) forControlEvents:UIControlEventValueChanged];
    [view addSubview:swi];
    swi.sd_layout
    .rightSpaceToView(view, WidthRatio(20))
    .centerYEqualToView(view)
    .widthIs(WidthRatio(112))
    .heightIs(WidthRatio(60));
    _switch = swi;
    
   
    
    if (self.dataModel) {
        UIView *deleteView = [UIView new];
        deleteView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:deleteView];
        [deleteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(view.mas_bottom).offset(HeightRatio(51));
            make.height.mas_equalTo(HeightRatio(90));
        }];
        
        UILabel *deletelabel = [UILabel new];
        deletelabel.text = @"删除该收货地址";
        deletelabel.font = [UIFont systemFontOfSize:WidthRatio(27)];
        deletelabel.textColor = [UIColor redColor];
        [deleteView addSubview:deletelabel];
        [deletelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(deleteView.mas_left).offset(WidthRatio(20));
            make.centerY.mas_equalTo(deleteView.mas_centerY);
            make.width.mas_greaterThanOrEqualTo(1);
            make.height.mas_equalTo(HeightRatio(27));
        }];
        
        UIButton *deleteBtn = [UIButton new];
        deleteBtn.backgroundColor = [UIColor clearColor];
        [deleteBtn addTarget:self action:@selector(deleteBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
        [self.view addSubview:deleteBtn];
        [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.view);
            make.top.mas_equalTo(view.mas_bottom).offset(HeightRatio(51));
            make.height.mas_equalTo(HeightRatio(90));
        }];
        [self editorAddress];
        
    }
    self.addTitleAddressView = [[ZHFAddTitleAddressView alloc]init];
    self.addTitleAddressView.title = @"选择地址";
    self.addTitleAddressView.userID = 7;
    self.addTitleAddressView.delegate1 = self;
    self.addTitleAddressView.defaultHeight = 350;
    self.addTitleAddressView.titleScrollViewH = 37;
    [self.view addSubview:[self.addTitleAddressView initAddressView]];
}
-(void)editorAddress{
    self.userNameTextField.text = self.dataModel.true_name;
    self.phoneTextField.text = self.dataModel.mob_phone;
    self.addressTextField.text = self.dataModel.area_info;
    self.detailedAddressTextView.text = self.dataModel.address;
    is_default = self.dataModel.is_default;
    [_switch setOn:[self.dataModel.is_default isEqualToString:@"1"] ? YES:NO];
    
}
-(void)changeColor:(UISwitch *)swi{
    if(swi.isOn){
        //开
        is_default = @"1";
    }else{
        //关
        is_default = @"0";
    }
}
-(void)saveAddress{
    if ([NSString isNOTNull:self.userNameTextField.text]) {
        [WXZTipView showCenterWithText:@"请填写收货人姓名"];
        return;
    }
    if (![self.phoneTextField.text isValidateMobile]) {
        [WXZTipView showCenterWithText:@"请输入正确的手机号"];
        return;
    }
    if ([NSString isNOTNull:self.addressTextField.text]) {
        [WXZTipView showCenterWithText:@"请选择所在地区"];
        return;
    }
    if ([NSString isNOTNull:self.detailedAddressTextView.text]) {
        [WXZTipView showCenterWithText:@"请填写详细地址"];
        return;
    }
    NSString *addressID = @"";
    if (_titleIDs == nil) {
        addressID = self.dataModel.area_id;
    }else{
        addressID = _titleIDs.lastObject;
    }
    NSDictionary *dict = @{
                           @"area_id":addressID,
                           @"true_name":self.userNameTextField.text,
                           @"area_info":self.addressTextField.text,
                           @"address":self.detailedAddressTextView.text,
                           @"phone":self.phoneTextField.text,
                           @"is_default":is_default
                           };
    if (self.dataModel) {
        NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:dict];
        [mutableDict setObject:MMNSStringFormat(@"%@",self.dataModel.address_id) forKey:@"address_id"];
        [[Per_MethodsToDealWithManage sharedInstance] editorAddressParameter:mutableDict SuccessBlock:^(id  _Nonnull request) {
            if ([request boolValue]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }else{
        [[Per_MethodsToDealWithManage sharedInstance]addAddressParameter:dict SuccessBlock:^(id  _Nonnull request) {
            if ([request boolValue]) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    }
    
}
-(UITextField *)getTextFieldPlaceholder:(NSString *)placeholder imageName:(NSString *)imageName rightTitle:(NSString *)rightTitle{
    UITextField *tf = [[UITextField alloc] init];
//    tf.keyboardType = UIKeyboardTypeTwitter;
    tf.placeholder = placeholder;
    [tf setValue:HEX_COLOR(0x979797) forKeyPath:@"_placeholderLabel.textColor"];
    tf.textColor = HEX_COLOR(0x353535);
    tf.font = [UIFont systemFontOfSize:HeightRatio(27)];
    tf.backgroundColor = [UIColor whiteColor];
    if (![NSString isNOTNull:imageName]) {
        UIView *lv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(100), HeightRatio(96))];
        lv.backgroundColor = [UIColor clearColor];
        
        UIImageView *iconImageView = [UIImageView new];
        iconImageView.image = MMGetImage(imageName);
        [lv addSubview:iconImageView];
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(lv.mas_right).offset(-WidthRatio(20));
            make.centerY.mas_equalTo(lv.mas_centerY);
            make.width.mas_equalTo(WidthRatio(10));
            make.height.mas_equalTo(HeightRatio(16));
        }];
        if (![NSString isNOTNull:rightTitle]) {
            UILabel *rightTitleLabel = [UILabel new];
            rightTitleLabel.text = rightTitle;
            rightTitleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
            rightTitleLabel.textColor = [UIColor blackColor];
            rightTitleLabel.textAlignment = NSTextAlignmentCenter;
            [lv addSubview:rightTitleLabel];
            [rightTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(iconImageView.mas_left).offset(-WidthRatio(15));
                make.top.bottom.left.mas_equalTo(lv);
            }];
        }
       
        
        
        tf.rightViewMode = UITextFieldViewModeAlways;
        tf.rightView = lv;
        [tf sizeToFit];
    }
    UIView *vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WidthRatio(20), HeightRatio(96))];
    vi.backgroundColor = [UIColor clearColor];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.leftView = vi;
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xebebeb);
    [tf addSubview:lin];
    [lin mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(tf).offset(-HeightRatio(1));
        make.left.mas_equalTo(tf.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(tf.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(HeightRatio(1));
    }];
    [self.view addSubview:tf];
    return tf;
    
}
-(void)addAddressClick{
    [self.addTitleAddressView addAnimate];
}
-(void)deleteBtnClick{
    NSLog(@"删除地址");
    NSDictionary *dict  = @{@"address_id":self.dataModel.address_id};
    [[Per_MethodsToDealWithManage sharedInstance] deleteAddressParameter:dict SuccessBlock:^(id  _Nonnull request) {
        if ([request boolValue]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}
#pragma  mark 代理
//-(void)cancelBtnClick:(NSString *)titleAddress titleID:(NSString *)titleID{
//    self.addressTextField.text = titleAddress;
//    NSLog( @"%@===%@", [NSString stringWithFormat:@"打印的对应省市县的id=%@",titleID],titleAddress);
//}
-(void)cancelBtnClick:(NSString *)titleAddress titleIDs:(NSArray *)titleIDs{
     self.addressTextField.text = titleAddress;
    _titleIDs = titleIDs;
}
#pragma mark 懒加载
-(UITextView *)detailedAddressTextView{
    if (!_detailedAddressTextView) {
        _detailedAddressTextView = [[UITextView alloc]init];
        _detailedAddressTextView.font = [UIFont systemFontOfSize:WidthRatio(28)];
        _detailedAddressTextView.placeholder = @"详细地址";
        _detailedAddressTextView.textContainerInset = UIEdgeInsetsMake(5, 5, 0, 0);
        _detailedAddressTextView.backgroundColor = [UIColor whiteColor];
    }
    return _detailedAddressTextView;
}
@end
