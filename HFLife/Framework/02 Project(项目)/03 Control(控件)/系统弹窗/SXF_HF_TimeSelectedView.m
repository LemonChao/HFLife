
//
//  SXF_HF_TimeSelectedView.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_TimeSelectedView.h"

@interface SXF_HF_TimeSelectedView ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong)UILabel *topTitleLb;
@property (nonatomic, strong)UILabel *yearTitle;
@property (nonatomic, strong)UILabel *monthTitle;
@property (nonatomic, strong)UIView *meddilLineView;
@property (nonatomic, strong)UIPickerView *timePickerView;
@property (nonatomic, strong)UIButton *bottomBtn;

@property (nonatomic, strong)NSString *yearStr;
@property (nonatomic, strong)NSString *monthStr;
@end


@implementation SXF_HF_TimeSelectedView
{NSMutableArray *_yearArrM;NSMutableArray *_monthArrM;}
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self addChildrenViews];
//    }
//    return self;
//}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    _yearArrM = [NSMutableArray array];
    _monthArrM = [NSMutableArray array];
    for (int i = 0; i<60; i++) {
        [_yearArrM addObject:[NSString stringWithFormat:@"%d", 1989 + i]];
        if (i < 12) {
            [_monthArrM addObject:[NSString stringWithFormat:@"%02d", 1 + i]];
        }
    }
//    NSLog(@"%@--%@", _yearArrM, _monthArrM);
    
    
    self.yearStr = _yearArrM.firstObject;
    self.monthStr = _monthArrM.firstObject;
    
    
    
    self.topTitleLb = [UILabel new];
    self.bottomBtn = [UIButton new];
    self.yearTitle = [UILabel new];
    self.monthTitle = [UILabel new];
    self.meddilLineView = [UIView new];
    
    [self addSubview:self.topTitleLb];
    [self addSubview:self.timePickerView];
    [self addSubview:self.bottomBtn];
    [self addSubview:self.monthTitle];
    [self addSubview:self.yearTitle];
    [self addSubview:self.meddilLineView];
    
    self.topTitleLb.font = [UIFont systemFontOfSize:14];
    self.topTitleLb.textColor = HEX_COLOR(0x0C0B0B);
    self.topTitleLb.textAlignment = NSTextAlignmentCenter;
    self.bottomBtn.setTitle(@"确定", UIControlStateNormal).setBackgroundColor(HEX_COLOR(0xCA1400)).setTitleColor([UIColor whiteColor], UIControlStateNormal);
    
    self.bottomBtn.titleLabel.font = FONT(14);
    self.bottomBtn.layer.cornerRadius = ScreenScale(16);
    self.bottomBtn.layer.masksToBounds = YES;
    [self.bottomBtn addTarget:self action:@selector(clickBtn) forControlEvents:UIControlEventTouchUpInside];
    self.yearTitle.font = self.monthTitle.font = FONT(14);
    self.yearTitle.textColor = self.monthTitle.textColor = HEX_COLOR(0x0C0B0B);
    self.yearTitle.text = @"年";
    self.monthTitle.text = @"月";
    self.topTitleLb.text = @"选择您要查询的时间";
    self.meddilLineView.backgroundColor = HEX_COLOR(0xCA1400);
    
    
    //滚动到当前年月日
    dispatch_async(dispatch_get_main_queue(), ^{
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM"];
        NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
        NSArray *arrM = [destDateString componentsSeparatedByString:@"-"];
        
        
        
        NSInteger yearIndex = [self->_yearArrM indexOfObject:arrM[0]];
        NSInteger monthIndex = [self->_monthArrM indexOfObject:arrM[1]];
        
        [self.timePickerView selectRow:yearIndex inComponent:0 animated:NO];
        [self.timePickerView selectRow:monthIndex inComponent:1 animated:NO];
        
        [self pickerView:self.timePickerView didSelectRow:yearIndex inComponent:0];
        [self pickerView:self.timePickerView didSelectRow:monthIndex inComponent:1];
    });
    
    
    
}
- (void) clickBtn{
    !self.confirmBtnCallback ? : self.confirmBtnCallback(self.yearStr, self.monthStr);
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.topTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(ScreenScale(25));
        make.height.mas_equalTo(ScreenScale(14));
        make.left.right.mas_equalTo(self);
    }];
    
    
    [self.yearTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(85));
        make.height.mas_equalTo(ScreenScale(14));
        make.top.mas_equalTo(self.topTitleLb.mas_bottom).offset(ScreenScale(24));
    }];
    [self.monthTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-85));
        make.centerY.mas_equalTo(self.yearTitle.mas_centerY);
        make.height.mas_equalTo(ScreenScale(14));
    }];
    [self.meddilLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yearTitle.mas_bottom).offset(ScreenScale(21));
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(50));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-50));
        make.height.mas_equalTo(1);
    }];
    
    [self.timePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.meddilLineView.mas_bottom).offset(ScreenScale(5));
        make.left.mas_equalTo(self.mas_left).offset(ScreenScale(40));
        make.right.mas_equalTo(self.mas_right).offset(ScreenScale(-40));
    }];
    
    [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timePickerView.mas_bottom).offset(5);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-20);
        make.width.mas_equalTo(ScreenScale(180));
        make.height.mas_equalTo(ScreenScale(32));
        make.centerX.mas_equalTo(self.topTitleLb.mas_centerX);
    }];
    
}


