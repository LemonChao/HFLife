//
//  RemarkBallView.m
//  HFLife
//
//  Created by sxf on 2019/4/18.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "RemarkBallView.h"
#import "UITextView+ZWPlaceHolder.h"
//#import "AddBillRemarkNetAPi.h"
#define ALERTVIEW_HEIGHT [UIScreen mainScreen].bounds.size.height/5
#define MARGIN  20
@interface RemarkBallView()

@property(nonatomic,strong)UIView *alertView;
@property (nonatomic, strong) UITextView *textView;

@end
@implementation RemarkBallView{
    
}
-(id)init{
    self = [super init];
    if (self) {
//        [self initWithUI];
    }
    return self;
}

-(instancetype) initWithTitleImage:(NSString *)backImage messageTitle:(NSString *)titleStr messageString:(NSString *)contentStr sureBtnTitle:(NSString *)titleString sureBtnColor:(UIColor *)BtnColor{
    
    self = [super init];
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        self.alertView = [[UIView alloc]initWithFrame:CGRectMake(35, SCREEN_HEIGHT/2-ALERTVIEW_HEIGHT/2, SCREEN_WIDTH/1.5, ALERTVIEW_HEIGHT+40)];
            //        self.alertView.mj_centerX = SCREEN_WIDTH/2. + 35*SCALE;
        self.alertView.backgroundColor = [UIColor whiteColor];
        self.alertView.layer.cornerRadius=5.0;
        self.alertView.layer.masksToBounds=YES;
        self.alertView.userInteractionEnabled=YES;
        [self addSubview:self.alertView];
        self.alertView.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        [self addObservers];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        
        if (![NSString isNOTNull:backImage]) {
            UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake((self.alertView.frame.size.width/2)-35, 15, 70, 70)];
            titleImage.image = [UIImage imageNamed:backImage];
            [self.alertView addSubview:titleImage];
        }
        if (titleStr) {
            UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(MARGIN, 5, self.alertView.frame.size.width-40, 30)];
            titleLab.text = titleStr;
            titleLab.font = [UIFont systemFontOfSize:14];
            titleLab.textAlignment = NSTextAlignmentLeft;
            [self.alertView addSubview:titleLab];
        }
        if (contentStr) {
            UITextView *contentLab = [[UITextView alloc]initWithFrame:CGRectMake(MARGIN, 35, self.alertView.frame.size.width-40, self.alertView.frame.size.height - 90)];
            contentLab.text = contentStr;
            contentLab.font = [UIFont systemFontOfSize:13];
            contentLab.textAlignment = NSTextAlignmentLeft;
            contentLab.textColor = [UIColor lightGrayColor];
            contentLab.zw_placeHolder = @"输入备注";
            contentLab.backgroundColor = [UIColor clearColor];
            [self.alertView addSubview:contentLab];
            _textView = contentLab;
        }
        
        UIButton *cancelBtn= [[UIButton alloc]initWithFrame:CGRectMake(10, self.alertView.frame.size.height - 45, self.alertView.frame.size.width/3., 35)];
        [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        [cancelBtn setBackgroundColor:HEX_COLOR(0xd0dbdf)];
        cancelBtn.centerX = self.alertView.width/4.;
        cancelBtn.layer.cornerRadius=3.0;
        cancelBtn.layer.masksToBounds=YES;
        [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.alertView addSubview:cancelBtn];
        if (titleString) {
            UIButton *sureBtn= [[UIButton alloc]initWithFrame:CGRectMake(self.alertView.frame.size.width/2., cancelBtn.ly_y, cancelBtn.width, cancelBtn.height)];
            sureBtn.centerX = self.alertView.width/2. + self.alertView.width/4.;
            [sureBtn setTitle:titleString forState:UIControlStateNormal];
            [sureBtn setBackgroundColor:HEX_COLOR(0x1ab493)];
            sureBtn.layer.cornerRadius=3.0;
            sureBtn.layer.masksToBounds=YES;
            [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sureBtn addTarget:self action:@selector(SureClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.alertView addSubview:sureBtn];
        }
        
        
    }
    [self showAnimation];
    return self;
}
- (void)addObservers{
    
        //监听当键盘将要出现时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
        //监听当键将要退出时
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
- (void)keyboardWillShow:(NSNotification *)notif{
    
        //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    CGFloat height = keyboardRect.size.height;
    CGFloat bgMaxY = CGRectGetMaxY(self.alertView.frame);
    CGFloat allH = height + bgMaxY;
    
    CGFloat subHeight = allH - (self.height)+10;//10为缓冲距离
    
        //获取键盘动画时长
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
        //键盘遮挡才需上移
    if(subHeight>0){
        [UIView animateWithDuration:dutation animations:^{
            self.alertView.transform = CGAffineTransformMakeTranslation(0, - subHeight);
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notif{
        //获取键盘的高度
    NSDictionary *userInfo = [notif userInfo];
    CGFloat dutation = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:dutation animations:^{
        self.alertView.transform = CGAffineTransformIdentity;
    }];
}
-(void)showAnimation{
    
    self.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    CGAffineTransform transform = CGAffineTransformScale(CGAffineTransformIdentity,1.0,1.0);
    
    self.alertView.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.2,0.2);
    self.alertView.alpha = 0;
    [UIView animateWithDuration:0.2 delay:0.1 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.4f];
        self.alertView.transform = transform;
        self.alertView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}

-(void)SureClick:(UIButton *)sender{
    
    if (self.sureClick) {
        self.sureClick(_textView.text);
    }
    if (_textView.text.length>0&&![NSString isNOTNull:self.billID]) {
        
        /*
        
        AddBillRemarkNetAPi *add = [[AddBillRemarkNetAPi alloc]initWithParameter:@{@"id":self.billID,@"tag_remark":_textView.text}];
        [add startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            AddBillRemarkNetAPi *addRequest = (AddBillRemarkNetAPi *)request;
            [WXZTipView showCenterWithText:[addRequest getMsg]];
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            [WXZTipView showCenterWithText:@"备注添加失败"];
        }];
         
         */
    }
    [UIView animateWithDuration:0.3 animations:^{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
        [self removeFromSuperview];
    }];
}

- (void)cancelClick:(UIButton *)sender{
    
    [UIView animateWithDuration:0.3 animations:^{
        [self removeFromSuperview];
    }];
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    [self endEditing:YES];
    
}

//-(void)withSureClick:(sureBlock)block{
//    _sureClick = block;
//}
@end
