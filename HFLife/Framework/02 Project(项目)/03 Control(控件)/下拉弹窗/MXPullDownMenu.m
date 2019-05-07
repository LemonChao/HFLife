//
//  MXPullDownMenu000.m
//  MXPullDownMenu
//
//  Created by 马骁 on 14-8-21.
//  Copyright (c) 2014年 Mx. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import "MXPullDownMenu.h"
#import "customTableViewCell.h"


#define WIDTH [UIScreen mainScreen].bounds.size.width
#define ColorContentTextBlack   [UIColor colorWithRed:51/255.f green:51/255.f blue:51/255.f alpha:1.0]
#define LineColor               [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:1.0]
//#define BaseColor



@interface MXPullDownMenu()
@property (nonatomic ,assign) NSTextAlignment aligenment;
@end

@implementation MXPullDownMenu
{
    
    UIColor *_menuColor;
    

    UIView *_backGroundView;
    UITableView *_tableView;
    
    NSMutableArray *_titles;
    NSMutableArray *_indicators;
    
    
    NSInteger _currentSelectedMenudIndex;
    bool _show;
    
    NSInteger _numOfMenu;
    
    NSArray *_array;
    
    UIColor *_defaultColor;
    
    NSArray *_detaileArr;//详情数组
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    
    }
    return self;
}

- (MXPullDownMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color withWith:(CGRect)frame
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        _defaultColor = [UIColor colorWithHexString:@"4CBDFC"];
        _menuColor = _defaultColor;
        _detaileArr = nil;
        _array = array;

        _numOfMenu = _array.count;
        if (_numOfMenu > 1) {
            _defaultColor = ColorContentTextBlack;
            _menuColor = ColorContentTextBlack;
        }
        
        CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
        CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            
            CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
            CATextLayer *title = [self creatTextLayerWithNSString:_array[i][0] withColor:_defaultColor andPosition:position];
            [self.layer addSublayer:title];
            [_titles addObject:title];
            
            
            CAShapeLayer *indicator;
            //单一菜单 剪头位置在最左边上
            if (_numOfMenu == 1) {
                indicator = [self creatIndicatorWithColor:_defaultColor andPosition:CGPointMake( self.frame.size.width - 10, self.frame.size.height / 2)];
            }else{
                indicator = [self creatIndicatorWithColor:[UIColor blackColor] andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
            }
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
            
            if (i != _numOfMenu - 1) {
                CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height / 2);
                CAShapeLayer *separator;
                if (_numOfMenu == 1) {
                    separator = [self creatSeparatorLineWithColor:_defaultColor andPosition:separatorPosition];
                }else{
                    separator = [self creatSeparatorLineWithColor:LineColor andPosition:separatorPosition];
                }
                [self.layer addSublayer:separator];
                
                
            }
            
        }
        _tableView = [self creatTableViewAtPosition:CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height)];
        _tableView.tintColor = color;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = LineColor;
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];//默认颜色
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
         
        _currentSelectedMenudIndex = -1;
        _show = NO;
    }
    return self;
}

- (MXPullDownMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color withWith:(CGRect)frame withSlecetIndex:(NSArray *) indexArr
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        
//        _menuColor = ColorContentTextBlack;
       _detaileArr = nil;
        _defaultColor = [UIColor colorWithHexString:@"4CBDFC"];
        _menuColor = _defaultColor;
        
        _array = array;
        
        _numOfMenu = _array.count;
        if (_numOfMenu > 1) {
            _defaultColor = ColorContentTextBlack;
            _menuColor = ColorContentTextBlack;
            
        }
        CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
        CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            NSInteger index = [indexArr[i] integerValue];
            CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
            CATextLayer *title = [self creatTextLayerWithNSString:_array[i][index] withColor:_defaultColor andPosition:position];
            [self.layer addSublayer:title];
            [_titles addObject:title];
            
            
            CAShapeLayer *indicator ;
            //单一菜单 剪头位置在最左边上
            if (_numOfMenu == 1) {
                NSInteger index = [indexArr[0] integerValue];
                indicator = [self creatIndicatorWithColor:_defaultColor andPosition:CGPointMake( self.frame.size.width - 10, self.frame.size.height / 2)];
                title = [self creatTextLayerWithNSString:_array[i][index] withColor:_defaultColor andPosition:position];
            }else{
               indicator = [self creatIndicatorWithColor:[UIColor blackColor] andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
            }
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
            if (i != _numOfMenu - 1) {
                CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height / 2);
                CAShapeLayer *separator;
                if (_numOfMenu == 1) {
                    separator = [self creatSeparatorLineWithColor:_defaultColor andPosition:separatorPosition];
                }else{
                    separator = [self creatSeparatorLineWithColor:LineColor andPosition:separatorPosition];
                }
                [self.layer addSublayer:separator];
            }
            
        }
        _tableView = [self creatTableViewAtPosition:CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height)];
        _tableView.tintColor = color;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = LineColor;
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];//默认颜色
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        _currentSelectedMenudIndex = -1;
        _show = NO;
    }
    return self;
}


