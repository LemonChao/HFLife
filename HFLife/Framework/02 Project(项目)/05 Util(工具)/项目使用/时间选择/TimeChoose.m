//
//  CityChoose.m
//  CityChoose
//
//  Created by apple on 17/2/6.
//  Copyright © 2017年 desn. All rights reserved.
//

#import "TimeChoose.h"

static CGFloat bgViewHeith = 240;
static CGFloat cityPickViewHeigh = 200;
static CGFloat toolsViewHeith = 40;
static CGFloat animationTime = 0.25;
@interface TimeChoose()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) UIPickerView *cityPickerView;/** 城市选择器 */
@property (nonatomic, strong) UIButton *sureButton;        /** 确认按钮 */
@property (nonatomic, strong) UIButton *canselButton;      /** 取消按钮 */
@property (nonatomic, strong) UIView *toolsView;           /** 自定义标签栏 */
@property (nonatomic, strong) UIView *bgView;              /** 背景view */
@property (nonatomic, strong) UILabel *titleLabel;          /** 标题Label */
/** 天 数组 */
@property (nonatomic, strong) NSArray *dayArr;
 /** 小时 数组 */
@property (nonatomic, strong) NSArray *hourArr;
/** 分钟 数组 */
@property (nonatomic, strong) NSArray *minuteArr;
@property (nonatomic, strong) NSString *TimerString;
@end

@implementation TimeChoose


// init 会调用 initWithFrame
- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame isTaday:(BOOL)isTaday{
    self = [super initWithFrame:frame];
    if (self) {
        self.TimerString = @"选择预定时间";
        self.isToday = isTaday;
//        if ([[CommonTools getClickView] isEqualToString:@"0"]) {
//            self.TimerString = @"立即购买";
//        }else{
//            self.TimerString = @"立即前往";
//        }
        [self initSubViews];
        [self initBaseData];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
//        if ([[CommonTools getClickView] isEqualToString:@"0"]) {
//            self.TimerString = @"立即购买";
//        }else{
//            self.TimerString = @"立即前往";
//        }
        
        [self initSubViews];
        [self initBaseData];
    }
    return self;
}

- (void)initSubViews{
    
    self.frame = [UIApplication sharedApplication].keyWindow.bounds;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.toolsView];
    [self.toolsView addSubview:self.canselButton];
    [self.toolsView addSubview:self.sureButton];
    [self.toolsView addSubview:self.titleLabel];
    [self.bgView addSubview:self.cityPickerView];
    
    [self showPickView];
    
}

- (void)initBaseData{
    self.dayArr  = @[@"今天",@"明天"];
    self.hourArr = [self getHourArray:0];
    self.minuteArr = [self getMinuteRow:0 component:0];
    self.day   = self.dayArr[0];
    self.hour       = self.hourArr[0];
    if (self.minuteArr.count >0) {
        self.minute       = self.minuteArr[0];
    }else{
        self.minute       = @"";
    }
    
    
    
}

#pragma event menthods
- (void)canselButtonClick{
    [self hidePickView];
//    if (self.selectDate) {
//        self.selectDate([self calculateData]);
//    }
}

- (void)sureButtonClick{
    [self hidePickView];
    if (self.selectDate) {
        self.selectDate([self calculateData]);
    }
}

