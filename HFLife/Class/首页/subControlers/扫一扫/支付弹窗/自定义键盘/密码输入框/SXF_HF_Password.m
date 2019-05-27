//
//  Password.m
//  Password
//
//  Created by ZAREMYDREAM on 2017/12/15.
//  Copyright © 2017年 Devil. All rights reserved.
//

#import "SXF_HF_Password.h"
#import "APNumberPad.h"
@interface SXF_HF_Password()<UITextFieldDelegate, APNumberPadDelegate>

@property(nonatomic,strong)UITextField *pswTF;

@property (nonatomic, strong)NSMutableArray *imageVArrM;
@property (nonatomic, assign)BOOL isComplate;//输入完成 回调一次
@end

@implementation SXF_HF_Password
#pragma mark - 懒加载
- (UITextField *)pswTF{
    if (!_pswTF) {
        _pswTF = [[UITextField alloc] init];
        
        _pswTF.delegate = self;
        
        _pswTF.keyboardType = UIKeyboardTypeNumberPad;
        
        //添加对输入值的监视
        [_pswTF addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventEditingChanged];
        
       
    }
    
    return _pswTF;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initUI];
        self.imageVArrM = [NSMutableArray array];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
        
        [self addGestureRecognizer:tap];
    }
    
    return self;
}

#pragma mark - 设置UI
- (void)initUI{
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *keyBoard = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 224)];
    keyBoard.backgroundColor = [UIColor redColor];
//    self.pswTF.inputAccessoryView = keyBoard;
    self.pswTF.inputView = [UIView new];
    
    
    APNumberPad *pad = [APNumberPad numberPadWithDelegate:self];
    pad.frame = CGRectMake(0, 0, SCREEN_WIDTH, ScreenScale(224));
    self.pswTF.inputAccessoryView = pad;
    
    [self addSubview:self.pswTF];
    
    for (int i = 0; i < 6; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*self.frame.size.width/6.0, 0, self.frame.size.width/6.0, self.frame.size.height)];
        label.font = [UIFont systemFontOfSize:1];
        label.textAlignment = NSTextAlignmentCenter;
        
        label.tag = 100 + i;
        
        UIImageView *yuandian = [[UIImageView alloc] init];
        yuandian.image = [UIImage imageNamed:@"yuandian"];
        yuandian.tag = 1000 + i;
        [self.imageVArrM addObject:yuandian];
        yuandian.hidden = YES;
        yuandian.frame = CGRectMake(0, 0, 15, 15);
        yuandian.center = label.center;
        [self addSubview:label];
        [self addSubview:yuandian];
    }
    
    //设置边框圆角与颜色
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 5.0;
    self.layer.borderColor = [UIColor colorWithRed:248.0/255.0 green:248.0/255.0 blue:248.0/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 1;
}

//划线
- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1);
    
    //设置分割线颜色
    CGContextSetRGBStrokeColor(context, 238.0/255.0, 238.0/255.0, 238.0/255.0, 1);
    
    CGContextBeginPath(context);
    
    for (int i = 0; i < 5;  i++){
        CGContextMoveToPoint(context, self.frame.size.width/6.0 * (i + 1), 0);
        CGContextAddLineToPoint(context,self.frame.size.width/6.0 * (i + 1) , self.frame.size.height);
    }
    
    CGContextStrokePath(context);
    
}

#pragma mark - 监视textField值
- (void)valueChange:(UITextField *)textField{
    NSString *text = textField.text;
    if (text.length <= 6){
        for (int i = 0; i < 6; i++) {
            UILabel *label = (UILabel *)[self viewWithTag:100 + i];
            UIImageView *imageV = (UIImageView *)[self viewWithTag:1000 + i];
            if (i < text.length) {
                label.text = @"·";
                imageV.hidden = NO;
            }
            else{
                label.text = @"";
                imageV.hidden = YES;
            }
        }
        if (text.length == 6) {
            //回调
            !self.keyBoardCallback ? : self.keyBoardCallback(textField.text);
            [self.pswTF endEditing:YES];
            self.isComplate = YES;
        }
    }
    else{
        //填满之后 主动关闭键盘 并给回调出去
        
        if (!self.isComplate) {
            textField.text = [text substringWithRange:NSMakeRange(0, 6)];
            
        }
    }
    
}
- (void)setEditingEable:(BOOL)editingEable{
    _editingEable = editingEable;
    if (editingEable) {
        [self.pswTF becomeFirstResponder];
    }else{
        [self.pswTF endEditing:_editingEable];
        //清空数据
        self.pswTF.text = @"";
        [self valueChange:self.pswTF];
    }
}
#pragma mark - 点击view开始输入
- (void)click{
    [self.pswTF becomeFirstResponder];
}

#pragma mark - 关闭键盘
- (void)closeKeyborad{
    [self.pswTF resignFirstResponder];
}
@end
