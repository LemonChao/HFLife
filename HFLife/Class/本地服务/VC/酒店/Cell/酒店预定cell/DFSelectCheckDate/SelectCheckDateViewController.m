//
//  SelectCheckDateViewController.m
//  DFCalendar
//
//  Created by Macsyf on 16/12/7.
//  Copyright © 2016年 ZhouDeFa. All rights reserved.
//

#import "SelectCheckDateViewController.h"
#import "MouthModel.h"
#import "SelectCheckDateCell.h"



@interface SelectCheckDateViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableViwe;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIView *weekView;

@end

@implementation SelectCheckDateViewController

-(UIView *)weekView
{
    if (!_weekView) {
        _weekView = [[UIView alloc]initWithFrame:CGRectMake(-1, NavBarHeight-1, self.view.bounds.size.width+2, 40)];
        NSArray *title = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
        for (int i =0 ; i < 7 ; i++) {
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width/7*i+1, 0, self.view.bounds.size.width/7, _weekView.bounds.size.height)];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = title[i];
            if (i>4) {
                label.textColor = [UIColor orangeColor];
            }
            [_weekView addSubview:label];
        }
        _weekView.backgroundColor = [UIColor whiteColor];
        _weekView.layer.borderWidth = 1;
        _weekView.layer.masksToBounds = YES;
        _weekView.layer.borderColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1].CGColor;
    }
    return _weekView;
}


-(NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array ];

        
//        NSDate *date = [NSDate date]; //获得时间对象
        
//        NSTimeZone *zone = [NSTimeZone systemTimeZone]; //获得系统的时区
        
//        NSTimeInterval time = [zone secondsFromGMTForDate:date];//以秒为单位返回当前时间与系统格林尼治时间的差
        
//        NSDate *toDayDate = [date dateByAddingTimeInterval:time];//然后把差的时间加上,就是当前系统准确的时间

        NSDate *toDayDate = [NSDate date];

//        NSLog(@"todayDate:%@",toDayDate);
        
        NSInteger toYear = [self getDataFromDate:toDayDate type:@"year"];
        NSInteger toMouth = [self getDataFromDate:toDayDate type:@"mouth"];
        
        for (int i = 0 ; i < 13 ; i++) {
            
            if (i == 0) {
                
                MouthModel  * mouthModel = [[MouthModel alloc] init];
                mouthModel.year = [self getDataFromDate:toDayDate type:@"year"];
                mouthModel.mouth = [self getDataFromDate:toDayDate type:@"mouth"];
                NSMutableArray *days = [NSMutableArray array ];

                for (NSInteger i = [self getDataFromDate:toDayDate type:@"day"] ; i < [self totaldaysInThisMonth:toDayDate]+1; i++) {
                    DayModel *dayModel = [[DayModel alloc]init];
                    dayModel.dayDate = [self dateWithYear:mouthModel.year mouth:mouthModel.mouth day:i];
                    dayModel.day = i;
//                    NSLog(@"dayModel.day:%ld",dayModel.day);

//                    NSLog(@"%@",dayModel.dayDate);
                    dayModel.state = DayModelStateNormal;
                    dayModel.dayOfTheWeek = [self getDataFromDate:dayModel.dayDate type:@"week"];
                    [days addObject:dayModel];
                }
                mouthModel.days = days;
                
                DayModel *m = days.firstObject;
                NSInteger lineCount = 1;
                NSInteger oneLineCoune =( 7 - m.dayOfTheWeek + 2 ) % 7;
                if (oneLineCoune == 0) {
                    oneLineCoune = 7;
                }
                NSInteger count = days.count - oneLineCoune;
                if (count%7==0) {
                    lineCount = lineCount + count/7;
                }else{
                    lineCount = lineCount + count/7 + 1;

                }
                mouthModel.cellHight = 60 + 60 * lineCount + 2 * (lineCount + 1);
                [_dataArray addObject:mouthModel];
                
            }else{
                if (toMouth == 13) {
                    toMouth = 1;
                    toYear += 1;
                }else{
                    
                }
               
                NSDate *toDate = [self dateWithYear:toYear mouth:toMouth day:1];
                MouthModel  * mouthModel = [[MouthModel alloc] init];
                mouthModel.year = [self getDataFromDate:toDate type:@"year"];
                mouthModel.mouth = [self getDataFromDate:toDate type:@"mouth"];
                NSMutableArray *days = [NSMutableArray array ];
                for (NSInteger i = [self getDataFromDate:toDate type:@"day"] ; i < [self totaldaysInThisMonth:toDate]+1; i++) {
                    DayModel *dayModel = [[DayModel alloc]init];
                    dayModel.dayDate = [self dateWithYear:mouthModel.year mouth:mouthModel.mouth day:i];
                    dayModel.day = i;
//                    NSLog(@"%@",dayModel.dayDate);
                    dayModel.state = DayModelStateNormal;
                    dayModel.dayOfTheWeek = [self getDataFromDate:dayModel.dayDate type:@"week"];
                    [days addObject:dayModel];
                }
                mouthModel.days = days;
                
                DayModel *m = days.firstObject;
                NSInteger lineCount = 1;
                NSInteger oneLineCoune =( 7 - m.dayOfTheWeek + 2 ) % 7;
                if (oneLineCoune == 0) {
                    oneLineCoune = 7;
                }
                NSInteger count = days.count - oneLineCoune;
                if (count%7==0) {
                    lineCount = lineCount + count/7 ;
                }else{
                    lineCount = lineCount + count/7 + 1 ;
                    
                }
                
                mouthModel.cellHight = 60 + 60 * lineCount + 2 * (lineCount + 1);

                [_dataArray addObject:mouthModel];
                
            }
            toMouth++;
        }
    }
    return _dataArray;
}



