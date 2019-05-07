//
//  HR_thirdLogInView.m
//  HRFramework
//
//  Created by sxf_pro on 2018/3/22.
//

#import "HR_thirdLogInView.h"
@interface HR_thirdLogInView()
@property (nonatomic, strong) selecteBtnView *btnView;
@end



@implementation HR_thirdLogInView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    NSArray *titleArr = @[@"微信", @"QQ" , @"新浪"];
    NSArray *imageArr = @[@"wexinImage", @"qqImage" , @"weiboImage"];
    CGFloat viewW = self.frame.size.width / 3;
    CGFloat viewH = self.frame.size.height;
    for (int i = 0; i < 3; i++){
        _btnView = [[selecteBtnView alloc] initWithFrame:CGRectMake(i * viewW, 0, viewW, viewH)];
        [self addSubview:_btnView];
        [_btnView.titleLabel setText:@"ooo"];
        _btnView.selectBtn.tag = i;
        _btnView.imageV.image = [UIImage imageNamed:imageArr[i]];
        _btnView.titleLabel.text = titleArr[i];
        __weak typeof(self) weakSelf = self;
        _btnView.selecteBtnBlock = ^(NSInteger index) {
            if (weakSelf.selecteBtnBlock) {
                weakSelf.selecteBtnBlock(index);
            }
        };
    }
}
@end





//按钮view的类




@interface selecteBtnView()

@end


@implementation selecteBtnView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    
    return self;
}
- (void) addChildrenViews{
    
    _imageV = [[UIImageView alloc] init];
    _imageV.contentMode = UIViewContentModeScaleAspectFit;
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _selectBtn = [[UIButton alloc] init];
    [self addSubview:_imageV];
    [self addSubview:_titleLabel];
    [self addSubview:_selectBtn];
    
    //布局约束
    [_imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(0, 0, 30, 0));
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_imageV.mas_bottom).offset(0);
        make.left.right.bottom.mas_equalTo(self);
    }];
    
    [_selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(self);
    }];
    
    
    [_selectBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) clickBtn:(UIButton *)sender{
    if (self.selecteBtnBlock) {
        self.selecteBtnBlock(sender.tag);
    }
}

@end