//带参数详情

- (MXPullDownMenu *)initWithArray:(NSArray *)array selectedColor:(UIColor *)color withWith:(CGRect)frame withSlecetIndex:(NSArray *) indexArr withDetaileArr:(NSArray *)detaileArr
{
    self = [super init];
    if (self) {
        
        self.frame = frame;
        
        //        _menuColor = ColorContentTextBlack;
        
        _defaultColor = [UIColor colorWithHexString:@"4CBDFC"];
        _menuColor = _defaultColor;
        
        _array = array;
        _detaileArr = detaileArr;
        
        _numOfMenu = _array.count;
        if (_numOfMenu > 1) {
            _defaultColor = ColorContentTextBlack;
            _menuColor = ColorContentTextBlack;
            
        }
        CGFloat textLayerInterval = self.frame.size.width / ( _numOfMenu * 2);
        CGFloat separatorLineInterval = self.frame.size.width / _numOfMenu;
        
        _titles = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        _indicators = [[NSMutableArray alloc] initWithCapacity:_numOfMenu];
        
        for (int i = 0; i < _numOfMenu; i++) {
            NSInteger index = [indexArr[i] integerValue];
            CGPoint position = CGPointMake( (i * 2 + 1) * textLayerInterval , self.frame.size.height / 2);
            CATextLayer *title = [self creatTextLayerWithNSString:_array[i][index] withColor:_defaultColor andPosition:position];
            [self.layer addSublayer:title];
            [_titles addObject:title];
            
            
            CAShapeLayer *indicator ;
            //单一菜单 剪头位置在最左边上
            if (_numOfMenu == 1) {
                NSInteger index = [indexArr[0] integerValue];
                indicator = [self creatIndicatorWithColor:_defaultColor andPosition:CGPointMake( self.frame.size.width - 10, self.frame.size.height / 2)];
                title = [self creatTextLayerWithNSString:_array[i][index] withColor:_defaultColor andPosition:position];
            }else{
                indicator = [self creatIndicatorWithColor:[UIColor blackColor] andPosition:CGPointMake(position.x + title.bounds.size.width / 2 + 8, self.frame.size.height / 2)];
            }
            [self.layer addSublayer:indicator];
            [_indicators addObject:indicator];
            if (i != _numOfMenu - 1) {
                CGPoint separatorPosition = CGPointMake((i + 1) * separatorLineInterval, self.frame.size.height / 2);
                CAShapeLayer *separator;
                if (_numOfMenu == 1) {
                    separator = [self creatSeparatorLineWithColor:_defaultColor andPosition:separatorPosition];
                }else{
                    separator = [self creatSeparatorLineWithColor:LineColor andPosition:separatorPosition];
                }
                [self.layer addSublayer:separator];
            }
            
        }
        _tableView = [self creatTableViewAtPosition:CGPointMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height)];
        _tableView.tintColor = color;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorColor = LineColor;
        // 设置menu, 并添加手势
        self.backgroundColor = [UIColor whiteColor];
        UIGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMenu:)];
        [self addGestureRecognizer:tapGesture];
        
        // 创建背景
        _backGroundView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];//默认颜色
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackGround:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        _currentSelectedMenudIndex = -1;
        _show = NO;
    }
    return self;
}








#pragma mark - tapEvent
// 处理菜单点击事件.
- (void)tapMenu:(UITapGestureRecognizer *)paramSender
{
    CGPoint touchPoint = [paramSender locationInView:self];
    
    // 得到tapIndex
    NSInteger tapIndex = touchPoint.x / (self.frame.size.width / _numOfMenu);
    if (_array.count == 1)//单一表格
    {
        self.aligenment = NSTextAlignmentCenter;
        //添加边框
        _tableView.layer.borderWidth = 1.0;
        _tableView.layer.borderColor = LineColor.CGColor;
    }else{
        if (tapIndex == 0) {
            self.aligenment = NSTextAlignmentLeft;
        }
        else if (tapIndex == 1){
            self.aligenment = NSTextAlignmentCenter;
        }
        else{
            self.aligenment = NSTextAlignmentRight;
        }
        
        //带有详情
        if (_detaileArr.count > 0 && _detaileArr != nil) {
            for (NSArray *subArr in _detaileArr) {
                if (subArr.count > 0) {
                    self.aligenment = NSTextAlignmentLeft;
                }
            }
        }
        
        
    }
   
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                }];
            }];
        }
    }
    if (tapIndex == _currentSelectedMenudIndex && _show) {
        
        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _currentSelectedMenudIndex = tapIndex;
            _show = NO;
            
        }];
        
    } else {
        
        _currentSelectedMenudIndex = tapIndex;
        [_tableView reloadData];
        [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView title:_titles[tapIndex] forward:YES complecte:^{
            _show = YES;
        }];
        
    }

 

}
- (void)tapBackGround:(UITapGestureRecognizer *)paramSender
{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
    }];
}


