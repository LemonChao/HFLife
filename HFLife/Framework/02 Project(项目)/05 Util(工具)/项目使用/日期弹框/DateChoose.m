//
//  DateChoose.m
//  HanPay
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 mac. All rights reserved.
//

#import "DateChoose.h"
#import "FSCalendar.h"
static CGFloat bgDateViewHeith = 340;
static CGFloat dataViewHeigh = 300;
static CGFloat toolsDataViewHeith = 40;
static CGFloat animationTime = 0.25;

@interface DateChoose()<FSCalendarDataSource,FSCalendarDelegate>
{
    NSString *dateString;
    BOOL isToday;
}
 /** 背景view */
@property (nonatomic, strong) UIView *bgView;
 /** 自定义标签栏 */
@property (nonatomic, strong) UIView *toolsView;
 /** 日历 */
@property (weak, nonatomic) FSCalendar *calendar;
 /** 数据源 */
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
/** 确认按钮 */
@property (nonatomic, strong) UIButton *sureButton;
/** 取消按钮 */
@property (nonatomic, strong) UIButton *canselButton;
@end
@implementation DateChoose

    // init 会调用 initWithFrame
- (instancetype)init{
    if (self = [super init]) {

    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.dateFormatter = [[NSDateFormatter alloc] init];
        self.dateFormatter.dateFormat = @"yyyy-MM-dd";
        dateString = @"";
        [self initSubViews];
//        [self initBaseData];
    }
    return self;
}
//-(void)load
-(void)initSubViews{
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    [self.toolsView addSubview:self.canselButton];
    [self.toolsView addSubview:self.sureButton];
    [self.bgView addSubview:self.calendar];
    [self showPickView];
}
#pragma event menthods
- (void)canselButtonClick{
    [self hidePickView];
}

- (void)sureButtonClick{
    [self hidePickView];
    if (self.selectDate) {
        self.selectDate(dateString,isToday);
    }
}

#pragma mark private methods
- (void)showPickView{
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - bgDateViewHeith, self.frame.size.width, bgDateViewHeith);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hidePickView{
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, bgDateViewHeith);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
#pragma mark - <FSCalendarDelegate>

- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    NSLog(@"should select date %@",[self.dateFormatter stringFromDate:date]);
   
    return  [self checkProductDate:[self.dateFormatter stringFromDate:date]];
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
//    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM月dd日";
    dateString = [fmt stringFromDate:date];
    NSLog(@"dateString = %@",dateString);
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
}

- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar
{
    NSLog(@"did change to page %@",[self.dateFormatter stringFromDate:calendar.currentPage]);
}

- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated
{
    calendar.frame = (CGRect){calendar.frame.origin,bounds.size};
}
#pragma mark - <FSCalendarDataSource>
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [NSDate date];
}

- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    NSDate *nowDate = [NSDate date];
    NSTimeInterval  interval =24*60*60*365; //1:天数
    NSDate *date = [nowDate initWithTimeIntervalSinceNow:+interval];
    return date;
}


#pragma mark --懒加载
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bgDateViewHeith)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UIView *)toolsView{
    
    if (!_toolsView) {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolsDataViewHeith)];
        _toolsView.layer.borderWidth = 0.5;
        _toolsView.layer.borderColor = HEX_COLOR(0xdddddd).CGColor;
    }
    return _toolsView;
}

-(FSCalendar *)calendar{
    if (!_calendar) {
        FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, toolsDataViewHeith, SCREEN_WIDTH, dataViewHeigh)];
        calendar.dataSource = self;
        calendar.delegate = self;
//        calendar.appearance.titleWeekendColor = [UIColor grayColor];
        calendar.appearance.weekdayTextColor = HEX_COLOR(0x8E3DF1);
        calendar.scrollDirection = FSCalendarScrollDirectionVertical;
        calendar.appearance.selectionColor = HEX_COLOR(0x8E3DF1);
        calendar.backgroundColor = [UIColor whiteColor];
        [self.bgView addSubview:calendar];
        _calendar = calendar;
        
    }
    return _calendar;
}
- (UIButton *)canselButton{
    if (!_canselButton) {
        _canselButton = ({
            CGSize widSize = [self widthWithHeight:HeightRatio(29) andFont:HeightRatio(29)  title:@"取消"];
            UIButton *canselButton = [[UIButton alloc] initWithFrame:CGRectMake(WidthRatio(20), HeightRatio(10), widSize.width + WidthRatio(88), HeightRatio(60))];
            [canselButton setTitle:@"取消" forState:UIControlStateNormal];
            canselButton.titleLabel.font = [UIFont systemFontOfSize:HeightRatio(29)];
            [canselButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [canselButton addTarget:self action:@selector(canselButtonClick) forControlEvents:UIControlEventTouchUpInside];
            canselButton;
        });
    }
    _canselButton.backgroundColor = HEX_COLOR(0x8E3DF1);
    [_canselButton.layer setMasksToBounds:YES];
    [_canselButton.layer setCornerRadius:3.0]; //设置矩圆角半径
    [_canselButton.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 221/255.0, 221/255.0, 221/255.0, 1 });
    [_canselButton.layer setBorderColor:colorref];
    return _canselButton;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = ({
            CGSize widSize = [self widthWithHeight:HeightRatio(29) andFont:HeightRatio(29)  title:@"确定"];
            UIButton *sureButton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - WidthRatio(20) - widSize.width - WidthRatio(88), HeightRatio(10), widSize.width + WidthRatio(88), HeightRatio(60))];
            [sureButton setTitle:@"确定" forState:UIControlStateNormal];
            sureButton.titleLabel.font = [UIFont systemFontOfSize:HeightRatio(29)];
            [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
            sureButton;
        });
    }
    _sureButton.backgroundColor = HEX_COLOR(0x8E3DF1);
    [_sureButton.layer setMasksToBounds:YES];
    [_sureButton.layer setCornerRadius:3.0]; //设置矩圆角半径
    [_sureButton.layer setBorderWidth:1.0];   //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 221/255.0, 221/255.0, 221/255.0, 1 });
    [_sureButton.layer setBorderColor:colorref];
    return _sureButton;
}
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font title:(NSString *)title{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, height)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:attribute context:nil].size;
    return size;
}
- (BOOL)checkProductDate: (NSString *)tempDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:tempDate];
	// 判断是否大于当前时间
    if ([date earlierDate:[NSDate date]] != date) {
        isToday = NO;
        return YES;
    }else if ([date earlierDate:[NSDate date]] == date){
        isToday = YES;
        return YES;
    }else {
        return NO;
    }
    
}
@end
