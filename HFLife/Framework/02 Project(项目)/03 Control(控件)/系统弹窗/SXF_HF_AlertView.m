//
//  SXF_HF_LoginAlertView.m
//  mytest
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 mac. All rights reserved.
//

#import "SXF_HF_AlertView.h"
//时间选择器
#import "SXF_HF_TimeSelectedView.h"
#import "SXF_HF_leftRightAlert.h"
@interface SXF_HF_AlertView ()
@property (nonatomic, strong)UILabel *titleLb;
@property (nonatomic, strong)UILabel *msgLb;
@property (nonatomic, strong)UIButton *sureBtn;
@property (nonatomic, strong)UIButton *cancleBtn;
@property (nonatomic, strong)UITextView *msgTextV;//注销文字多，文本滑动展示

@property (nonatomic, strong)void(^clickBtn)(BOOL btnType);
@property (nonatomic, strong)SXF_HF_TimeSelectedView *timerAlert;
@property (nonatomic, strong)void(^selecteTime)(NSString *year, NSString *month);

@property (nonatomic, strong)SXF_HF_leftRightAlert *topRightAlertV;
@property (nonatomic, strong)void(^clickTopRightBtn)(NSInteger index);


@property (nonatomic, strong)UIImageView *topImageV;
@end



@implementation SXF_HF_AlertView

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
    self.titleLb      = [UILabel new];
    self.msgLb        = [UILabel new];
    self.sureBtn      = [UIButton new];
    self.cancleBtn    = [UIButton new];
    self.timerAlert   = [SXF_HF_TimeSelectedView new];
    self.topRightAlertV = [SXF_HF_leftRightAlert new];
    self.topImageV    = [UIImageView new];
    
    
    
    [self addSubview:self.titleLb];
    [self addSubview:self.msgLb];
    [self addSubview:self.sureBtn];
    [self addSubview:self.cancleBtn];
    [self addSubview:self.timerAlert];
    [self addSubview:self.topRightAlertV];
    [self addSubview:self.topImageV];
    
    self.msgTextV = [UITextView new];
    [self addSubview:self.msgTextV];
    self.msgTextV.font = FONT(14);
    self.msgTextV.textColor = HEX_COLOR(0x0C0B0B);
    self.msgTextV.editable = NO;
    
    
    
    self.titleLb.font = self.msgLb.font = [UIFont systemFontOfSize:18];
    self.msgLb.font = FONT(14);
    self.msgLb.textColor = HEX_COLOR(0x0C0B0B);
    self.msgLb.numberOfLines = 0;
    self.sureBtn.titleLabel.font = self.cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.sureBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
    [self.cancleBtn setTitleColor:[UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.sureBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)clickBtn:(UIButton *)sender{
    if (sender == self.sureBtn) {
        !self.clickBtn ? : self.clickBtn(YES);
    }else{
        !self.clickBtn ? : self.clickBtn(NO);
    }
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.titleLb.text = title;
    [self configerAlert];
}

- (void)setMsg:(NSString *)msg{
    _msg = msg;
    self.msgLb.text = _msg;
    self.msgTextV.text = _msg;
    [self configerAlert];
}



- (void)setAlertType:(HF_AlertType)alertType{
    _alertType = alertType;
    //更改字体样式
    switch (alertType) {
        case AlertType_login:{
            
        }
        break;
        case AlertType_save:{
            
        }
        break;
        case AlertType_time:{
            
        }
            break;
        default:
            break;
    }
    //配置字体样式
    [self configerAlert];
    //更新布局
    [self layoutSubviews];
}

- (void)configerAlert{
    switch (self.alertType) {
        case AlertType_login:{
            self.titleLb.text = @"是否登录";
            self.msgLb.text = @"此功能需登录才可使用，是否登录？";
            [self.sureBtn setTitle:@"确定" forState:UIControlStateNormal];
            [self.cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
        }
        break;
        case AlertType_save:{
            self.titleLb.text = @"安全提示";
            self.msgLb.text = @"付款后资金将直接进入对方账户，无法退款。为保证安全，请核实对方身份后支付。";
            [self.msgLb setLabelWithLineSpace:6.0];
            [self.sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
        }
            break;
        case AlertType_Pay:{
            self.msgLb.text = @"支付密码不正确。";
            [self.sureBtn setTitle:@"重新输入" forState:UIControlStateNormal];
            [self.cancleBtn setTitle:@"找回并完成支付" forState:UIControlStateNormal];
            [self.sureBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
            [self.cancleBtn setTitleColor:HEX_COLOR(0xCA1400) forState:UIControlStateNormal];
        }
            break;
        case AlertType_time:{
            self.titleLb.hidden = YES;
            self.sureBtn.hidden = YES;
            self.cancleBtn.hidden = YES;
            self.msgLb.hidden = YES;
            
        }
            break;
            
        case AlertType_binding:
        case AlertType_binding_alipay:
        {
            self.titleLb.font = [UIFont systemFontOfSize:15];
            self.titleLb.textColor = colorAAAAAA;
            
            self.msgLb.font = [UIFont systemFontOfSize:15];
            self.msgLb.textColor = color0C0B0B;
            
            self.cancleBtn.backgroundColor = colorCA1400;
            self.sureBtn.backgroundColor = colorAAAAAA;
            self.cancleBtn.setTitleColor([UIColor whiteColor], UIControlStateNormal);
            self.sureBtn.setTitleColor([UIColor whiteColor], UIControlStateNormal);
            self.titleLb.numberOfLines = 0;
            self.msgLb.numberOfLines = 0;
            
            NSString *phone = [userInfoModel sharedUser].member_mobile ? [userInfoModel sharedUser].member_mobile : @"";
            
            //加密手机号
            NSString *secritPhone = [phone EncodeTel];
            
            
            NSString *typeStr = @"微信";
            if (self.alertType == AlertType_binding_alipay) {
                typeStr = @"支付宝";
            }
            NSString *phoneStr = [NSString stringWithFormat:@"您的汉富号%@已与%@关联，是否解除?", secritPhone,typeStr];
            self.titleLb.text = phoneStr;
            [self.titleLb setLabelWithLineSpace:ScreenScale(8)];
            
            NSAttributedString *atrS = [phoneStr setAtrbiuteStringWithFont:FONT(18) color:color0C0B0B range:NSMakeRange(5, secritPhone.length)];
            self.titleLb.attributedText = atrS;
            
            
            self.msgLb.text = [NSString stringWithFormat:@"三十天内只能解绑一次，解除关联后将无法使用%@进行快速登录",typeStr];
            [self.msgLb setLabelWithLineSpace:ScreenScale(8)];
            
            self.cancleBtn.setTitle(@"取消", UIControlStateNormal);
            self.sureBtn.setTitle(@"解除关联", UIControlStateNormal);
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            self.msgLb.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case AlertType_exchnageSuccess:{
            self.titleLb.font = FONT(17);
            self.titleLb.textColor = color0C0B0B;
            self.titleLb.text = self.title;
            self.topImageV.image = MY_IMAHE(@"完成 (3)");
           
        }
            break;
        case AlertType_exchnage:{
            self.titleLb.font = FONT(15);
            self.titleLb.textColor = color0C0B0B;
            self.titleLb.numberOfLines = 0;
            self.titleLb.text = @"一个月只能更换一次手机号";
            self.cancleBtn.setTitleColor(colorCA1400, UIControlStateNormal).setTitleFontSize(15).setTitle(@"我知道了", UIControlStateNormal);
            self.titleLb.textAlignment = NSTextAlignmentCenter;
        }
            break;
        case AlertType_ShopCertification:{
            self.titleLb.font = FONT(14);
            self.titleLb.textColor = color0C0B0B;
            self.cancleBtn.setTitleColor(colorAAAAAA, UIControlStateNormal).setTitleFontSize(14).setTitle(@"取消", UIControlStateNormal);
            self.sureBtn.setTitleColor(colorCA1400, UIControlStateNormal).setTitleFontSize(14).setTitle(@"去认证", UIControlStateNormal);
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            self.titleLb.text = @"您还未实名认证，请先进行实名认证";
        }
            break;

        case AlertType_realyCheck:{
            self.titleLb.font = FONT(14);
            self.titleLb.textColor = color0C0B0B;
            self.cancleBtn.setTitleColor(colorAAAAAA, UIControlStateNormal).setTitleFontSize(14).setTitle(@"取消", UIControlStateNormal);
            self.sureBtn.setTitleColor(colorCA1400, UIControlStateNormal).setTitleFontSize(14).setTitle(@"去认证", UIControlStateNormal);
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            self.titleLb.text = self.title ? self.title : @"使用银行卡前请先进行实名认证";
        }
            break;
        case AlertType_setPassword:{
            //设置密码
            self.cancleBtn.setTitleColor(colorAAAAAA, UIControlStateNormal).setTitleFontSize(14).setTitle(@"取消", UIControlStateNormal);
            self.sureBtn.setTitleColor(colorCA1400, UIControlStateNormal).setTitleFontSize(14).setTitle(@"去设置", UIControlStateNormal);
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            self.titleLb.text = self.title ? self.title : @"您还未设置支付密码";
        }
            break;
        case AlertType_cancellation:{
            self.titleLb.font = FONT(14);
            self.titleLb.textColor = color0C0B0B;
            self.titleLb.textAlignment = NSTextAlignmentCenter;
            self.titleLb.text = [NSString stringWithFormat:@"注销协议"];
            self.msgLb.font = FONT(11);
            self.msgLb.textColor = HEX_COLOR(0x333333);
            self.msgLb.numberOfLines = 0;
            
//            self.msgTextV.text = _msg;
//            self.msgLb.text = self.msg;
            
            self.cancleBtn.setTitleColor(colorCA1400, UIControlStateNormal).setTitleFontSize(14).setTitle(@"我再想想", UIControlStateNormal);
            self.cancleBtn.layer.borderWidth = self.sureBtn.layer.borderWidth = 1.0f;
            self.cancleBtn.layer.borderColor = self.sureBtn.layer.borderColor = [HEX_COLOR(0xE5E5E5) CGColor];
            self.sureBtn.setTitleColor(colorAAAAAA, UIControlStateNormal).setTitleFontSize(14).setTitle(@"确定注销", UIControlStateNormal);
//            self.msgLb.text = self.msg;
            
            [self.msgLb setLabelWithLineSpace:ScreenScale(8)];
        }
            break;
        case AlertType_delete: {
            self.titleLb.text = @"温馨提示";
            self.msgLb.text = @"确认要删除商品吗";
            self.titleLb.font = MyFont(18);
            self.msgLb.font = MyFont(14);
            self.titleLb.textColor = color0C0B0B;
            self.msgLb.textColor = colorAAAAAA;
            self.sureBtn.setTitle(@"确定", UIControlStateNormal).setTitleFontSize(18).setTitleColor([UIColor whiteColor], UIControlStateNormal);
            self.sureBtn.backgroundColor = colorCA1400;
            
            self.cancleBtn.setTitle(@"取消", UIControlStateNormal).setTitleFontSize(18).setTitleColor([UIColor whiteColor], UIControlStateNormal);
            self.cancleBtn.backgroundColor = colorAAAAAA;
            
            self.cancleBtn.layer.cornerRadius = 5;
            self.sureBtn.layer.cornerRadius = 5;
            self.cancleBtn.layer.masksToBounds = self.sureBtn.layer.masksToBounds = YES;

            break;
        }
        case AlertType_logout:{
            self.titleLb.text = @"温馨提示";
            self.msgLb.text = @"您确定要退出登录吗？";
            self.titleLb.font = MyFont(18);
            self.msgLb.font = MyFont(14);
            self.titleLb.textColor = color0C0B0B;
            self.msgLb.textColor = colorAAAAAA;
            self.sureBtn.setTitle(@"确定", UIControlStateNormal).setTitleFontSize(18).setTitleColor([UIColor whiteColor], UIControlStateNormal);
            self.sureBtn.backgroundColor = colorCA1400;
            
            self.cancleBtn.setTitle(@"取消", UIControlStateNormal).setTitleFontSize(18).setTitleColor([UIColor whiteColor], UIControlStateNormal);
            self.cancleBtn.backgroundColor = colorAAAAAA;
            
            self.cancleBtn.layer.cornerRadius = 5;
            self.sureBtn.layer.cornerRadius = 5;
            self.cancleBtn.layer.masksToBounds = self.sureBtn.layer.masksToBounds = YES;
            
        }
            break;
        default:
            break;
    }
    
    [self layoutIfNeeded];
    
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    switch (self.alertType) {
        case AlertType_login:
            [self layoutLogInType];
            break;
         case AlertType_save:
            [self layoutSaveType];
            break;
        case AlertType_Pay:
            [self layoutPayType];
            break;
        case AlertType_time:{
            [self layoutTimeType];
        }
            break;
        case AlertType_topRight:{
            [self layoutTopRightView];
        }
            break;
            
        case AlertType_binding:
        case AlertType_binding_alipay:

        {
            [self layoutBindingView];
        }
            break;
        case AlertType_exchnageSuccess:{
            [self layoutExchangePhoneView];
        }
            break;
        case AlertType_exchnage:{
            [self layoutExchangeAlertView];
        }
            break;
        case AlertType_ShopCertification:
        case AlertType_realyCheck:
        case AlertType_setPassword:
        {
            [self layoutRealyCheck];
        }
            break;
        case AlertType_cancellation:{
            [self layoutCancleView];
        }
            break;
        case AlertType_delete:
        case AlertType_logout:{
            [self layoutLogout];
        }
            break;
        default:
            break;
    }
}


- (void)layoutLogout{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(20));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(ScreenScale(18));
    }];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(30));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.msgLb.mas_bottom).offset(30);
        make.left.mas_equalTo(self.mas_left).offset(30);
        make.height.mas_equalTo(ScreenScale(25));
        make.width.mas_equalTo(ScreenScale(80));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-15));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.cancleBtn.mas_centerY);
        make.right.mas_equalTo(self.mas_right).offset(-30);
        make.height.mas_equalTo(self.cancleBtn);
        make.width.mas_equalTo(self.cancleBtn);
    }];
    
}

