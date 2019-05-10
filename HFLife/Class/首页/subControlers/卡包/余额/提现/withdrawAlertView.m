
//
//  withdrawAlertView.m
//  HFLife
//
//  Created by mac on 2019/4/16.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "withdrawAlertView.h"

@interface alertViewCell : UITableViewCell
@property (nonatomic, strong)UIImageView *bankImgeV;
@property (nonatomic, strong)UILabel *bankNameLb;
@property (nonatomic, strong)UILabel *timeLb;//两小时到账
@property (nonatomic, strong)UIView  *bottomLineV;
@end
@implementation alertViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}
- (void) setDataForCell:(bankListModel *) dataModel{
    [self.bankImgeV sd_setImageWithURL:[NSURL URLWithString:dataModel.bank_icon ? dataModel.bank_icon : @"http://www.weq"]];
    self.bankNameLb.text = [NSString stringWithFormat:@"%@（%@）", dataModel.bank_name ? dataModel.bank_name : @"", dataModel.bank_card ? dataModel.bank_card : @""];
    
}
- (void)addChildrenViews{
        self.bankImgeV = [UIImageView new];
        self.bankNameLb = [UILabel new];
        self.timeLb = [UILabel new];
        self.bottomLineV = [UIView new];
    
        [self.contentView addSubview:self.bankImgeV];
        [self.contentView addSubview:self.bankNameLb];
        [self.contentView addSubview:self.timeLb];
        [self.contentView addSubview:self.bottomLineV];
    
    
        self.bankImgeV.backgroundColor = HEX_COLOR(0x999999);
        self.bankImgeV.layer.cornerRadius = WidthRatio(36 * 0.5);
        self.bankImgeV.clipsToBounds = YES;
        self.bankNameLb.text = @"选择到账银行卡";
        self.timeLb.text = @"2小时内到账";
    
        self.bankNameLb.textColor = [UIColor blackColor];
        self.bankNameLb.font = [UIFont systemFontOfSize:WidthRatio(30)];
        self.timeLb.textColor = HEX_COLOR(0x999999);
        self.bankNameLb.font = [UIFont systemFontOfSize:WidthRatio(26)];
    
        self.bottomLineV.backgroundColor = HEX_COLOR(0xE1E1E1);
        self.timeLb.font = [UIFont systemFontOfSize:WidthRatio(26)];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
        [self.bankImgeV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(18));
            make.top.mas_equalTo(self.contentView.mas_top).offset(WidthRatio(40));
            make.width.height.mas_equalTo(WidthRatio(36));
        }];
    
        [self.bankNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bankImgeV.mas_right).offset(WidthRatio(17));
            make.centerY.mas_equalTo(self.bankImgeV.mas_centerY);
        }];
        [self.timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(self.bankNameLb.mas_leading);
            make.top.mas_equalTo(self.bankNameLb.mas_bottom).offset(WidthRatio(18));
        }];
        [self.bottomLineV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.contentView.mas_left).offset(WidthRatio(20));
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(0.5);
        }];
}


@end



@interface withdrawAlertView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)UIButton *closeBtn;
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *subTitleLb;

@property (nonatomic, strong)UIView *meddilLineV;
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)NSArray <bankListModel *>*bankModelArr;

@property (nonatomic ,copy) void(^closeCallback)(void);
@property (nonatomic, copy)void (^selectedCallback)(bankListModel *bankModel);
@property (nonatomic, copy)void (^bottomBtnClick)(void);
@end




@implementation withdrawAlertView
{
    CGFloat topY;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addCildernViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCildernViews];
    }
    return self;
}
- (void)setBankModelArr:(NSArray *)bankModelArr{
    _bankModelArr = bankModelArr;
    [self.tableView reloadData];
}
- (void) satrtAnima{
    NSInteger topY = WidthRatio(573);
    [UIView animateWithDuration:0.2 animations:^{
        self.tableView.frame = CGRectMake(0, topY, SCREEN_WIDTH, SCREEN_HEIGHT - topY);
    } completion:^(BOOL finished) {
        
    }];
}