#pragma mark private methods
- (void)showPickView{
    [UIView animateWithDuration:animationTime animations:^{
        self.bgView.frame = CGRectMake(0, self.frame.size.height - bgViewHeith, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        
    }];
}


- (void)hidePickView{
    
    [UIView animateWithDuration:animationTime animations:^{
        
        self.bgView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];

}
//获取小时的方法
- (NSArray *)getHourArray:(NSInteger)row{
    NSMutableArray *HHArray = [NSMutableArray array];
    if (!self.isToday) {
        for (int i = 0 ; i<=23 ; i++) {
            NSString *str = @"";
            if (i < 10) {
                str = [NSString stringWithFormat:@"0%d点",i];
            }else{
                str = [NSString stringWithFormat:@"%d点",i];
            }
            
            [HHArray addObject:str];
        }
        self.minuteArr = [self getMinuteRow:0 component:1];
    }else{
            //获取系统当前时间
        NSDate *currentDate = [NSDate date];
            //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            //设置格式：zzz表示时区
        [dateFormatter setDateFormat:@"mm"];
            //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        [dateFormatter setDateFormat:@"HH"];
        NSString *HHDateString = [dateFormatter stringFromDate:currentDate];
        int HHInt = [HHDateString intValue];
            //    [HHArray addObject:self.TimerString];
        if ([currentDateString intValue] > 21) {
            HHInt = HHInt+1;
        }
        for (int i = HHInt ; i<=23 ; i++) {
            NSString *str = @"";
            if (i < 10) {
                str = [NSString stringWithFormat:@"0%d点",i];
            }else{
                str = [NSString stringWithFormat:@"%d点",i];
            }
            
            [HHArray addObject:str];
        }
        self.minuteArr = @[];
    }
    
    return HHArray;
}
//获取分的数组
-(NSArray *)getMinuteRow:(NSInteger)row component:(NSInteger)component{
    NSMutableArray *minuteArray = [NSMutableArray array];
    if (component==0) {
        //获取系统当前时间
        NSDate *currentDate = [NSDate date];
        //用于格式化NSDate对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //设置格式：zzz表示时区
        //    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setDateFormat:@"mm"];
        //NSDate转NSString
        NSString *currentDateString = [dateFormatter stringFromDate:currentDate];
        [dateFormatter setDateFormat:@"HH"];
        NSString *HHDateString = [dateFormatter stringFromDate:currentDate];
        
        NSString *HHStr = self.hourArr[row];
        
        if ([HHStr isEqualToString:_TimerString]) {
            return  @[];
        }else{
            NSArray *array = [HHStr componentsSeparatedByString:@"点"];
            HHStr = array[0];
            if ([HHStr intValue] == [HHDateString intValue]) {
                if ([currentDateString intValue]%5 == 0) {
                    int Intminute = [currentDateString intValue];
                    
                    for (int minute = Intminute + 30 ; minute <= 55; minute= minute + 10) {
                        NSString *minutestr = [NSString stringWithFormat:@"%d分",minute];
                        [minuteArray addObject:minutestr];
                    }
                    return minuteArray;
                }else{
                    int remainder = [currentDateString intValue]%5;
                    int difference = 5 - remainder;
                    int Intminute = [currentDateString intValue] + difference;
                    for (int minute = Intminute + 30 ; minute <= 55; minute= minute + 10) {
                        NSString *minutestr = [NSString stringWithFormat:@"%d分",minute];
                        [minuteArray addObject:minutestr];
                    }
                    return minuteArray;
                }
                
            }else if ([HHStr intValue] - [HHDateString intValue] == 1 ){
                if ([currentDateString intValue] > 25) {
                    if ([currentDateString intValue] <= 30 ) {
                        for (int minute =  0 ; minute <= 55; minute = minute + 10) {
                            NSString *minutestr = @"";
                            if (minute < 10) {
                                minutestr = [NSString stringWithFormat:@"0%d分",minute];
                            }else{
                                minutestr = [NSString stringWithFormat:@"%d分",minute];
                            }
                            [minuteArray addObject:minutestr];
                        }
                        return minuteArray;
                    }else{
                        int minute = [currentDateString intValue] + 30;
                        int difference  = minute - 60;
                        int remainder = difference%5;
                        int difference1 = 5 - remainder;
                        int Intminute = difference + difference1;
                        for (int minute =  Intminute ; minute <= 55; minute= minute + 10) {
                            NSString *minutestr = [NSString stringWithFormat:@"%d分",minute];
                            [minuteArray addObject:minutestr];
                        }
                        return minuteArray;
                    }
                    
                }else{
                    for (int minute =  0 ; minute <= 55; minute = minute + 10) {
                        NSString *minutestr = @"";
                        if (minute < 10) {
                            minutestr = [NSString stringWithFormat:@"0%d分",minute];
                        }else{
                            minutestr = [NSString stringWithFormat:@"%d分",minute];
                        }
                        [minuteArray addObject:minutestr];
                    }
                    return minuteArray;
                }
                
                
            }else{
                for (int minute =  0 ; minute <= 55; minute = minute + 10) {
                    NSString *minutestr = @"";
                    if (minute < 10) {
                        minutestr = [NSString stringWithFormat:@"0%d分",minute];
                    }else{
                        minutestr = [NSString stringWithFormat:@"%d分",minute];
                    }
                    [minuteArray addObject:minutestr];
                }
                return minuteArray;
            }
        }

    }else{
        for (int minute =  0 ; minute <= 55; minute = minute + 10) {
            NSString *minutestr = @"";
            if (minute < 10) {
                minutestr = [NSString stringWithFormat:@"0%d分",minute];
            }else{
                minutestr = [NSString stringWithFormat:@"%d分",minute];
            }
            [minuteArray addObject:minutestr];
        }
        return minuteArray;
    }
}
#pragma mark - pickerViewDatasource
//几列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
//每一列多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
//    if (component == 0) {
//        return self.dayArr.count;
//    }
    if(component == 0){
        return  self.hourArr.count;
    }
    else if(component == 1){
        return self.minuteArr.count;
    }
    return 0;
}

#pragma mark - pickerViewDelegate
//行高
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}
// 返回pickerView 每行的view
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    //设置分割线的颜色
    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = HEX_COLOR(0Xcccccc);;
        }
    }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/3.0, HeightRatio(28))];
    label.adjustsFontSizeToFitWidth = YES;
    [label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:HeightRatio(28)]];
    label.textColor = HEX_COLOR(0x696969);
    label.textAlignment = NSTextAlignmentCenter;
    if (component == 0){
        if (self.hourArr.count>row) {
            label.text =  self.hourArr[row];
        }else{
            label.text =  @"";
        }
        
    }else if (component == 1){
        if (self.minuteArr.count > row) {
            label.text =  self.minuteArr[row];
        }else{
            label.text =  @"";
        }
        
    }
    
    return label;
}

