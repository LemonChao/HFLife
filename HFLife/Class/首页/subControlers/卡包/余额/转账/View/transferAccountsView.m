//
//  transferAccountsView.m
//  HFLife
//
//  Created by sxf on 2019/4/16.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "transferAccountsView.h"
#import "UITextField+RYNumberKeyboard.h"
#import "HHPayPasswordView.h"
#import "IQKeyboardManager.h"
@interface transferAccountsView ()
{
    UIImageView *_headImageView;
    //姓名
    UILabel *_nameLabel;
	//手机号
    UILabel *_phoneLabel;
//    金额
    UITextField *textField;
     //备注
    UITextField *_remarkTextField;
    // 是否同意转账协议
    UIButton *agreeBtn;
    //确认转账
    UIButton *_nextButton;
}
@end

@implementation transferAccountsView
-(instancetype)init{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initWithUI];
    }
    return self;
}
-(void)initWithUI{
    UIImageView *headImageView = [UIImageView new];
    headImageView.backgroundColor = [UIColor yellowColor];
    [self addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(21));
        make.top.mas_equalTo(self.mas_top).offset(HeightRatio(40));
        make.width.height.mas_equalTo(WidthRatio(104));
    }];
    MMViewBorderRadius(headImageView, WidthRatio(104)/2, 0, [UIColor clearColor]);
    _headImageView = headImageView;
    
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    _nameLabel.textColor = HEX_COLOR(0x000000);
    [self addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImageView.mas_right).offset(WidthRatio(40));
        make.top.mas_equalTo(headImageView.mas_top).offset(HeightRatio(19));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    _phoneLabel = [UILabel new];
    _phoneLabel.font = [UIFont systemFontOfSize:WidthRatio(30)];
    _phoneLabel.textColor = HEX_COLOR(0x000000);
    [self addSubview:_phoneLabel];
    [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headImageView.mas_right).offset(WidthRatio(40));
        make.top.mas_equalTo(self->_nameLabel.mas_bottom).offset(HeightRatio(16));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
    }];
    
    UILabel *title_label = [UILabel new];
    title_label.text = @"转账金额";
    title_label.font = [UIFont systemFontOfSize:WidthRatio(27)];
    title_label.textColor = HEX_COLOR(0x3e3e3e);
    [self addSubview:title_label];
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(20));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(headImageView.mas_bottom).offset(HeightRatio(60));
    }];
    
    UILabel *icon_label = [UILabel new];
    icon_label.text = @"¥";
    icon_label.font = [UIFont systemFontOfSize:WidthRatio(72)];
    icon_label.textColor = [UIColor blackColor];
    [self addSubview:icon_label];
    [icon_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(31));
        make.width.mas_greaterThanOrEqualTo(1);
        make.height.mas_greaterThanOrEqualTo(1);
        make.top.mas_equalTo(title_label.mas_bottom).offset(HeightRatio(49));
    }];
    
    textField = [UITextField new];
    textField.ry_inputType = RYFloatInputType;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    textField.textColor = [UIColor blackColor];
    textField.font = [UIFont systemFontOfSize:WidthRatio(83)];
    textField.textAlignment = NSTextAlignmentLeft;