//注销
- (void)layoutCancleView{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(20));
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.msgTextV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(22));
        make.left.mas_equalTo(ScreenScale(27));
        make.right.mas_equalTo(ScreenScale(-27));
        make.height.mas_equalTo(SCREEN_HEIGHT * 1 / 2);
        
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.msgTextV.mas_bottom).offset(ScreenScale(22));
        make.bottom.mas_equalTo(self.mas_bottom).offset(1);
        make.left.mas_equalTo(self.mas_left).offset(-1);
        make.height.mas_equalTo(ScreenScale(45));
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
    }];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.sureBtn.mas_right).offset(-1);
        make.bottom.mas_equalTo(self.sureBtn.mas_bottom);
        make.height.mas_equalTo(self.sureBtn.mas_height);
        make.right.mas_equalTo(self.mas_right).offset(1);
    }];
}




//实名认证
- (void)layoutRealyCheck{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-12));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(28));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(ScreenScale(50));
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cancleBtn.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.cancleBtn.mas_height);
    }];
}




//更换成功
- (void)layoutExchangeAlertView{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(12));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-12));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(40));
    }];
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.height.mas_equalTo(ScreenScale(44));
    }];
}
- (void)layoutTopRightView{
    [self.topRightAlertV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
}
//时间选择
- (void)layoutTimeType{
    [self.timerAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
}




//更换成功
- (void)layoutExchangePhoneView{
    [self.topImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX);
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(24));
        make.width.height.mas_equalTo(ScreenScale(50));
    }];
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-25));
        make.centerX.mas_equalTo(self.topImageV.mas_centerX);
    }];
}



