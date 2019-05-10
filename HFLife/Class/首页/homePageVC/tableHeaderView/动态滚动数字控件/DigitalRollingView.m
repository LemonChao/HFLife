//
//  DigitalRollingView.m
//  数字滚动
//
//  Created by sxf on 2019/1/2.
//  Copyright © 2019年 sxf. All rights reserved.
//

#import "DigitalRollingView.h"
@interface DigitalRollingView ()
{
    NSMutableArray *_numbersText;       // 保存拆分出来的数字
    NSMutableArray *_scrollLayers;
    NSMutableArray *_scrollLabels;      // 保存label
    
    NSString *numberStr;
    
    NSMutableArray *historyArray; //历史数值数组
    
    NSMutableArray *animationArray;
}

@end
@implementation DigitalRollingView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
-(instancetype)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (void)reloadView
{
    [self prepareAnimations];
}

- (void)startAnimation
{
    [self createAnimations];
}

- (void)stopAnimation
{
    for (CALayer *layer in _scrollLayers) {
        [layer removeAnimationForKey:@"MSNumberScrollAnimatedView"];
    }
}
- (void)createAnimations{
        // 第一个 layer 的动画持续时间
    NSTimeInterval duration = self.duration - ((_numbersText.count-1) * self.durationOffset);
    for (int i=0; i < _scrollLayers.count; i++) {
        CALayer *layer = _scrollLayers[i];
        NSString *isAnimation = animationArray[i];
        if ([isAnimation isEqualToString:@"0"]) {
            CGFloat maxY = [[layer.sublayers lastObject] frame].origin.y;
                // keyPath 是 sublayerTransform ，因为动画应用于 layer 的 subLayer。
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"sublayerTransform.translation.y"];
            animation.duration = duration;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
                // 滚动方向
            if (self.isAscending) {
                animation.fromValue = @0;
                animation.toValue = [NSNumber numberWithFloat:-maxY];
            } else {
                animation.fromValue = [NSNumber numberWithFloat:-maxY];
                animation.toValue = @0;
            }
                // 添加动画
            [layer addAnimation:animation forKey:@"MSNumberScrollAnimatedView"];
                // 累加动画持续时间
            duration += self.durationOffset;
        }
        
    }
//    for (CALayer *layer in _scrollLayers) {
//
//
//    }
}