//    textField.delegate = self;
//    textField.ry_interval = 6;
     [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(80));
        make.centerY.mas_equalTo(icon_label.mas_centerY);
        make.height.mas_equalTo(HeightRatio(110));
        make.right.mas_equalTo(self.mas_right).offset(-WidthRatio(31));
    }];
    
    UILabel *lin = [UILabel new];
    lin.backgroundColor = HEX_COLOR(0xE1E1E1);
    [self addSubview:lin];
    [lin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self->textField.mas_bottom);
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.mas_right).offset(-WidthRatio(20));
        make.height.mas_equalTo(1);
    }];
    
    _remarkTextField = [[UITextField alloc]init];
    _remarkTextField.clearButtonMode = UITextFieldViewModeAlways;
    _remarkTextField.font = [UIFont systemFontOfSize:WidthRatio(24)];
    _remarkTextField.placeholder = @"添加备注（50字以内）";
    [_remarkTextField setValue:HEX_COLOR(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
    [self addSubview:_remarkTextField];
    [_remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(20));
        make.right.mas_equalTo(self.mas_right).offset(-WidthRatio(20));
        make.top.mas_equalTo(lin.mas_bottom);
        make.height.mas_equalTo(HeightRatio(70));
    }];
    
    agreeBtn = [UIButton new];
    agreeBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
    [agreeBtn setTitleColor:HEX_COLOR(0xAAAAAA) forState:(UIControlStateNormal)];
    [agreeBtn setImagePosition:ImagePositionTypeLeft spacing:WidthRatio(22)];
    [agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [agreeBtn setTitle:@"已阅读并同意" forState:(UIControlStateNormal)];
    [agreeBtn setImage:MMGetImage(@"gouxuan") forState:(UIControlStateNormal)];
    [agreeBtn setImage:MMGetImage(@"gouxuan1") forState:(UIControlStateSelected)];
    [self addSubview:agreeBtn];
    [agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(20));
        make.top.mas_equalTo(lin.mas_bottom).offset(HeightRatio(135));
        make.height.mas_equalTo(HeightRatio(24));
        make.width.mas_equalTo(WidthRatio(220));
//        make.width.mas_greaterThanOrEqualTo(1);
    }];
    
    UIButton *agreementBtn =  [UIButton new];
    agreementBtn.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(24)];
//    [agreementBtn addTarget:self action:@selector(agreementBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    [agreementBtn setTitleColor:HEX_COLOR(0x2285EB) forState:(UIControlStateNormal)];
    [agreementBtn setTitle:@"《转账服务条款》" forState:(UIControlStateNormal)];
    [self addSubview:agreementBtn];
    [agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self->agreeBtn.mas_right);
        make.top.mas_equalTo(self->agreeBtn.mas_top);
        make.height.mas_equalTo(HeightRatio(24));
//        make.width.mas_equalTo(WidthRatio(270));
        make.width.mas_greaterThanOrEqualTo(1);
    }];

    
    UIButton *nextButton = [UIButton new];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:WidthRatio(36)];
    nextButton.backgroundColor = HEX_COLOR(0x91C4F8);
    [nextButton setTitleColor:HEX_COLOR(0xC8E3FE) forState:(UIControlStateNormal)];
    [nextButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateSelected)];
    [nextButton setTitle:@"确认转账" forState:(UIControlStateNormal)];
    [nextButton addTarget:self action:@selector(nextButtonClick) forControlEvents:(UIControlEventTouchUpInside)];
    nextButton.userInteractionEnabled = NO;
    [self addSubview:nextButton];
    [nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(WidthRatio(18));
        make.right.mas_equalTo(self.mas_right).offset(-WidthRatio(18));
        make.top.mas_equalTo(lin.mas_bottom).offset(HeightRatio(189));
        make.height.mas_equalTo(HeightRatio(84));
    }];
    _nextButton = nextButton;
}
- (void) textFieldDidChange:(id) sender {
    
    UITextField *_field = (UITextField *)sender;
    _nextButton.selected = _field.text.length>0;
    _nextButton.userInteractionEnabled = _field.text.length>0;
    _nextButton.backgroundColor = _field.text.length>0 ? HEX_COLOR(0x2285EB):HEX_COLOR(0x91C4F8);
    
}
-(void)agreeBtnClick{
    agreeBtn.selected = !agreeBtn.selected;
}
-(void)nextButtonClick{
    if (agreeBtn.selected) {
        if (self.transferAccountsClick) {
            self.transferAccountsClick([NSString judgeNullReturnString:textField.text], [NSString judgeNullReturnString:_remarkTextField.text]);
        }
    }else{
        [WXZTipView showCenterWithText:@"您未同意转账协议，暂时无法转账"];
    }
}
-(void)setUserDict:(NSDictionary *)userDict{
    _userDict = userDict;
    _nameLabel.text = [NSString judgeNullReturnString:_userDict[@"member_truename"]];
    _phoneLabel.text = [NSString judgeNullReturnString:_userDict[@"member_mobile"]];
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:[NSString judgeNullReturnString:_userDict[@"member_avatar"]]] placeholderImage:MMGetImage(@"barCode_icon")];
}
@end