/**
  安全提示
 */
- (void)layoutSaveType{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(20));
        make.top.mas_equalTo(self).offset(ScreenScale(20));
        make.height.mas_equalTo(ScreenScale(17));
    }];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(20));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-20));
        make.left.mas_equalTo(self.titleLb.mas_left);
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.msgLb.mas_bottom).offset(ScreenScale(52));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-20));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-20));
        
    }];
}

/**
 登录提醒
 */
- (void) layoutLogInType{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(16));
        make.top.mas_equalTo(self).offset(ScreenScale(31));
        make.height.mas_equalTo(ScreenScale(17));
    }];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLb.mas_bottom).offset(ScreenScale(15));
        make.left.mas_equalTo(self.titleLb.mas_left);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-16));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-31));
        
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_left).offset(ScreenScale(-25));
        make.centerY.mas_equalTo(self.sureBtn.mas_centerY);
        
    }];
    
    [self layoutIfNeeded];
}

/**
 绑定解绑
 */
- (void)layoutBindingView{
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(26));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-27));
        make.top.mas_equalTo(self.mas_top).offset(28);
    }];
    
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.self.titleLb.mas_bottom).offset(24);
        make.left.right.mas_equalTo(self.titleLb);
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.width.mas_equalTo(self.mas_width).multipliedBy(0.5);
        make.height.mas_equalTo(ScreenScale(44));
        make.top.mas_equalTo(self.msgLb.mas_bottom).offset(ScreenScale(29));
    }];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.cancleBtn.mas_right);
        make.right.mas_equalTo(self.mas_right);
        make.bottom.mas_equalTo(self.mas_bottom);
        make.height.mas_equalTo(self.cancleBtn.mas_height);
    }];
}
/**
 支付提示
 */
