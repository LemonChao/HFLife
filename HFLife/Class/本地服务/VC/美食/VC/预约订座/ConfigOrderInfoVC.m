//
//  ConfigOrderInfoVC.m
//  HanPay
//
//  Created by zchao on 2019/2/23.
//  Copyright © 2019 张海彬. All rights reserved.
//

#import "ConfigOrderInfoVC.h"
#import "DateChoose.h"
#import "TimeCHoose.h"

@interface ConfigOrderInfoVC ()
{
    BOOL isToday;
    NSMutableDictionary *dict;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerbgHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *shadowboxTop;


@property (weak, nonatomic) IBOutlet UIStackView *renshuStackView;
@property (weak, nonatomic) IBOutlet UIButton *weizhiSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *renshuSelectButton;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;

@end

@implementation ConfigOrderInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dateLabel.text = @"";
    self.timeLabel.text = @"";
    dict = [NSMutableDictionary dictionary];
    [dict setObject:@"1" forKey:@"appoint_num"];
    [dict setObject:@"1" forKey:@"appoint_site"];
    self.shadowboxTop.constant = NavBarHeight;
    self.headerbgHeight.constant += statusBarHeight;
    [self setupNavigation];
}

- (void)setupNavigation {
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back_white"]];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"请输入预订时间";
    self.customNavBar.barBackgroundImage = nil;
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    self.customNavBar.backgroundColor = [UIColor clearColor];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
}
- (IBAction)dateButtonAction:(UIButton *)sender {
    DateChoose *timeChoose = [[DateChoose alloc] init];
    [timeChoose setSelectDate:^(NSString * _Nonnull date, BOOL isToday) {
        self->isToday = isToday;
        self.dateLabel.text = date;
        self.timeLabel.text = @"";
//        [sender setTitle:date forState:(UIControlStateNormal)];
    }];
    [self.view addSubview:timeChoose];
}

- (IBAction)timeButtonAction:(UIButton *)sender {
    if (self.dateLabel.text.length == 0 ) {
        [WXZTipView showCenterWithText:@"请选择预定日期"];
        return;
    }
    TimeChoose *timeChoose = [[TimeChoose alloc] initWithFrame:CGRectZero isTaday:isToday];
    [timeChoose setSelectDate:^(NSString *date) {
        self.timeLabel.text = date;
        NSLog(@"self.timeLabel = %@ date = %@",self.timeLabel.text,date);
    }];
//    timeChoose.isToday = isToday;
    [self.view addSubview:timeChoose];
}







//选择人数
- (IBAction)renshuButtonAction:(UIButton *)button {
    if (button != self.renshuSelectButton) {
        button.selected = !button.selected;
        self.renshuSelectButton.selected = !self.renshuSelectButton.selected;
        self.renshuSelectButton = button;
//        [self.renshuStackView layoutSubviews];
         [dict setObject:[button.titleLabel.text stringByReplacingOccurrencesOfString:@"人" withString:@""] forKey:@"appoint_num"];
    }
    
    
    
}


//选择包间
- (IBAction)weizhiButtonActions:(UIButton *)button {
    if (button != self.weizhiSelectButton) {
        button.selected = !button.selected;
        self.weizhiSelectButton.selected = !self.weizhiSelectButton.selected;
        self.weizhiSelectButton = button;
        if ([button.titleLabel.text isEqualToString:@"大厅"]) {
            [dict setObject:@"1" forKey:@"appoint_site"];
        }else{
            [dict setObject:@"2" forKey:@"appoint_site"];
        }
    }
    
}

- (IBAction)confirmClick:(id)sender {
    if (self.dateLabel.text.length == 0 ) {
        [WXZTipView showCenterWithText:@"请选择预定日期"];
        return;
    }
    if (self.timeLabel.text.length == 0 ) {
        [WXZTipView showCenterWithText:@"请选择预定时间"];
        return;
    }
    [dict setObject:self.dateLabel.text forKey:@"appoint_date"];
    [dict setObject:self.timeLabel.text forKey:@"appoint_time"];
    if (self.selectBlock) {
        self.selectBlock(dict);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


@end
