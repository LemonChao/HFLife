//
//  YYB_HF_changeAccountVC.m
//  HFLife
//
//  Created by mac on 2019/5/24.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_changeAccountVC.h"
#import "YYB_HF_changeAccountCell.h"//
@interface YYB_HF_changeAccountVC()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) UITableView *myTable;//
@property(nonatomic, strong) NSMutableDictionary *accountDic;//账号字典
@property(nonatomic, strong) NSArray *accountMobileArr;//账号
@end
@implementation YYB_HF_changeAccountVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSMutableDictionary *accountDic = [[NSUserDefaults standardUserDefaults]valueForKey:USERINFO_ACCOUNT];
    if (accountDic && [accountDic isKindOfClass:[NSMutableDictionary class]]) {
        self.accountMobileArr = accountDic.allKeys;
        self.accountDic = [accountDic mutableCopy];
    }
    [self setupNavBar];
    [self setUpUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    //    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"NearFoodSousuo"]];
    //    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    //    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
        //        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"切换账号";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}

- (void)setUpUI {
    self.myTable = [[UITableView alloc]init];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.tableFooterView = [UIView new];
    self.myTable.backgroundColor = HEX_COLOR(0xF5F5F5);
    
    [self.view addSubview:self.myTable];
    
    [self.myTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.customNavBar.mas_bottom);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        if (self.accountMobileArr) {
            return self.accountMobileArr.count;
        }
        return 0;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 49;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section == 0) {
    static NSString *identifier = @"YYB_HF_changeAccountCell";

    YYB_HF_changeAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"YYB_HF_changeAccountCell" owner:self options:nil].lastObject;
        cell.headImageView.backgroundColor = [UIColor redColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSDictionary *accountItem = [self.accountDic valueForKey:self.accountMobileArr[indexPath.row]];
        [cell.headImageView sd_setImageWithURL:[accountItem valueForKey:@""] placeholderImage:image(@"")];
        NSString *accountStr = [accountItem valueForKey:@""];
        cell.accountLabel.text = accountStr;
        if ([accountStr isEqualToString:[userInfoModel sharedUser].member_mobile]) {
            [cell.cheackIcon setHidden:NO];
        }else {
            [cell.cheackIcon setHidden:YES];
        }
    }
        
    return cell;
    }else {
        static NSString *identifier = @"cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell.textLabel.text = @"换个新账号登录";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1) {
        [LoginVC login];
        [self.navigationController popToRootViewControllerAnimated:NO];
    }else {
        [WXZTipView showCenterWithText:@"切换成功"];
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 32;
    }
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 32)];
        view.backgroundColor = HEX_COLOR(0xF5F5F5);
        UILabel *label = [UILabel wh_labelWithText:@"汉富账号" textFont:11 textColor:HEX_COLOR(0xAAAAAA) frame:CGRectMake(13, 11, 150, 12)];
        [view addSubview:label];
        label.textAlignment = NSTextAlignmentLeft;
        return view;
    }
    
    return [UIView new];
}




@end
