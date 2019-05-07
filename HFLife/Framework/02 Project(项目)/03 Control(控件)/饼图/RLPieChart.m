
#import "RLPieChart.h"

@implementation RLLayer

- (instancetype)init {
    if ([super init]) {
        self.shadowOffset = CGSizeMake(0, -0.3);
        self.shadowColor = [UIColor grayColor].CGColor;
        self.shadowOpacity = 0.5;
    }
    return self;
}
- (void)configrationLayerWithRadius:(CGFloat)radius
                              angle:(RLShapeLayerAngle)displayAngle {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, radius, radius);
    CGPathAddArc(path, NULL, radius, radius, radius, displayAngle.startAngle, displayAngle.endAngle, 0);
    CGPathCloseSubpath(path);
    self.path = path;
    self.bounds = CGRectMake(0, 0, radius * 2, radius * 2);
    CGPathRelease(path);
}

@end

@interface RLPieChart () {
    CGFloat raduis_;
    CGFloat offSet;
}

@property (nonatomic, strong) CAShapeLayer * maskLayer;
@property (nonatomic, strong) NSArray <UIColor *> * colors;
@property (nonatomic, strong) NSArray <NSNumber *> * ratioes;
@property (nonatomic, strong) RLLayer * selectedLayer;

@end

@implementation RLPieChart

- (CAShapeLayer *)maskLayer {
    if (!_maskLayer) {
        _maskLayer = [CAShapeLayer layer];
        _maskLayer.frame = CGRectMake(0, 0, raduis_ * 2, raduis_ * 2);
        _maskLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(raduis_, raduis_) radius:raduis_ / 2 startAngle:0 endAngle:M_PI * 2 clockwise:YES].CGPath;
        _maskLayer.lineWidth = raduis_;
        _maskLayer.fillColor = [UIColor clearColor].CGColor;
        _maskLayer.strokeColor = [UIColor redColor].CGColor;
        self.layer.mask = _maskLayer;
    }
    return _maskLayer;
}
- (instancetype)pieChartWithRadius:(CGFloat)radius
                            center:(CGPoint)center
                            colors:(NSArray<UIColor *> *)colors
                           ratioes:(NSArray<NSNumber *> *)ratioes
                            offSet:(CGFloat) offSet_ {
    NSAssert(colors.count == ratioes.count, @"colors 和 ratioes 不匹配，导致错误！");
    if ([super init]) {
        CGRect bounds = CGRectMake(0, 0, radius * 2, radius * 2);
        raduis_ = radius;
        if (offSet_ <= 10) offSet = 10;else offSet = offSet_;
        self.colors = colors;
        self.ratioes = ratioes;
        self.bounds = bounds;
        self.center = center;
    }
    return self;
}
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    RLShapeLayerAngle angle = RLShapeLayerAngleMake(0, 0);
    for (int i = 0 ; i < self.colors.count; i ++) {
        angle =  RLShapeLayerAngleMake(angle.endAngle, angle.endAngle + M_PI * 2 * self.ratioes[i].doubleValue);
        RLLayer * layer = [RLLayer layer];
        [layer configrationLayerWithRadius:(raduis_ - offSet) angle:angle];
        layer.position = CGPointMake(raduis_, raduis_);
        layer.fillColor = self.colors[i].CGColor;
        [self.layer addSublayer:layer];
    }
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 2;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [self.maskLayer addAnimation:animation forKey:nil];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch * touch = touches.allObjects.firstObject;
    CGPoint touchPoint = [touch locationInView:self];
    //首先判断是不是在maskLayer的范围之内
    if (![self isInMask:touchPoint]) {
        return ;
    }
    //atan2函数取得的值区间为[0，M_PI],[-M_PI,0]，通过这步操作，将其区间转变为[0,M_PI * 2]的区间之内，方便计算
    CGPoint translatePoint = [self translateIntoCoordinateSystem:touchPoint];
    double angle = atan2(translatePoint.y, translatePoint.x);
    if (angle < 0) {
        angle += M_PI * 2;
    }
    int index = [self touchIntoLayer:angle];
    __weak typeof(self)weakSelf = self;
    if (self.selectedLayer == [self getLayerWithIndex:index]) {
        [UIView animateWithDuration:0.2 animations:^{
            [weakSelf getLayerWithIndex:index].transform = CATransform3DMakeScale(1, 1, 1);
            [weakSelf getLayerWithIndex:index].position = CGPointMake(raduis_, raduis_);
        } completion:^(BOOL finished) {
            weakSelf.selectedLayer = nil;
        }];
        if (self.tappedHandler) {
            self.tappedHandler(index, NO);
        }
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        [weakSelf getLayerWithIndex:index].transform = CATransform3DMakeScale((raduis_ - offSet / 2) / (raduis_ - offSet), (raduis_ - offSet / 2) / (raduis_ - offSet), 1);
        [weakSelf getLayerWithIndex:index].position = [weakSelf positionWithIndex:index];
        if (weakSelf.selectedLayer) {
            weakSelf.selectedLayer.transform = CATransform3DMakeScale(1, 1, 1);
            weakSelf.selectedLayer.position = CGPointMake(raduis_, raduis_);
        }
    } completion:^(BOOL finished) {
        weakSelf.selectedLayer = [weakSelf getLayerWithIndex:index];
    }];
    if (self.tappedHandler) {
        self.tappedHandler(index, YES);
    }
}
//判断当前点在第几个layer的区间之内，-1表示判断错误
- (int)touchIntoLayer:(double)angle {
    RLShapeLayerAngle layerBounds = RLShapeLayerAngleMake(0, 0);
    for (int i = 0 ; i < self.ratioes.count; i ++) {
        layerBounds =  RLShapeLayerAngleMake(layerBounds.endAngle, layerBounds.endAngle + M_PI * 2 * self.ratioes[i].doubleValue);
        if (angle >= layerBounds.startAngle && angle < layerBounds.endAngle) {
            return i;
        }
    }
    return -1;
}
//获取对应layer
- (RLLayer *)getLayerWithIndex:(int)index {
    return (RLLayer *)self.layer.sublayers[index];
}
//获取更改后的layer的中心位置
- (CGPoint)positionWithIndex:(int)index {
    RLShapeLayerAngle angle;
    __weak typeof(self)weakSelf = self;
    double start = 0;
    double end = 0;
    for (int i = 0; i <= index; i++) {
        if (i < index) {
            start += weakSelf.ratioes[i].doubleValue;
        }
        end += weakSelf.ratioes[i].doubleValue;
    }
    angle = RLShapeLayerAngleMake(2 * M_PI * start, 2 * M_PI * end);
    double direactionAngle = direction(angle);
    double cosT = offSet / 2 * cos(direactionAngle);
    double sinT = offSet / 2 * sin(direactionAngle);
    return CGPointMake(raduis_ + cosT, raduis_ + sinT);
}
//判断是否在maskLayer之内
- (BOOL)isInMask:(CGPoint)point {
    double x = point.x - raduis_;
    double y = point.y - raduis_;
    double pow = powf(x, 2) + powf(y, 2);
    if (sqrt(pow) <= raduis_) {
        return YES;
    }
    return NO;
}
//坐标系转化
- (CGPoint)translateIntoCoordinateSystem:(CGPoint)point {
    return CGPointMake(point.x - raduis_, point.y - raduis_);
}
//获得移动方向的角度，相当于移动的向量角度
double direction(RLShapeLayerAngle angle) {
    return angle.startAngle + (angle.endAngle - angle.startAngle) / 2;
}

@end



