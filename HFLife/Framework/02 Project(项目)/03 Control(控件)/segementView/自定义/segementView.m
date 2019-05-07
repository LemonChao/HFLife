
//
//  segementView.m
//  ttttttttt
//
//  Created by mini on 2017/12/25.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "segementView.h"
#define ColorContentTextBlack   [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0]
#define LineColor               [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0]


#define headerHeight 48
@interface segementView ()<UIScrollViewDelegate>

{
//    UIView *_lineView;
    
    NSArray *_menuArr;
    NSArray *_classArr;
    NSMutableArray *_controllerArr;
    UIButton *_selectedBtn;
    UIButton *lastBtn;
    CGRect _lineViewFrame;
    NSMutableArray *_btnArrM;
    
}


@end
    


@implementation segementView


- (instancetype)initWithFrame:(CGRect)frame withMenuArr:(NSArray *)menuaArr withClassArr:(NSArray <UIViewController *>*)classArr{
    
    _controllerArr = [NSMutableArray array];
    _btnArrM = [NSMutableArray array];
    _menuArr = menuaArr;
    _classArr = classArr;
    //默认有动画 0.3s
    self.duration = 0.3;
    if (menuaArr.count != classArr.count)
    {
        NSLog(@"!!!警告---数组不匹配");
        return self;
    }
    if (self = [super initWithFrame:frame])
    {
        for (int i = 0; i < classArr.count; i++)
        {
            UIViewController * controller = classArr[i];
            [_controllerArr addObject:controller];
        }
        
        [self addChildrens];
    }
    
    //添加通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gonext:) name:@"NEXT" object:nil];
    return self;
}




- (void) addChildrens{
    
    CGFloat With = [UIScreen mainScreen].bounds.size.width/_menuArr.count;
    for (int i = 0; i<_menuArr.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0 + With * i, 0, With, headerHeight);
        [button setTitle:_menuArr[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        if (i == 0) {
            button.selected = YES;
            _selectedBtn = button;
        }
        NSLog(@"---%@" , button.titleLabel.text);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:ColorContentTextBlack forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"个人资料-切换.png"] forState:UIControlStateSelected];
        button.userInteractionEnabled = NO;
        [self addSubview:button];
        [_btnArrM addObject:button];
        
        
    }
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headerHeight - 2, With, 2)];
    _lineView.backgroundColor = [UIColor blackColor];
    [self addSubview:_lineView];
    
    
    [self creatScrollView];
    
}





- (void) creatScrollView{
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, headerHeight , self.frame.size.width, self.frame.size.height - headerHeight)];
    _scrollView.contentSize = CGSizeMake( self.frame.size.width * _menuArr.count , self.frame.size.height - headerHeight);
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    for (int i = 0; i < _controllerArr.count; i++) {
        UIViewController *vc = _controllerArr[i];
        vc.view.frame = CGRectMake(_scrollView.frame.size.width * i, 0, _scrollView.frame.size.width , _scrollView.frame.size.height);
        [_scrollView addSubview:vc.view];
        NSLog(@"class------%@" , [vc class]);
    }
    
    
    
    [self addSubview:_scrollView];
}

- (void) btnClick:(UIButton *)sender{
    //通过title获取是哪个按钮
    
    NSLog(@"选的是---%@" , sender.titleLabel.text);
    sender.selected = YES;
    _selectedBtn.selected = NO;
    
    
//    [sender setTitleColor:sender.selected ? [UIColor blackColor] : [UIColor whiteColor] forState:UIControlStateNormal];
//    [_selectedBtn setTitleColor:_selectedBtn.selected ? [UIColor blackColor] : [UIColor whiteColor] forState:UIControlStateNormal];
    NSInteger index = [_menuArr indexOfObject:sender.titleLabel.text];
    [UIView animateWithDuration:self.duration animations:^{
        _scrollView.contentOffset = CGPointMake(self.frame.size.width * index, 0);
        _lineView.frame =CGRectMake([UIScreen mainScreen].bounds.size.width/_menuArr.count * index, headerHeight - 2, [UIScreen mainScreen].bounds.size.width/_menuArr.count, 2);
    } completion:^(BOOL finished) {
        _lineViewFrame = _lineView.frame;
    }];
    
    
    _selectedBtn = sender;
    _selectedBtn.selected = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"contentOffset.x ===== %lf" , scrollView.contentOffset.x);
    _lineView.frame = CGRectMake(scrollView.contentOffset.x / _menuArr.count, headerHeight - 2, [UIScreen mainScreen].bounds.size.width/_menuArr.count, 2);
    
    //字体颜色渐变
    int num1 = scrollView.contentOffset.x / self.frame.size.width;
    double num2 = scrollView.contentOffset.x / self.frame.size.width;
    double offset = num2 - num1;
    
    
    
    //通过下表 取按钮
    
//    [_selectedBtn setTitleColor:[UIColor colorWithRed:1 * offset green:1.0 blue:1.0 alpha:1.0] forState:UIControlStateNormal];
//    NSInteger index = [_btnArrM indexOfObject:_selectedBtn];
//    if (scrollView.contentOffset.x > 0 || scrollView.contentOffset.x < self.frame.size.width * _menuArr.count)
//    {
////        UIButton *btn = [_btnArrM objectAtIndex:index + 1];
////        [btn setTitleColor:[UIColor colorWithRed:1 * (1-offset) green:1 blue:1 alpha:1.0] forState:UIControlStateNormal];
//    }
    
    
    
    
    
    NSLog(@"%d------%lf-----%lf" ,num1 , num2 , offset);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"结束滑动-----%lf" , scrollView.contentOffset.x);
    
    NSInteger index = scrollView.contentOffset.x / self.frame.size.width;
    NSLog(@"--)))))%ld" , (long)index);
    UIButton *btn = [_btnArrM objectAtIndex:index];
    _selectedBtn.selected = NO;
    _selectedBtn = btn;
    _selectedBtn.selected = YES;
}




- (void) gonext:(NSNotification *)notification{
    NSLog(@"%@" , notification.object);
    UIButton *selectedBtn;
    NSInteger index = [notification.object integerValue];
    selectedBtn = [self viewWithTag:index + 100];
    if (index == 1 || index == 2) {
        [self btnClick:selectedBtn];
    }else{
//        self.userInteractionEnabled = YES;
    }
}


@end
