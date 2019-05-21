//
//  YYB_HF_SexChoiceView.m
//  HFLife
//
//  Created by mac on 2019/5/21.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_SexChoiceView.h"

@interface YYB_HF_SexChoiceView()
@property(nonatomic, strong) UIButton *button1;//男
@property(nonatomic, strong) UIButton *button2;//男

@end

@implementation YYB_HF_SexChoiceView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpVeiw];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
 
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpVeiw];
    }
    return self;
}

- (void)setSex:(NSString *)sex {
    if ([sex isEqualToString:@"男"]) {
        [self.button1 setSelected:YES];
    }
    if ([sex isEqualToString:@"女"]) {
        [self.button2 setSelected:YES];
    }
}

- (void)setUpVeiw {
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.7];
    [self wh_addTapActionWithBlock:^(UITapGestureRecognizer *gestureRecoginzer) {
        [self removeFromSuperview];
    }];
    UIButton *view = [UIButton new];
    view.userInteractionEnabled = YES;
    view.clipsToBounds = YES;
    view.layer.cornerRadius = 5;
    view.setBackgroundColor([UIColor whiteColor]);
    [self addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(ScreenScale(300));
        make.height.mas_equalTo(ScreenScale(250));
        make.center.mas_equalTo(self);
    }];
    
    UILabel *titleLabel = [UILabel new];
    UILabel *nan = [UILabel new];
    UILabel *nv = [UILabel new];
    UIButton *sexbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *sexbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [view addSubview:titleLabel];
    [view addSubview:nan];
    [view addSubview:nv];
    [view addSubview:sexbtn1];
    [view addSubview:sexbtn2];
    
    titleLabel.setText(@"性别").setTextColor([UIColor blackColor]).setFontSize(17);

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(30);
        make.centerX.mas_equalTo(view);
        make.height.mas_equalTo(17);
    }];
    
    nan.setText(@"男").setTextColor([UIColor blackColor]).setFontSize(17);
    [nan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(85);
        make.left.mas_equalTo(view).mas_offset(ScreenScale(33));
        make.height.mas_equalTo(17);
    }];
    
    nv.setText(@"女").setTextColor([UIColor blackColor]).setFontSize(17);
    [nv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(view).mas_offset(139);
        make.left.mas_equalTo(view).mas_offset(ScreenScale(33));
        make.height.mas_equalTo(17);
    }];
    
    sexbtn1.setImage([UIImage imageNamed:@"icon_unSel"],UIControlStateNormal).setBackgroundColor([UIColor clearColor]).setImage([UIImage imageNamed:@"icon_sel"],UIControlStateSelected).addAction(^{
        NSDictionary *parm = @{@"field":@"member_sex",@"value":@"1"};
        [self reqData:parm];
        [self removeFromSuperview];
    });
    
    [sexbtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nan);
        make.right.mas_equalTo(view).mas_offset(-33);
        make.width.height.mas_equalTo(ScreenScale(25));
    }];
    
    sexbtn2.setImage([UIImage imageNamed:@"icon_unSel"],UIControlStateNormal).setBackgroundColor([UIColor clearColor]).setImage([UIImage imageNamed:@"icon_sel"],UIControlStateSelected).addAction(^{
        NSDictionary *parm = @{@"field":@"member_sex",@"value":@"2"};
        [self reqData:parm];
        [self removeFromSuperview];
    });
    
    [sexbtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(nv);
        make.right.mas_equalTo(view).mas_offset(-33);
        make.width.height.mas_equalTo(ScreenScale(25));
    }];
    
    self.button1 = sexbtn1;
    self.button2 = sexbtn2;
    
}

- (void)reqData:(NSDictionary *)parm {
    [networkingManagerTool requestToServerWithType:POST withSubUrl:kSaveMemberBase withParameters:parm withResultBlock:^(BOOL result, id value) {
        if (result) {
            //保存到单例
            [userInfoModel sharedUser].member_sex = parm[@"value"];
            if (self.selectSexBlock) {//回调显示
                if ([parm[@"value"] isEqualToString:@"1"]) {
                    self.selectSexBlock(@"男");
                }else {
                    self.selectSexBlock(@"女");
                }
            }
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dataDic = value[@"data"];
                NSString *token = [dataDic safeObjectForKey:@"ucenter_token"];
                if (token && token.length > 0) {
                    [[NSUserDefaults standardUserDefaults] setValue:token forKey:USER_TOKEN];
                }else {
                    [WXZTipView showCenterWithText:@"资料修改成功,token获取x失败"];
                }
            }
            
        }else {
            if (value && [value isKindOfClass:[NSDictionary class]]) {
                [WXZTipView showCenterWithText:value[@"msg"]];
            }else {
                [WXZTipView showCenterWithText:@"网络x错误"];
            }
        }
    }];
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (gestureRecognizer.view == self) {
        return YES;
    }
    return NO;
}



- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
