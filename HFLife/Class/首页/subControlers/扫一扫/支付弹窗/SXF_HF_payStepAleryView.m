
//
//  SXF_HF_payStepAleryView.m
//  HFLife
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_payStepAleryView.h"
#import "SXF_HF_payStepTowCel.h"

//自定义键盘
#import "SXF_HF_KeyBoardView.h"
@interface SXF_HF_payStepAleryView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView *showAlertView;//父控件
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UIView *bottomLineView;
@property (nonatomic, strong)void(^cancleBtnCallback)(NSInteger step);


@property (nonatomic, strong)UIView *stepOneView;//子控件1
@property (nonatomic, strong)UILabel *stepOneMoneyLb;
@property (nonatomic, strong)UILabel *stepOneIncoderLb;//人民币
@property (nonatomic, strong)UILabel *stepOneOrderTitle;
@property (nonatomic, strong)UILabel *stepOneProductNameLb;
@property (nonatomic, strong)UIView *stepOneline1;
@property (nonatomic, strong)UILabel *stepOnepayTypeTitleLb;
@property (nonatomic, strong)UILabel *stepOnepayTypeLb;
@property (nonatomic, strong)UIView *stepOneline2;
@property (nonatomic, strong)UIButton *nowPayBtn;
@property (nonatomic, strong)UIImageView *rightImageV;
@property (nonatomic, strong)UIButton *goStep2Btn;
@property (nonatomic, strong)void(^clickStepOneBtnCallback)(NSInteger tag);



@property (nonatomic, strong)UIView *stepTwoView;//子控件2
@property (nonatomic, strong)UITableView *stepTowTableView;
@property (nonatomic, strong)void(^clickStepTowCellCallback)(NSIndexPath *indexPath);
@property (nonatomic, strong)UIView *stepThreeView;//子控件3
@property (nonatomic, strong)SXF_HF_KeyBoardView *passwordInputView;








@property (nonatomic, assign)NSInteger step;//第几步
@end


