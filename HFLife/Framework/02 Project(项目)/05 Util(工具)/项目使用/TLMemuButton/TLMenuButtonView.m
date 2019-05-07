//
//  TLMenuButtonView.m
//  MiShu
//
//  Created by tianlei on 16/6/24.
//  Copyright © 2016年 Qzy. All rights reserved.
//

#import "TLMenuButtonView.h"
#define ColorWithRGB(r, g, b) [UIColor colorWithRed:r/256.0 green:g/256.0 blue:b/256.0 alpha:0.9]
#define kWindow [[UIApplication sharedApplication] keyWindow]

@interface TLMenuButtonView ()

@property (nonatomic, strong) TLMenuButton *menu1;

@property (nonatomic, strong) TLMenuButton *menu2;

@property (nonatomic, strong) TLMenuButton *menu3;

//@property (nonatomic, strong) TLMenuButton *menu4;
//
//@property (nonatomic, strong) TLMenuButton *menu5;
@property (nonatomic, strong) UIView *bgView;
@end

static TLMenuButtonView *instanceMenuView;

@implementation TLMenuButtonView
- (instancetype)init{
    if (self = [super init]) {
//        [self ];
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


- (void)showItems{
//    CGFloat height = kWindow.frame.size.height ==  812.0f ? 83.0f:49.0f;
//    CGRectMake(0, 0, kWindow.frame.size.width, kWindow.frame.size.height -  height - 45)
    self.bgView  = [[UIView alloc]initWithFrame:kWindow.frame];
    self.bgView.backgroundColor = [UIColor clearColor];
    //点击手势
    UITapGestureRecognizer *viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doTapChange:)];
    viewTap.numberOfTapsRequired = 1;
    [self.bgView addGestureRecognizer:viewTap];

    [kWindow addSubview:self.bgView];
    
    self.centerPoint = CGPointMake(kWindow.center.x, kWindow.frame.size.height - 64 + 12);
    CGPoint center = CGPointMake(kWindow.center.x, kWindow.frame.size.height - 64 + 12);
//    self.centerPoint;
    CGFloat r = 150;
    CGPoint point1 = CGPointMake(center.x - r*cos(M_PI/-6), center.y+r*sin(M_PI/-6));
    CGPoint point2 = CGPointMake(center.x - r*cos(M_PI /2), center.y - r*sin(M_PI/2));
    CGPoint point3 = CGPointMake(center.x + r*cos(M_PI /-6), center.y - r*sin(M_PI /6));
    
//    CGPoint point4 = CGPointMake(center.x - r*cos(M_PI * 3 / 8-M_PI/48), center.y - r*sin(M_PI * 3 / 8-M_PI/48));
//    CGPoint point5 = CGPointMake(center.x, center.y - r);
    
   // CGPoint point1 = CGPointMake(center.x - r*cos(M_PI/12), center.y+r*sin(M_PI/12));
    
    TLMenuButton *menu1 = [TLMenuButton buttonWithTitle:@"" imageTitle:@"icon_menu_general" center:center color:HEX_COLOR(0x57acdb)];
    menu1.tag = 1;
    [menu1 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
   // CGPoint point2 = CGPointMake(center.x - r*cos(M_PI / 8-M_PI*3/48), center.y - r*sin(M_PI / 8-M_PI*3/48));
    TLMenuButton *menu2 = [TLMenuButton buttonWithTitle:@"" imageTitle:@"icon_menu_leave" center:center color:HEX_COLOR(0xdb5060)];
     menu2.tag = 2;
    [menu2 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
   // CGPoint point3 = CGPointMake(center.x - r*cos(M_PI / 4-M_PI/24), center.y - r*sin(M_PI / 4-M_PI/24));
    TLMenuButton *menu3 = [TLMenuButton buttonWithTitle:@"" imageTitle:@"icon_menu_reim" center:center color:HEX_COLOR(0x57acdb)];
    menu3.tag = 3;
    [menu3 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
    //CGPoint point4 = CGPointMake(center.x - r*cos(M_PI * 3 / 8-M_PI/48), center.y - r*sin(M_PI * 3 / 8-M_PI/48));
//    TLMenuButton *menu4 = [TLMenuButton buttonWithTitle:@"加班" imageTitle:@"icon_menu_overtime" center:center color:ColorWithRGB(189,111,221)];
//    menu4.tag = 4;
//    [menu4 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
//
//   // CGPoint point5 = CGPointMake(center.x, center.y - r);
//    TLMenuButton *menu5 = [TLMenuButton buttonWithTitle:@"调休" imageTitle:@"icon_menu_dayoff" center:center color:ColorWithRGB(87,211,200)];
//    menu5.tag = 5;
//    [menu5 addTarget:self action:@selector(_addExamApprovel:) forControlEvents:UIControlEventTouchUpInside];
    
    _menu1 = menu1;
    _menu2 = menu2;
    _menu3 = menu3;
//    _menu4 = menu4;
//    _menu5 = menu5;
    _menu1.alpha = 0;
    _menu2.alpha = 0;
    _menu3.alpha = 0;
//    _menu4.alpha = 0;
//    _menu5.alpha = 0;
    
    [kWindow addSubview:menu1];
    [kWindow addSubview:menu2];
    [kWindow addSubview:menu3];
//    [kWindow addSubview:menu4];
//    [kWindow addSubview:menu5];
    
    [UIView animateWithDuration:0.2 animations:^{
        self->_menu1.alpha = 1;
        self->_menu2.alpha = 1;
        self->_menu3.alpha = 1;
//        _menu4.alpha = 1;
//        _menu5.alpha = 1;
        self->_menu1.center = point1;
        self->_menu2.center = point2;
        self->_menu3.center = point3;
//        _menu4.center = point4;
//        _menu5.center = point5;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration:0.2 animations:^{
        self->_menu1.center = self.centerPoint;
        self->_menu2.center = self.centerPoint;
        self->_menu3.center = self.centerPoint;
//        _menu4.center = self.centerPoint;
//        _menu5.center = self.centerPoint;
        self->_menu1.alpha = 0;
        self->_menu2.alpha = 0;
        self->_menu3.alpha = 0;
        self.bgView.alpha = 0;
//        _menu4.alpha = 0;
//        _menu5.alpha = 0;
    } completion:^(BOOL finished) {
        [self->_menu1 removeFromSuperview];
        [self->_menu2 removeFromSuperview];
        [self->_menu3 removeFromSuperview];
        [self.bgView removeFromSuperview];
//        [_menu4 removeFromSuperview];
//        [_menu5 removeFromSuperview];
    }];
}
//点击
-(void)doTapChange:(UITapGestureRecognizer *)sender{
    if (self.dismissBlock) {
        [self dismiss];
        self.dismissBlock();
    }
    
}
- (void)dismissAtNow{
    [_menu1 removeFromSuperview];
    [_menu2 removeFromSuperview];
    [_menu3 removeFromSuperview];
    [_bgView removeFromSuperview];
//    [_menu4 removeFromSuperview];
//    [_menu5 removeFromSuperview];
}

- (void)_addExamApprovel:(UIButton *)sender{
    //[self dismiss];
    NSLog( @"%@", sender );
    if (self.clickAddButton) {
        self.clickAddButton(sender.tag, [sender valueForKey:@"backgroundColor"] );
    }
}
+ (instancetype)standardMenuView{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instanceMenuView = [[self alloc] init];
    });
    return instanceMenuView;
}
@end