#pragma mark - tableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    [self confiMenuWithSelectRow:indexPath.row];
    [self.delegate PullDownMenu:self didSelectRowAtColumn:_currentSelectedMenudIndex row:indexPath.row];
    
}


#pragma mark tableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _array[_currentSelectedMenudIndex];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        //显示详情
        if (_detaileArr.count) {
            NSArray *arr = _detaileArr[_currentSelectedMenudIndex];
            if (arr.count > 0) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                
            }
        }else{
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
         cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    }
    [cell.textLabel setTextColor:[UIColor grayColor]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
   
    cell.textLabel.textAlignment = self.aligenment;
    if (cell.textLabel.text == [(CATextLayer *)[_titles objectAtIndex:_currentSelectedMenudIndex] string]) {
        cell.contentView.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
        [cell.textLabel setTextColor:[tableView tintColor]];
    }
    if (_detaileArr.count > 0) {
        
        NSArray *arr = _detaileArr[_currentSelectedMenudIndex];
        if (arr.count > 0) {
            cell.textLabel.text = @"";
            cell.detailTextLabel.text = @"";
            cell.detailTextLabel.text = _detaileArr[_currentSelectedMenudIndex][indexPath.row];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"4c8dfc"];//4CBDFC;
        }
    }
     cell.textLabel.text = _array[_currentSelectedMenudIndex][indexPath.row];
    UIView *view = [[UIView alloc] initWithFrame:cell.bounds];
    view.backgroundColor = [UIColor colorWithRed:244/255.f green:244/255.f blue:244/255.f alpha:1];
    cell.selectedBackgroundView = view;
    return cell;
}





#pragma mark - animation

- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)(void))complete
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim andValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    indicator.fillColor = forward ? _tableView.tintColor.CGColor : [UIColor blackColor].CGColor;
    if (_numOfMenu == 1) {
        indicator.fillColor = [_defaultColor CGColor];
    }
    complete();
}





- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)(void))complete
{
    
    if (show) {
        
        [self.superview addSubview:view];
        [view.superview addSubview:self];

        [UIView animateWithDuration:0.2 animations:^{
            
            if (_array.count == 1) {
                view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
            }else{
                view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6];
            }
        }];
    
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
        
    }
    complete();
    
}

- (void)animateTableView:(UITableView *)tableView show:(BOOL)show complete:(void(^)(void))complete
{
    if (show) {
        
        tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        
        CGFloat tableViewHeight = ([tableView numberOfRowsInSection:0] > 9) ? (10 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        
        if (_numOfMenu == 1) {
            tableViewHeight = ([tableView numberOfRowsInSection:0] > 6) ? (6 * tableView.rowHeight) : ([tableView numberOfRowsInSection:0] * tableView.rowHeight);
        }
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewHeight);
        }];

    } else {
        
        [UIView animateWithDuration:0.2 animations:^{
            _tableView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        } completion:^(BOOL finished) {
            [tableView removeFromSuperview];
        }];
        
    }
    complete();
    
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)(void))complete
{
    if (show) {
        title.foregroundColor = _tableView.tintColor.CGColor;
    } else {
        title.foregroundColor = _menuColor.CGColor;
    }
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    
    
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)(void))complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}


#pragma mark - drawing


- (CAShapeLayer *)creatIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(8, 0)];
    [path addLineToPoint:CGPointMake(4, 5)];
    [path closePath];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.fillColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)creatSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point
{
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(160,0)];
    [path addLineToPoint:CGPointMake(160, 20)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 1.0;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)creatTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point
{
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth, size.height);
    layer.string = string;
    layer.fontSize = 14.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}


- (UITableView *)creatTableViewAtPosition:(CGPoint)point
{
    UITableView *tableView = [UITableView new];
    
    tableView.frame = CGRectMake(point.x, point.y, self.frame.size.width, 0);
    tableView.rowHeight = 36;
    
    return tableView;
}


#pragma mark - otherMethods


- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

- (void)confiMenuWithSelectRow:(NSInteger)row
{
    
    CATextLayer *title = (CATextLayer *)_titles[_currentSelectedMenudIndex];
    title.string = [[_array objectAtIndex:_currentSelectedMenudIndex] objectAtIndex:row];
    
    
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
        _show = NO;
        
    }];
    
    CAShapeLayer *indicator = (CAShapeLayer *)_indicators[_currentSelectedMenudIndex];
    indicator.position = CGPointMake(title.position.x + title.frame.size.width / 2 + 8, indicator.position.y);
    
    //单一菜单 剪头位置固定在最左边上
    if (_numOfMenu == 1) {
        indicator.position = CGPointMake( self.frame.size.width - 10, self.frame.size.height / 2);
    }
}

@end

#pragma mark - CALayer Category

@implementation CALayer (MXAddAnimationAndValue)

- (void)addAnimation:(CAAnimation *)anim andValue:(NSValue *)value forKeyPath:(NSString *)keyPath
{
    [self addAnimation:anim forKey:keyPath];
    [self setValue:value forKeyPath:keyPath];
}


@end