#pragma mark 初始化
- (void)commonInit{
    self.duration = 1;
    self.durationOffset = 0.2;
    self.density = 0;
    self.minLength = 0;
    self.isAscending = NO;
    
    self.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    self.textColor = [UIColor blackColor];
    
    _numbersText = [NSMutableArray array];
    _scrollLayers = [NSMutableArray array];
    _scrollLabels = [NSMutableArray array];
    historyArray = [NSMutableArray array];
    animationArray = [NSMutableArray array];
}
- (void)prepareAnimations{
        // 先删除旧数据
    for (CALayer *layer in _scrollLayers) {
        [layer removeFromSuperlayer];
    }
    [_numbersText removeAllObjects];
    [_scrollLayers removeAllObjects];
    [_scrollLabels removeAllObjects];
    [animationArray removeAllObjects];
    // 配置新的数据和UI
    [self configNumbersText];
    [self configScrollLayers];
}
- (void)configNumbersText{
//    NSString *numberStr = [_number stringValue];
    
    // 如果 number 长度小于 最小长度就补0
    // 这里需要注意一下 minLength 和 length 都是NSUInteger类型 如果相减得负数的话会有问题
    for (NSInteger i = 0; i < (NSInteger)self.minLength - (NSInteger)numberStr.length; i++) {
        [_numbersText addObject:@"0"];
    }
    // 取出 number 各位数
    for (NSUInteger i = 0; i < numberStr.length; i++) {
        [_numbersText addObject:[numberStr substringWithRange:NSMakeRange(i, 1)]];
    }
    if (historyArray.count == 0) {
        [historyArray addObjectsFromArray:_numbersText];
        for (NSString *ss in historyArray) {
             NSLog(@"%@",ss);
             [animationArray addObject:@"1"];
        }
    }else{
        if (historyArray.count < _numbersText.count) {
            NSUInteger difference = _numbersText.count - historyArray.count;
            for (int i = 0; i<difference; i++) {
                [historyArray addObject:@"0"];
            }
        }else if (historyArray.count > _numbersText.count){
            NSUInteger difference = historyArray.count  - _numbersText.count;
            for (int i = 0; i<difference; i++) {
                [_numbersText addObject:@"0"];
            }
        }
        for (int i=0; i < _numbersText.count; i++) {
            NSString *history = historyArray[i];
            NSString *numberStr = _numbersText[i];
            if ([history isEqualToString:numberStr]) {
                [animationArray addObject:@"1"];
            }else{
                [animationArray addObject:@"0"];
            }
        }
        [historyArray removeAllObjects];
        [historyArray addObjectsFromArray:_numbersText];
    }
}
- (void)configScrollLayers{
        // 平均分配宽度
//    CGFloat width = CGRectGetWidth(self.frame) / _numbersText.count;
//    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = self.width;
    CGFloat height = self.height;
    // 创建和配置 scrollLayer
    CAScrollLayer *contrastlayer;
    for (NSUInteger i = 0; i < _numbersText.count; i++) {
        NSString *numberText = _numbersText[i];
        CAScrollLayer *layer = [CAScrollLayer layer];
        if (contrastlayer != nil) {
            CGFloat x = contrastlayer.frame.size.width+contrastlayer.frame.origin.x+WidthRatio(4);
            if (![numberText isEqualToString:@"."]) {
                layer.frame = CGRectMake(x, 0, width, height);
            }else{
               layer.frame = CGRectMake(x,0,WidthRatio(6), height);
            }
        }else{
            layer.frame = CGRectMake(0, 0, width, height);
        }
        [_scrollLayers addObject:layer];
        [self.layer addSublayer:layer];
        contrastlayer = layer;
        [self configScrollLayer:layer numberText:numberText];
    }
    
}
- (void)configScrollLayer:(CAScrollLayer *)layer numberText:(NSString *)numberText{
    NSInteger number = [numberText integerValue];
    NSMutableArray *scrollNumbers = [NSMutableArray array];
        // 添加要滚动的数字
    for (NSInteger i = 0; i < self.density + 1; i++) {
        [scrollNumbers addObject:[NSString stringWithFormat:@"%u", (unsigned int)((number+i) % 10)]];
    }
    [scrollNumbers addObject:numberText];
        // 创建 scrollLayer 的内容，数字降序排序
        // 修改局部变量的值需要使用 __block 修饰符
    __block CGFloat height = 0;
    [scrollNumbers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSString *text, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [self createLabel:text];
        label.frame = CGRectMake(0, height, CGRectGetWidth(layer.frame),CGRectGetHeight(layer.frame));
        [layer addSublayer:label.layer];
        // 保存label，防止对象被回收
        [self->_scrollLabels addObject:label];
            // 累加高度
        height = CGRectGetMaxY(label.frame);
    }];
}
- (UILabel *)createLabel:(NSString *)text{
    UILabel *label = [[UILabel alloc] init];
    label.textColor = self.textColor;
    label.layer.borderColor = self.itemBoardColor.CGColor;
    label.backgroundColor = self.itemBgColor;
    label.font = self.font;
//    label.textColor = HEX_COLOR(0x666666);
//    label.font = [UIFont systemFontOfSize:WidthRatio(24)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    if (![text isEqualToString:@"."]) {
         MMViewBorderRadius(label, WidthRatio(10), HeightRatio(2), HEX_COLOR(0xc7c7c7));
    }else{
         MMViewBorderRadius(label, WidthRatio(10),0, HEX_COLOR(0xc7c7c7));
        label.backgroundColor = [UIColor clearColor];
    }
    return label;
}
#pragma mark 懒加载
- (void)setNumber:(double)number{
    _number = number;
    numberStr = MMNSStringFormat(@"%.10f",_number);
    // 准备动画
    [self prepareAnimations];
}
-(void)setIntegerNumber:(int)integerNumber{
    _integerNumber = integerNumber;
    numberStr = MMNSStringFormat(@"%d",_integerNumber);
    [self prepareAnimations];
}
@end