#pragma mark - dataSouce
//有几行
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
//行中有几列
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return _yearArrM.count;
    }
    return _monthArrM.count;
}

//列显示的数据
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger) row forComponent:(NSInteger)component {
    if (component == 0) {
        return _yearArrM[row];
    }
    return _monthArrM[row];
}

#pragma mark - delegate
// 选中某一组的某一行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"%ld -**- %ld", row, component);
    if (component == 0) {
        self.yearStr = _yearArrM[row];
    }else{
        self.monthStr = _monthArrM[row];
    }
    
    
}


//- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
//    return ScreenScale(150);
//}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return ScreenScale(43);
}


//- (CGSize)rowSizeForComponent:(NSInteger)component{
//    return CGSizeMake(100, 60);
//}


/*

// 自定义指定列的每行的视图，即指定列的每行的视图行为一致
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    if (!view){
        
        view = [[UIView alloc]init];
        
    }
    
    UILabel *text = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 33, 20)];

    text.textAlignment = NSTextAlignmentCenter;

    if (component == 0) {
        text.text = [_yearArrM objectAtIndex:row];
    }else{
        text.text = [_monthArrM objectAtIndex:row];
    }
    text.center = CGPointMake(view.frame.size.width * 0.5, view.frame.size.height * 0.5);
    [view addSubview:text];
    
    //隐藏上下直线
    [self.timePickerView.subviews objectAtIndex:1].backgroundColor = HEX_COLOR(0xF5F5F5);
    
    [self.timePickerView.subviews objectAtIndex:2].backgroundColor = HEX_COLOR(0xF5F5F5);
    
    return view;
    
}
 */
//   参入指定列下标，返回当前所展示单行视图的宽度和高度。
- (CGSize)rowSizeForComponent:(NSInteger)component{
    return CGSizeMake(ScreenScale(100), ScreenScale(43));
}
- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
    
    
}
// 传入行和列下标，选择控制器会滚动到相应视图， 并使其展示在中间。

/*
- (NSInteger)selectedRowInComponent:(NSInteger)component{
    if (component == 0) {
        NSDate *  senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"yyyy"];
        NSString *thisYearString=[dateformatter stringFromDate:senddate];
        return [_yearArrM indexOfObject:thisYearString];
    }else{
        return 0;
    }
}
 
 */
//显示的标题字体、颜色等属性
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *str = @"";
    if (component == 0) {
        str = _yearArrM[row];
    }else{
        str = _monthArrM[row];
    }
    
    
    NSMutableAttributedString *AttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    [AttributedString addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14], NSForegroundColorAttributeName:HEX_COLOR(0x0C0B0B)} range:NSMakeRange(0, [AttributedString  length])];
    
    
    
    return AttributedString;
    
}//NS_AVAILABLE_IOS(6_0);






- (UIPickerView *)timePickerView{
    if (!_timePickerView) {
        _timePickerView = [[UIPickerView alloc] init];
        _timePickerView.delegate = self;
        _timePickerView.dataSource = self;
    }
    return _timePickerView;
}


@end
