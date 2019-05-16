//
//  SXF_HF_KeyBoardView.m
//  HFLife
//
//  Created by mac on 2019/5/15.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_KeyBoardView.h"
#import "SXF_HF_Password.h"
#import "APNumberPad.h"
@interface SXF_HF_KeyBoardView()<APNumberPadDelegate>

@property (nonatomic, strong)SXF_HF_Password *passwordInputView;
@property (nonatomic, strong)APNumberPad *pad;
@end


@implementation SXF_HF_KeyBoardView


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
    
    //初始化键盘
    APNumberPad *pad = [APNumberPad numberPadWithDelegate:self numberPadStyleClass:[APNumberPadDefaultStyle class]];
    
//    [self addSubview:pad];
    
    
    self.passwordInputView = [[SXF_HF_Password alloc] initWithFrame:CGRectMake(ScreenScale(12), ScreenScale(25), SCREEN_WIDTH - ScreenScale(24), ScreenScale(49))];
    [self addSubview:self.passwordInputView];
    
    self.msgLb = [UILabel new];
    self.msgLb.frame = CGRectMake(0, CGRectGetMaxY(self.passwordInputView.frame) + ScreenScale(24), SCREEN_WIDTH, 15);
    self.msgLb.text = @"忘记密码？找回并完成支付";
    self.msgLb.font = [UIFont systemFontOfSize:14];
    self.msgLb.textColor = HEX_COLOR(0xCA1400);
    self.msgLb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.msgLb];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.pad mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self);
        make.height.mas_equalTo(ScreenScale(224));
    }];
}


@end