@implementation SXF_HF_payStepAleryView
{
    NSArray *_titleArr;
    NSArray *_imageArr;
    NSArray *_subTitle;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    
    _titleArr = @[@"余额(剩余:￥8888.88)", @"支付宝(*秋艳)", @"微信(*秋艳)", @"QQ钱包", @"中国工商银行储蓄卡(8888)", @"花呗"];
    _imageArr = @[@"余额", @"支付宝", @"微信 (1)", @"qqPay", @"工商银行", @"花呗"];
    _subTitle = @[@"", @"", @"", @"", @"", @"当前交易暂不支付花呗，请选择其他方式交易"];
    
    self.showAlertView = [UIView new];
    self.titleLb       = [UILabel new];
    self.bottomLineView= [UIView new];
    self.cancleBtn     = [UIButton new];
    
    self.stepOneView   = [UIView new];
    self.stepTwoView   = [UIView new];
    self.stepThreeView = [UIView new];
    
    
    [self addSubview:self.showAlertView];
    [self.showAlertView addSubview:self.cancleBtn];
    [self.showAlertView addSubview:self.titleLb];
    [self.showAlertView addSubview:self.bottomLineView];
    
    
    [self.showAlertView addSubview:self.stepOneView];
    [self.showAlertView addSubview:self.stepTwoView];
    [self.showAlertView addSubview:self.stepThreeView];
    
    
    
    self.stepOneMoneyLb = [UILabel new];
    self.stepOneOrderTitle = [UILabel new];
    self.stepOneProductNameLb = [UILabel new];
    self.stepOneIncoderLb = [UILabel new];
    self.stepOnepayTypeTitleLb = [UILabel new];
    self.stepOnepayTypeLb = [UILabel new];
    self.stepOneline2 = [UIView new];
    self.stepOneline1 = [UIView new];
    self.nowPayBtn = [UIButton new];
    self.rightImageV = [UIImageView new];
    self.goStep2Btn = [UIButton new];
    
    [self.stepOneView addSubview:self.stepOneOrderTitle];
    [self.stepOneView addSubview:self.stepOneMoneyLb];
    [self.stepOneView addSubview:self.stepOneProductNameLb];
    [self.stepOneView addSubview:self.stepOneIncoderLb];
    [self.stepOneView addSubview:self.stepOnepayTypeTitleLb];
    [self.stepOneView addSubview:self.stepOnepayTypeLb];
    [self.stepOneView addSubview:self.stepOneline2];
    [self.stepOneView addSubview:self.stepOneline1];
    [self.stepOneView addSubview:self.nowPayBtn];
    [self.stepOneView addSubview:self.rightImageV];
    [self.stepOneView addSubview:self.goStep2Btn];
    
    
    
    
    self.nowPayBtn.tag = 100;
    self.goStep2Btn.tag = 99;
    
    
    [self.cancleBtn setImage:MY_IMAHE(@"关闭") forState:UIControlStateNormal];
    [self.cancleBtn addTarget:self action:@selector(clickCancleBtn)];
    self.titleLb.setText(@"确认支付").setTextColor(HEX_COLOR(0x0C0B0B)).setFontSize(18.0);
    self.bottomLineView.setBackgroundColor(HEX_COLOR(0xF5F5F5));
    
    //view1
    self.stepOneMoneyLb.setFont([UIFont fontWithName:@"PingFang-SC-Medium" size:50]).setTextColor(HEX_COLOR(0x0C0B0B));
    self.stepOneIncoderLb.setFont([UIFont fontWithName:@"PingFang-SC-Medium" size:16]).setTextColor(HEX_COLOR(0x0C0B0B));
    self.stepOneOrderTitle.setFontSize(14).setTextColor(HEX_COLOR(0xAAAAAA))
    .setText(@"订单信息");
    self.stepOneProductNameLb.setFontSize(14).setTextColor(HEX_COLOR(0x0C0B0B))
    .setText(@"商品");
    self.stepOnepayTypeTitleLb.setFontSize(14).setTextColor(HEX_COLOR(0xAAAAAA))
    .setText(@"付款方式");
    self.stepOnepayTypeLb.setFontSize(14).setTextColor(HEX_COLOR(0x0C0B0B))
    .setText(@"余额");
    self.stepOneline1.backgroundColor = self.stepOneline2.backgroundColor = HEX_COLOR(0xF5F5F5);
    self.rightImageV.image = MY_IMAHE(@"gengduo");
    self.stepOneIncoderLb.text = @"¥";
    self.stepOneMoneyLb.text = @"888";
    self.goStep2Btn.backgroundColor = [UIColor clearColor];
    self.nowPayBtn.layer.cornerRadius = 5;
    self.nowPayBtn.layer.masksToBounds = YES;
    self.nowPayBtn.backgroundColor = HEX_COLOR(0xCA1400);
    [self.nowPayBtn setTitle:@"立即付款" forState:UIControlStateNormal];
    [self.nowPayBtn addTarget:self action:@selector(clickStepOneBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.goStep2Btn addTarget:self action:@selector(clickStepOneBtn:) forControlEvents:UIControlEventTouchUpInside];
    //view2
    [self.stepTwoView addSubview:self.stepTowTableView];
    self.stepTowTableView.delegate = self;
    self.stepTowTableView.dataSource = self;
    
    //view3
    
    [self layoutIfNeeded];
    self.passwordInputView = [SXF_HF_KeyBoardView new];
    [self.stepThreeView addSubview:self.passwordInputView];
    

    
    
    
    self.stepOneView.backgroundColor = [UIColor whiteColor];
    self.stepTwoView.backgroundColor = [UIColor whiteColor];
    self.stepThreeView.backgroundColor = [UIColor whiteColor];
    

    
}


- (void)setStep:(NSInteger)step{
    _step = step;
    [self.cancleBtn setImage:MY_IMAHE(_step == 0 ? @"关闭" : @"back") forState:UIControlStateNormal];
}

- (void)clickCancleBtn{
    NSLog(@"关闭  step=%ld", self.step);
    !self.cancleBtnCallback? : self.cancleBtnCallback(self.step);
}
//步骤一按钮
-(void)clickStepOneBtn:(UIButton *)sender{
    NSInteger index = sender.tag - 99;
    !self.clickStepOneBtnCallback ? : self.clickStepOneBtnCallback(index);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_payStepTowCel *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_payStepTowCel class]) forIndexPath:indexPath];
    
    cell.typeNameLb.text = _titleArr[indexPath.row];
    cell.subLb.text = _subTitle[indexPath.row];
    cell.headerImageV.image = MY_IMAHE(_imageArr[indexPath.row]);
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    !self.clickStepTowCellCallback ? : self.clickStepTowCellCallback(indexPath);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_subTitle[indexPath.row] isEqualToString:@""]) {
        return ScreenScale(49);
    }
    return ScreenScale(68);
}







- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.showAlertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(self);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.showAlertView.mas_left).offset(ScreenScale(6));
        make.top.mas_equalTo(self.showAlertView.mas_top);
        make.width.height.mas_equalTo(ScreenScale(53));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.showAlertView.mas_centerX);
        make.centerY.mas_equalTo(self.cancleBtn.mas_centerY);
    }];
    
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.showAlertView);
        make.height.mas_equalTo(1);
        make.top.mas_equalTo(self.cancleBtn.mas_bottom);
    }];
    
    
    
    [self.stepOneView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.showAlertView);
        make.top.mas_equalTo(self.bottomLineView.mas_bottom);
    }];
    
    [self.stepTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.stepOneView.mas_right);
        make.top.bottom.mas_equalTo(self.stepOneView);
        make.width.mas_equalTo(self.stepOneView.mas_width);
    }];
    
    [self.stepThreeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.stepTwoView);
    }];
    
    
    
    
    //view1
    [self.stepOneMoneyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.stepOneView.mas_centerX).offset(6);
        make.top.mas_equalTo(self.stepOneView.mas_top).offset(ScreenScale(52));
        make.height.mas_equalTo(38);
    }];
    [self.stepOneIncoderLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.stepOneMoneyLb.mas_left);
        make.bottom.mas_equalTo(self.stepOneMoneyLb.mas_bottom);
        make.height.mas_equalTo(16);
    }];
    
    [self.stepOneOrderTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.stepOneView.mas_left).offset(ScreenScale(12));
        make.top.mas_equalTo(self.stepOneMoneyLb.mas_bottom).offset(32);
        make.height.mas_equalTo(13);
    }];
    [self.stepOneProductNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.stepOneView.mas_right).offset(ScreenScale(-12));
        make.centerY.mas_equalTo(self.stepOneOrderTitle.mas_centerY);
        make.height.mas_equalTo(13);
    }];
    
    [self.stepOneline1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stepOneOrderTitle.mas_bottom).offset(ScreenScale(16));
        make.left.mas_equalTo(self.stepOneOrderTitle.mas_left);
        make.right.mas_equalTo(self.stepOneProductNameLb.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    
    [self.stepOnepayTypeTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.stepOneOrderTitle.mas_left);
        make.right.mas_equalTo(self.stepOneProductNameLb.mas_right);
        make.height.mas_equalTo(13);
        make.top.mas_equalTo(self.stepOneline1.mas_bottom).offset(ScreenScale(20));
    }];
    [self.rightImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.stepOneProductNameLb.mas_right);
        make.centerY.mas_equalTo(self.stepOnepayTypeTitleLb.mas_centerY);
        make.width.mas_equalTo(ScreenScale(7));
        make.height.mas_equalTo(ScreenScale(11));
    }];
    [self.stepOnepayTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(13);
        make.right.mas_equalTo(self.rightImageV.mas_left).offset(-8);        make.centerY.mas_equalTo(self.stepOnepayTypeTitleLb.mas_centerY);
    }];
    
    [self.stepOneline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.stepOnepayTypeTitleLb.mas_bottom).offset(ScreenScale(16));
        make.left.mas_equalTo(self.stepOneOrderTitle.mas_left);
        make.right.mas_equalTo(self.stepOneProductNameLb.mas_right);
        make.height.mas_equalTo(1);
    }];
    
    [self.nowPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.stepOneline2);
        make.bottom.mas_equalTo(self.stepOneView.mas_bottom).offset(ScreenScale(-17) - SafeAreaBottomHeight);
        make.height.mas_equalTo(ScreenScale(49));
    }];
    
    [self.goStep2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.stepOneline1);
        make.top.mas_equalTo(self.stepOneline1.mas_bottom);
        make.bottom.mas_equalTo(self.stepOneline2.mas_top);
    }];
    
    //view2
    [self.stepTowTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.bottom.mas_equalTo(self.stepTwoView);
    }];
    
    //view3
    [self.passwordInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.stepThreeView);
    }];
    
    
    
    [self layoutIfNeeded];
    [self.showAlertView addCornerWithRoundedRect:self.showAlertView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(ScreenScale(5), ScreenScale(5))];
}