+ (void) showAlert:(NSArray *)dataSource complace:(void(^)(bankListModel *bankModel))callback bottomBtn:(void(^)(void))bottomBtnCallBack{
    UIWindow *kw = [UIApplication sharedApplication].keyWindow;
    if (!kw) {
        kw = [UIApplication sharedApplication].windows.lastObject;
    }
    
    
    withdrawAlertView *alertV = [[withdrawAlertView alloc] init];
    alertV.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.7];
    alertV.frame = kw.bounds;
    [kw addSubview:alertV];
    
    alertV.bankModelArr = dataSource;
    
    [alertV satrtAnima];
    __weak typeof(alertV)weakAlertV = alertV;
    alertV.closeCallback = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.2 animations:^{
                weakAlertV.tableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - WidthRatio(573));
            } completion:^(BOOL finished) {
                [weakAlertV removeFromSuperview];
            }];
            
        });
        
    };
    alertV.selectedCallback = ^(bankListModel *bankModel){
        !callback ? : callback(bankModel);
    };
    alertV.bottomBtnClick = ^{
        !bottomBtnCallBack ? : bottomBtnCallBack();
    };
}

- (void) closeWindow{
    !self.closeCallback ? : self.closeCallback();
}

- (void) clickBottomBtn{
    [self closeWindow];
    !self.bottomBtnClick ? : self.bottomBtnClick();
}

- (void) addCildernViews{
    topY = WidthRatio(573);
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - topY) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, WidthRatio(20), 0, 0);
    self.tableView.separatorColor = HEX_COLOR(0xE1E1E1);
    [self.tableView registerClass:[alertViewCell class] forCellReuseIdentifier:@"cell"];
    [self addSubview:self.tableView];
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(106))];
    UIButton *bottomBtn = [UIButton new];
    [bottomView addSubview:bottomBtn];
    [bottomBtn setTitle:@"使用新卡提现" forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    [bottomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    bottomBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    bottomBtn.frame = CGRectMake(WidthRatio(70), 0, SCREEN_WIDTH - WidthRatio(70) , bottomView.frame.size.height);
    [bottomBtn addTarget:self action:@selector(clickBottomBtn) forControlEvents:UIControlEventTouchUpInside];
    UIView *bottomLineV = [UIView new];
    bottomLineV.backgroundColor = HEX_COLOR(0xE1E1E1);
    [bottomView addSubview:bottomLineV];
    bottomLineV.frame = CGRectMake(WidthRatio(30), bottomView.frame.size.height - 1, SCREEN_WIDTH - WidthRatio(30), 1);
    self.tableView.tableFooterView = bottomView;
    
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.bankModelArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    alertViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[alertViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    bankListModel *model = self.bankModelArr[indexPath.row];
    [cell setDataForCell:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    bankListModel *model = self.bankModelArr[indexPath.row];
    !self.selectedCallback ? : self.selectedCallback(model);
    [self closeWindow];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthRatio(158))];
    sectionView.backgroundColor = [UIColor whiteColor];
    self.headerView = sectionView;
    [self headerLayout];
    return sectionView;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return WidthRatio(156);
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return WidthRatio(158);
}


- (void)layoutSubviews{
    [super layoutSubviews];
}

- (void) headerLayout{
    
    self.closeBtn  = [UIButton new];
    self.titleLb   = [UILabel new];
    self.subTitleLb = [UILabel new];
    self.meddilLineV = [UIView new];
    [_headerView addSubview:self.closeBtn];
    [_headerView addSubview:self.titleLb];
    [_headerView addSubview:self.subTitleLb];
    [_headerView addSubview:self.meddilLineV];
    
    
    
    
    
//    self.closeBtn.backgroundColor = [UIColor redColor];
    [self.closeBtn setImage:[UIImage imageNamed:@"closeBtn"] forState:UIControlStateNormal];
    self.titleLb.font = [UIFont systemFontOfSize:WidthRatio(36)];
    self.titleLb.textColor = [UIColor blackColor];
    self.subTitleLb.font = [UIFont systemFontOfSize:WidthRatio(26)];
    self.subTitleLb.textColor = HEX_COLOR(0x999999);
    
    self.titleLb.text = @"选择到账银行卡";
    self.subTitleLb.text = @"请留意各银行到账时间";
    self.meddilLineV.backgroundColor = HEX_COLOR(0xE1E1E1);
    
    [self.closeBtn addTarget:self action:@selector(closeWindow) forControlEvents:UIControlEventTouchUpInside];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerView.mas_left).offset(WidthRatio(21));
        make.top.mas_equalTo(self.headerView.mas_top).offset(WidthRatio(31));
        make.height.with.mas_equalTo(25);
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(WidthRatio(31));
        make.centerX.mas_equalTo(self.headerView.mas_centerX);
    }];
    [self.subTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLb.mas_centerX);
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(WidthRatio(20));
    }];
    
    [self.meddilLineV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(self.headerView);
        make.height.mas_equalTo(1);
    }];
}

//- (UIView *)headerView{
//    if (!_headerView) {
//
//    }
//    return _headerView;
//}



@end