//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
//    if (component == 0) {
//        return self.provinceArr[row];
//    }else if (component == 1){
//        return self.cityArr[row];
//    }else if (component == 2){
//        return self.townArr[row];
//    }
//    return @"";
//}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
     if (component == 0){//选择城市
//        if ([self.day isEqualToString:@"今天"]) {
//           self.minuteArr = [self getMinuteRow:row component:0];
//        }else{
//            self.minuteArr = [self getMinuteRow:row component:1];
//        }
         if (self.isToday) {
             self.minuteArr = [self getMinuteRow:row component:0];
         }else{
             self.minuteArr = [self getMinuteRow:row component:1];
         }
        
//        //更新第二列
        [self.cityPickerView reloadComponent:1];
//        //动画效果跳到选中某1列的某0行
        [self.cityPickerView selectRow:0 inComponent:1 animated:YES];
//
       
        if (self.hourArr.count > row) {
             self.hour = self.hourArr[row];
        }else{
            self.hour = @"";
        }
        if (self.minuteArr.count>0) {
            self.minute = self.minuteArr[0];
        }else{
            self.minute = @"";
        }
       
    }else if (component == 1){
        if (self.minuteArr.count>0) {
            self.minute = self.minuteArr[0];
        }else{
            self.minute = @"";
        }
    }
    if (self.selectDate) {
        self.selectDate([self calculateData]);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    if ([touches.anyObject.view isKindOfClass:[self class]]) {
        [self hidePickView];
    }
}
-(NSString *)calculateData{
    NSInteger row0 = [_cityPickerView selectedRowInComponent:0];
    NSInteger row1 = [_cityPickerView selectedRowInComponent:1];
    
    
    
    NSDate *date = [NSDate date];//给定的时间
    NSDate *nextDat = [NSDate dateWithTimeInterval:(row0 * 24)*60*60 sinceDate:date];//后一天
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *dateString = [outputFormatter stringFromDate:nextDat];
    
    
    
    if (self.hourArr.count > row0) {
        self.hour = self.hourArr[row0];
    }else{
        self.hour = @"";
    }
    NSString *shiStr = [NSString stringWithFormat:@"%@", self.hour];
    if ([shiStr isEqualToString:_TimerString]) {
        return _TimerString;
    }
    NSInteger row2 = [_cityPickerView selectedRowInComponent:1];
    
    if (self.minuteArr.count > row2) {
        self.minute = [NSString stringWithFormat:@"%@",self.minuteArr[row2]];
    }else{
        self.minute = @"";
    }
    NSString *fenStr =  self.minute ;
//    NSString *datrStr = [NSString stringWithFormat:@"%@ %02ld:%02ld:00",dateString,(long)[shiStr integerValue],(long)[fenStr integerValue]];
    NSString *datrStr = [NSString stringWithFormat:@"%02ld:%02ld",(long)[shiStr integerValue],(long)[fenStr integerValue]];
    
    return datrStr;
    
}
#pragma mark - lazy

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, bgViewHeith)];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}

- (UIPickerView *)cityPickerView{
    if (!_cityPickerView) {
        _cityPickerView = ({
            UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolsViewHeith, self.frame.size.width, cityPickViewHeigh)];
            pickerView.backgroundColor = [UIColor whiteColor];
            //            [pickerView setShowsSelectionIndicator:YES];
            pickerView.delegate = self;
            pickerView.dataSource = self;
            pickerView;
        });
    }
    return _cityPickerView;
}

- (UIView *)toolsView{
    
    if (!_toolsView) {
        _toolsView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolsViewHeith)];
        _toolsView.layer.borderWidth = 0.5;
        _toolsView.layer.borderColor = HEX_COLOR(0xdddddd).CGColor;
    }
    return _toolsView;
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
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_canselButton.frame.origin.x+_canselButton.frame.size.width,HeightRatio(17), _sureButton.frame.origin.x - _canselButton.frame.size.width - WidthRatio(20) , HeightRatio(30))];
        CGPoint center = CGPointMake(_titleLabel.centerX, _canselButton.centerY);
        _titleLabel.center = center;
        _titleLabel.font = [UIFont systemFontOfSize:HeightRatio(30)];
        _titleLabel.textColor = HEX_COLOR(0x333333);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"选择购买时间";
    }
    return _titleLabel;
}
-(void)setTitle:(NSString *)title{
    _title = title;
    self.titleLabel.text = _title;
}
- (CGSize)widthWithHeight:(CGFloat)height andFont:(CGFloat)font title:(NSString *)title{
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:font]};
    CGSize  size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, height)  options:(NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin)   attributes:attribute context:nil].size;
    return size;
}

@end