- (void)layoutPayType{
    [self.msgLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(20));
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(33));
        make.height.mas_equalTo(ScreenScale(13));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-20));
        make.bottom.mas_equalTo(self.mas_bottom).offset(ScreenScale(-21));
    }];
    
    [self.cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.sureBtn.mas_left).offset(ScreenScale(-24));
        make.centerY.mas_equalTo(self.sureBtn.mas_centerY);
    }];
    
}


+ (void) showTimeSlecterAlertComplete:(void(^__nullable)(NSString *year, NSString *month))complate{
    SXF_HF_AlertView * alert = [SXF_HF_AlertView showAlertType:AlertType_time Complete:nil];
    alert.selecteTime = complate;
}


+ (SXF_HF_AlertView *) showAlertType:(HF_AlertType)alertType Complete:(void(^__nullable)(BOOL btnBype))complate{

    UIWindow *kwin = [UIApplication sharedApplication].keyWindow;
    if (!kwin) {
        kwin =  [UIApplication sharedApplication].windows.lastObject;
    }
    
    UIView *bgView = [[UIView alloc] initWithFrame:kwin.bounds];
    bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    [kwin addSubview:bgView];
    
    
    
    
    
    
    SXF_HF_AlertView *alertView = [[SXF_HF_AlertView alloc] init];
    __weak typeof(alertView)weakAlert = alertView;
    [kwin addSubview:alertView];
    alertView.backgroundColor = [UIColor redColor];
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    switch (alertType) {
        case AlertType_login:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(325), ScreenScale(150));
        }
        break;
        case AlertType_save:{
//            alertView.frame = CGRectMake(0, 0, ScreenScale(287), ScreenScale(207));
            
            [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kwin.mas_left).offset(ScreenScale(44));
                make.right.mas_equalTo(kwin.mas_right).offset(ScreenScale(-44));
                make.centerY.mas_equalTo(kwin.mas_centerY);
                make.centerX.mas_equalTo(kwin.mas_centerX);
            }];
            
            
            
        }
        break;
        case AlertType_Pay:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(287), ScreenScale(120));
        }
            break;
        case AlertType_time:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(280), ScreenScale(297));
        }
            break;
        case AlertType_topRight:{
//            alertView.frame = CGRectMake(0, 0, ScreenScale(136), ScreenScale(90));
            [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(kwin.mas_right).offset(ScreenScale(-12));
                make.top.mas_equalTo(kwin.mas_top).offset(ScreenScale(40 + statusBarHeight));
                make.width.mas_equalTo(ScreenScale(136));
                make.height.mas_equalTo(ScreenScale(90));
            }];
            alertView.backgroundColor = [UIColor clearColor];
            
            //给bgView添加点击事件
            [bgView wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    [UIView animateWithDuration:0.2 animations:^{
                        
                    } completion:^(BOOL finished) {
                        [weakAlert removeFromSuperview];
                        [bgView removeFromSuperview];
                    }];
                    
                }];
            }];
        }
            break;
        case AlertType_binding:
        case AlertType_binding_alipay:{
//            alertView.frame = CGRectMake(0, 0, ScreenScale(280), ScreenScale(227));
            [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(kwin.mas_centerX);
                make.centerY.mas_equalTo(kwin.mas_centerY);
                make.width.mas_equalTo(ScreenScale(280));
            }];
        }
            break;
        case AlertType_exchnageSuccess:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(121), ScreenScale(134));
            //2秒后自动销毁
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                   
                    [UIView animateWithDuration:0.1 animations:^{
                        weakAlert.alpha = 0.0;
                        bgView.alpha = 0.0;
                    } completion:^(BOOL finished) {
                        [bgView removeFromSuperview];
                        [weakAlert removeFromSuperview];
                    }];
                });
            }];
        }
            break;
        case AlertType_exchnage:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(280), ScreenScale(121));
        }
            break;
        case AlertType_setPassword:
        case AlertType_ShopCertification:
        case AlertType_realyCheck:{
            alertView.frame = CGRectMake(0, 0, ScreenScale(280), ScreenScale(119));
        }
            break;
        case AlertType_cancellation:{
            [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kwin.mas_left).offset(ScreenScale(25));
                make.right.mas_equalTo(kwin.mas_right).offset(ScreenScale(-25));
                make.centerY.mas_equalTo(kwin.mas_centerY);
                make.centerX.mas_equalTo(kwin.mas_centerX);
            }];
        }
            break;
        case AlertType_delete:
        case AlertType_logout:{
            [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(kwin.mas_left).offset(ScreenScale(45));
                make.right.mas_equalTo(kwin.mas_right).offset(ScreenScale(-45));
                make.centerY.mas_equalTo(kwin.mas_centerY);
                make.centerX.mas_equalTo(kwin.mas_centerX);
            }];
            
        }
            break;
        default:
            break;
    }
    alertView.alertType = alertType;
    [alertView layoutIfNeeded];
    
    
    if (alertType == AlertType_topRight) {
        bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        alertView.center = CGPointMake(CGRectGetMaxX(alertView.frame), CGRectGetMinY(alertView.frame));
        
        [UIView animateWithDuration:0.2 animations:^{
            bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
            alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            alertView.center = CGPointMake(CGRectGetMaxX(alertView.frame) - ScreenScale(136) * 0.5, CGRectGetMaxX(alertView.frame) - ScreenScale(90) * 0.5);
        } completion:^(BOOL finished) {
            
        }];
    }else{
        alertView.center = bgView.center;
        alertView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [UIView animateWithDuration:0.2 animations:^{
            bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
            alertView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.1 animations:^{
                alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                bgView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.7];
            }];
        }];
    }
    
    
    
    
    
    alertView.clickBtn = ^(BOOL btnType) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIView animateWithDuration:0.2 animations:^{
                
                weakAlert.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
                weakAlert.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {
                if (complate) {
                    complate(btnType);
                    if (weakAlert.alertType == AlertType_login) {
                        if (btnType) {
                            //跳转登录
                            
                            Class loginClass = NSClassFromString(@"LoginVC");
                            id loginVC = [[loginClass alloc] init];
                            if (loginVC) {
                                UIViewController *currentVC = [self getCurrentViewController];
                                BaseNavigationController *navi = [[BaseNavigationController alloc] initWithRootViewController:loginVC];
                                [currentVC presentViewController:navi animated:YES completion:nil];
                            }else{
                                
                                [CustomPromptBox showTextHud:@"您还未创建登录VC"];
                            }
                        }
                    }
                }
                [weakAlert removeFromSuperview];
                [bgView removeFromSuperview];
            }];
        }];
        
    };
    
    alertView.timerAlert.confirmBtnCallback = ^(NSString * _Nonnull year, NSString * _Nonnull month) {
        !weakAlert.selecteTime ? : weakAlert.selecteTime(year, month);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIView animateWithDuration:0.2 animations:^{
                
                weakAlert.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
                weakAlert.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:^(BOOL finished) {

                [weakAlert removeFromSuperview];
                [bgView removeFromSuperview];
            }];
                
        }];
        
        
    };
    
    alertView.topRightAlertV.clickAlertBtn = ^(NSInteger index) {
        complate(index);
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [UIView animateWithDuration:0.2 animations:^{
                
            } completion:^(BOOL finished) {
                
                [weakAlert removeFromSuperview];
                [bgView removeFromSuperview];
            }];
            
        }];
    };
    return alertView;
}








@end