- (NSInteger )weekdayStringFromDate:(NSDate*)inputDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //如果传进来的日期已经加上了时区差的时间，那么求星期的时候就不用再加
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return theComponents.weekday;
    
}


-(NSInteger )getDataFromDate:(NSDate *)date type:(NSString * )type
{
    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] ;
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    NSInteger unitFlags = NSCalendarUnitYear |
//    NSCalendarUnitMonth |
//    NSCalendarUnitDay |
//    NSCalendarUnitWeekday |
//    NSCalendarUnitHour |
//    NSCalendarUnitMinute |
//    NSCalendarUnitSecond;
//    comps = [calendar components:unitFlags fromDate:date];
//    NSInteger week = [comps weekday];
//    NSInteger year=[comps year];
//    NSInteger month = [comps month];
//    NSInteger day = [comps day];
    
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; //获得系统的时区
    
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];//以秒为单位返回当前时间与系统格林尼治时间的差
    
//    NSDate *currentDate = [date dateByAddingTimeInterval:time];//然后把差的时间加上,就是当前系统准确的时间
    
    
    
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [df stringFromDate:date];
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSRange range = {4,2};
    NSInteger mouth = [[dateStr substringWithRange:range] integerValue];
    NSInteger day = [[dateStr substringFromIndex:6] integerValue];
    NSDate *date1 = [self dateWithYear:year mouth:mouth day:day];

    
    if ([type isEqualToString:@"year"]) {
        return year;
    }else if ([type isEqualToString:@"mouth"]) {
        return mouth;
    }else if ([type isEqualToString:@"day"]) {
        return day;
    }else if ([type isEqualToString:@"week"]) {
        return [self weekdayStringFromDate:date1];
    }else{
        return 0;
    }
}



//通过年月日获得日期
-(NSDate *)dateWithYear:(NSInteger )year mouth:(NSInteger )mouth day:(NSInteger )day
{
    
  return [self stringToDate:[self dateStringWithYear:year mouth:mouth day:day]];
}

//通过年月日获得日期字符串
-(NSString *)dateStringWithYear:(NSInteger )year mouth:(NSInteger )mouth day:(NSInteger )day
{
    
    return [NSString stringWithFormat:@"%ld%02ld%02ld",year,mouth,day];
}


//时间字符串转时间
-(NSDate *)stringToDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    
//    NSTimeZone *zone = [NSTimeZone systemTimeZone]; //获得系统的时区
    
//    NSTimeInterval time = [zone secondsFromGMTForDate:[formatter dateFromString:dateStr]];//以秒为单位返回当前时间与系统格林尼治时间的差
    
//    return [[formatter dateFromString:dateStr] dateByAddingTimeInterval:time];//然后把差的时间加上,就是当前系统准确的时间
    return [formatter dateFromString:dateStr];
}


//通过日期得到当月有多少天
- (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}


-(UITableView *)tableViwe
{
    
    if (!_tableViwe) {
        _tableViwe = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.weekView.frame), self.view.bounds.size.width, self.view.bounds.size.height - self.weekView.bounds.size.height-64) style:UITableViewStylePlain];
        _tableViwe.delegate = self;
        _tableViwe.dataSource = self;
        _tableViwe.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableViwe.showsVerticalScrollIndicator = NO;
        [_tableViwe registerClass:[SelectCheckDateCell class] forCellReuseIdentifier:@"SelectCheckDateCell"];
    }
    return _tableViwe;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.weekView];
    [self.view addSubview:self.tableViwe];
    [self setupNavBar];