- (UITableView *)stepTowTableView{
    if (!_stepTowTableView) {
        _stepTowTableView = [UITableView new];
        _stepTowTableView.separatorColor = HEX_COLOR(0xF5F5F5);
        _stepTowTableView.separatorInset = UIEdgeInsetsMake(0, ScreenScale(-12), 0, ScreenScale(-12));
        _stepTowTableView.estimatedRowHeight = 50;
        _stepTowTableView.rowHeight = UITableViewAutomaticDimension;
        [_stepTowTableView registerClass:[SXF_HF_payStepTowCel class] forCellReuseIdentifier:NSStringFromClass([SXF_HF_payStepTowCel class])];
    }
    
    return _stepTowTableView;
}






+ (void)showAlertComplete:(void(^__nullable)(BOOL btnBype))complate{
    
    UIWindow *kwin = [UIApplication sharedApplication].keyWindow;
    if (!kwin) {
        kwin =  [UIApplication sharedApplication].windows.lastObject;
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:kwin.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [kwin addSubview:bgView];
    SXF_HF_payStepAleryView *alertView = [[SXF_HF_payStepAleryView alloc] initWithFrame:CGRectMake(0, kwin.bounds.size.height, SCREEN_WIDTH, kwin.bounds.size.height * (2.0 / 3.0))];
    alertView.showAlertView.backgroundColor = [UIColor whiteColor];
    [kwin addSubview:alertView];
    alertView.step = 0;

    
    __weak typeof(alertView)weakAlert = alertView;
    alertView.cancleBtnCallback = ^(NSInteger step) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            switch (step) {
                case 0:{
                    [UIView animateWithDuration:0.2 animations:^{
                        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
                        weakAlert.frame = CGRectMake(0, kwin.bounds.size.height * (1.0 / 3.0), SCREEN_WIDTH, kwin.bounds.size.height * (2.0 / 3.0));
                    } completion:^(BOOL finished) {
                        [bgView removeFromSuperview];
                        [weakAlert removeFromSuperview];
                    }];
                }
                    
                    break;
                case 1:{
                    weakAlert.step = 0;
                    [UIView animateWithDuration:0.2 animations:^{
                        weakAlert.stepTwoView.frame = CGRectMake(weakAlert.stepOneView.frame.size.width, weakAlert.stepOneView.frame.origin.y, weakAlert.stepOneView.frame.size.width, weakAlert.stepOneView.frame.size.height);
                    } completion:^(BOOL finished) {
                        weakAlert.step = 0;
                    }];
                }
                    break;
                case 2:{
                    weakAlert.passwordInputView.editingEable = NO;
                    [UIView animateWithDuration:0.2 animations:^{
                        weakAlert.stepThreeView.frame = CGRectMake(weakAlert.stepOneView.frame.size.width, weakAlert.stepOneView.frame.origin.y, weakAlert.stepOneView.frame.size.width, weakAlert.stepOneView.frame.size.height);
                    } completion:^(BOOL finished) {
                        weakAlert.step = 1;
                    }];
                }
                    break;
                default:
                    break;
            }
        }];
        
        
        
    };
    
    [UIView animateWithDuration:0.2 animations:^{
        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        alertView.frame = CGRectMake(0, kwin.bounds.size.height * (1.0 / 3.0), SCREEN_WIDTH, kwin.bounds.size.height * (2.0 / 3.0));
    }];
    
    
    
    
    //actions
    
    alertView.clickStepOneBtnCallback = ^(NSInteger tag) {
        if (tag == 0) {
            //stepTow
            NSLog(@"step2");
            weakAlert.step = 1;
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [UIView animateWithDuration:0.2 animations:^{
                    weakAlert.stepTwoView.frame = weakAlert.stepOneView.frame;
                }];
            }];
        }else{
            NSLog(@"立即付款");
        }
    };
    
    alertView.clickStepTowCellCallback = ^(NSIndexPath *indexPath) {
        weakAlert.step = 2;
        weakAlert.passwordInputView.editingEable = YES;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIView animateWithDuration:0.2 animations:^{
                NSLog(@"step3");
                weakAlert.stepThreeView.frame = weakAlert.stepOneView.frame;
            }];
        }];
    };
    
}

@end