//    self.navigationItem.title = @"请选择入住时间";
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(selectedCheckDate)];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@""];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar wr_setRightButtonWithTitle:@"确定" titleColor:[UIColor blackColor]];
    [self.customNavBar setOnClickRightButton:^{
        [weakSelf selectedCheckDate];
    }];
        //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"请选择入住时间";
    self.customNavBar.titleLabelColor = [UIColor blackColor];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    SelectCheckDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCheckDateCell"];
    MouthModel *mouthModel = self.dataArray[indexPath.row];
//    NSLog(@"++++;%@",mouthModel.days.firstObject.dayDate);
    [cell fullCellWithModel:mouthModel];
    if (indexPath.section == 0 && indexPath.row == 0) {
        [cell setToday:YES];
    }else{
        [cell setToday:NO];
    }
    __weak typeof(self) weakSelf = self;
    [cell selectedDay:^(NSInteger day) {
        BOOL isHaveStart = NO;
        BOOL isHaveEnd = NO;
        BOOL isHaveSelected = NO;
        NSDate *startDate ;
        NSDate *endDate ;
        for (MouthModel *Mo in self.dataArray) {
            for (DayModel *mo in Mo.days) {
                if (mo.state == DayModelStateStart) {
                    isHaveStart = YES;
                    startDate = [weakSelf dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                    break;
                }
            }
            for (DayModel *mo in Mo.days) {
                if (mo.state == DayModelStateEnd) {
                    isHaveEnd = YES;
                    endDate = [weakSelf dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                    break;
                }
            }
            for (DayModel *mo in Mo.days) {
                if (mo.state == DayModelStateSelected) {
                    isHaveSelected = YES;
                    break;
                }
            }
        }
        
        if ((!isHaveStart && !isHaveEnd && !isHaveSelected )|| (!isHaveStart && !isHaveEnd) ||(isHaveEnd && isHaveStart)) {
            for (MouthModel *Mo in weakSelf.dataArray) {
                for (DayModel *mo in Mo.days) {
                    mo.state = DayModelStateNormal;
                }
            }
            for (MouthModel *Mo in weakSelf.dataArray) {
                for (DayModel *mo in Mo.days) {
                    if (mo.day == day && Mo.mouth == mouthModel.mouth && Mo.year == mouthModel.year) {
                        mo.state = DayModelStateStart;
                        break;
                    }
                }
            }
        }else if(isHaveStart && !isHaveEnd){
            NSDate *currentSelectDate = [weakSelf dateWithYear:mouthModel.year mouth:mouthModel.mouth day:day];
            int ci = [self compareDate:currentSelectDate withDate:startDate];
            switch (ci) {
                case 1://startDate > currentSelectDate
                    for (MouthModel *Mo in weakSelf.dataArray) {
                        for (DayModel *mo in Mo.days) {
                            mo.state = DayModelStateNormal;
                        }
                    }
                    for (MouthModel *Mo in weakSelf.dataArray) {
                        for (DayModel *mo in Mo.days) {
                            if (mo.day == day && Mo.mouth == mouthModel.mouth && Mo.year == mouthModel.year) {
                                mo.state = DayModelStateStart;
                                break;
                            }
                        }
                    }
                    break;
                case -1:
                    for (MouthModel *Mo in weakSelf.dataArray) {
                        for (DayModel *mo in Mo.days) {
                            if (mo.day == day && Mo.mouth == mouthModel.mouth && Mo.year == mouthModel.year) {
                                mo.state = DayModelStateEnd;
                                endDate = [weakSelf dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                                break;
                            }
                        }
                    }
                    for (MouthModel *Mo in weakSelf.dataArray) {
                        for (DayModel *mo in Mo.days) {
                            NSDate *currentSelectDate = [weakSelf dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                            int ci1 = [weakSelf compareDate:currentSelectDate withDate:startDate];
                            int ci2 = [weakSelf compareDate:currentSelectDate withDate:endDate];
                            if (ci1 == -1 && ci2 == 1 ) {
                                mo.state = DayModelStateSelected;
                            }
                        }
                    }
                    break;
                case 0:
                    for (MouthModel *Mo in weakSelf.dataArray) {
                        for (DayModel *mo in Mo.days) {
                            if (mo.day == day && Mo.mouth == mouthModel.mouth && Mo.year == mouthModel.year) {
                                mo.state = DayModelStateNormal;
                                break;
                            }
                        }
                    }
                    break;
                default:
                    break;
            }
            
        }else if(isHaveStart && isHaveEnd){
            for (MouthModel *Mo in weakSelf.dataArray) {
                for (DayModel *mo in Mo.days) {
                    mo.state = DayModelStateNormal;
                }
            }
        }
        [weakSelf setTitleText];
        [weakSelf.tableViwe reloadData];
        
    }];
    return cell;
}

#pragma mark-日期比较
-(int)compareDate:(NSDate *)date01 withDate:(NSDate *)date02{
    int ci;
    NSComparisonResult result = [date01 compare:date02];
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending: ci=1; break;
            //date02比date01小
        case NSOrderedDescending: ci=-1; break;
            //date02=date01
        case NSOrderedSame: ci=0; break;
        default: NSLog(@"erorr dates %@, %@", date02, date01); break;
    }
    return ci;
}

-(void)setTitleText
{
    NSDate *startDate;
    BOOL isHaveStartDate = NO;
    for (MouthModel *Mo in self.dataArray) {
        for (DayModel *mo in Mo.days) {
            if (mo.state == DayModelStateStart) {
                isHaveStartDate = YES;
                startDate = [self dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                break;
            }
        }
    }
    NSDate *endDate;
    BOOL isHaveEndDate = NO;
    for (MouthModel *Mo in self.dataArray) {
        for (DayModel *mo in Mo.days) {
            if (mo.state == DayModelStateEnd) {
                isHaveEndDate = YES;
                endDate = [self dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                break;
            }
        }
    }

    
    if (isHaveEndDate && isHaveStartDate) {
        NSInteger days = [self calcDaysFromBegin:startDate end:endDate];
        NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM"];
        NSDateFormatter *dateFormatter2=[[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"dd"];
        NSString *mouthStr = [dateFormatter1 stringFromDate:startDate];
        NSString *dayStr = [dateFormatter2 stringFromDate:startDate];
        NSString *daysStr = [NSString stringWithFormat:@"%ld",days];
        self.customNavBar.title = [NSString stringWithFormat:@"%@月%@日入住%@晚",mouthStr,dayStr,daysStr];

    }else if(isHaveStartDate && !isHaveEndDate){
        NSDateFormatter *dateFormatter1=[[NSDateFormatter alloc] init];
        [dateFormatter1 setDateFormat:@"MM"];
        NSDateFormatter *dateFormatter2=[[NSDateFormatter alloc] init];
        [dateFormatter2 setDateFormat:@"dd"];
        NSString *mouthStr = [dateFormatter1 stringFromDate:startDate];
        NSString *dayStr = [dateFormatter2 stringFromDate:startDate];
        self.customNavBar.title = [NSString stringWithFormat:@"%@月%@日入住",mouthStr,dayStr];

    }else{
        self.customNavBar.title = @"请选择入住时间";

    }
    
}

-(void)selectedCheckDate
{
    NSDate *startDate;
    BOOL isHaveStartDate = NO;
    for (MouthModel *Mo in self.dataArray) {
        for (DayModel *mo in Mo.days) {
            if (mo.state == DayModelStateStart) {
                isHaveStartDate = YES;
                startDate = [self dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                break;
            }
        }
    }
    NSDate *endDate;
    BOOL isHaveEndDate = NO;
    for (MouthModel *Mo in self.dataArray) {
        for (DayModel *mo in Mo.days) {
            if (mo.state == DayModelStateEnd) {
                isHaveEndDate = YES;
                endDate = [self dateWithYear:Mo.year mouth:Mo.mouth day:mo.day];
                break;
            }
        }
    }
    
    if (isHaveStartDate && isHaveEndDate) {
        NSInteger days = [self calcDaysFromBegin:startDate end:endDate];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *startDateStr = [dateFormatter stringFromDate:startDate];
        NSString *endDateStr = [dateFormatter stringFromDate:endDate];
        NSString *daysStr = [NSString stringWithFormat:@"%ld",days];
        if (_selectCheckDateBlock) {
            _selectCheckDateBlock(startDateStr,endDateStr,daysStr);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        return ;
    }
    

    
    
}

//计算两个日期之间的天数
- (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}


#pragma mark-日期比较
//-(int)compareDate:(NSString*)date01 withDate:(NSString*)date02{
//    int ci;
//    NSDateFormatter *df = [[NSDateFormatter alloc] init];
//    [df setDateFormat:@"yyyy-MM-dd hh:mm"];
//    NSDate *dt1 = [[NSDate alloc] init];
//    NSDate *dt2 = [[NSDate alloc] init];
//    dt1 = [df dateFromString:date01];
//    dt2 = [df dateFromString:date02];
//    NSComparisonResult result = [dt1 compare:dt2];
//    switch (result)
//    {
//            //date02比date01大
//        case NSOrderedAscending: ci=1; break;
//            //date02比date01小
//        case NSOrderedDescending: ci=-1; break;
//            //date02=date01
//        case NSOrderedSame: ci=0; break;
//        default: NSLog(@"erorr dates %@, %@", dt2, dt1); break;
//    }
//    return ci;
//}



-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MouthModel *model = self.dataArray[indexPath.row];
//    NSLog(@"%f",model.cellHight);
    return model.cellHight;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
