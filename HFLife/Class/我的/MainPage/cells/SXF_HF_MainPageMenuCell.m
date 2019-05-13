
//
//  SXF_HF_MainPageMenuCell.m
//  HFLife
//
//  Created by mac on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//



@interface myMenuCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UIView *bgView;
@property (nonatomic, strong)UIImageView *imageV;
@property (nonatomic, strong)UILabel *titleLb;
@end

@implementation myMenuCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}


- (void) addChildrenViews{
    self.bgView = [UIView new];
    self.titleLb = [UILabel new];
    self.imageV = [UIImageView new];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLb];
    [self.bgView addSubview:self.imageV];
    
    self.titleLb.font = FONT(12);
    self.titleLb.textColor = HEX_COLOR(0x0C0B0B);
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.imageV.contentMode = UIViewContentModeScaleAspectFit;
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.bgView.layer.cornerRadius = 5;
    self.bgView.clipsToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(ScreenScale(0));
        make.right.bottom.mas_equalTo(ScreenScale(0));
    }];
    
    
    [self.imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgView.mas_top).offset(ScreenScale(17));
        make.width.height.mas_equalTo(ScreenScale(32));
        make.centerX.mas_equalTo(self.bgView.mas_centerX);
    }];
    
    [self.titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgView.mas_bottom).offset(ScreenScale(-16));
        make.left.right.mas_equalTo(self.bgView);
        make.height.mas_equalTo(ScreenScale(12));
    }];
}

@end


#import "SXF_HF_MainPageMenuCell.h"

@interface SXF_HF_MainPageMenuCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong)UIView *bgView;

@property (nonatomic, strong)UICollectionView *menuCollectionView;

@end


@implementation SXF_HF_MainPageMenuCell
{
    NSArray *_titleArr;
    NSArray *_imageArr;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    
    _titleArr =  @[@"收货地址", @"银行卡", @"分享好友", @"安全中心", @"我要入驻", @"我的收藏",@"我的好友", @"关于我们"];
    _imageArr = @[@"收货地址", @"银行卡", @"分享好友", @"安全中心", @"我要入驻", @"我的收藏",@"我的好友", @"关于我们"];
    
    
    self.bgView = [UIView new];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.menuCollectionView];
    self.menuCollectionView.backgroundColor = [UIColor clearColor];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(self.contentView);
        make.top.mas_equalTo(self.contentView.mas_top).offset(ScreenScale(0));
    }];
    
    
    [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView.mas_right).offset(ScreenScale(-12));
        make.left.mas_equalTo(self.contentView.mas_left).offset(ScreenScale(12));
    }];
    
    
    
    [self layoutIfNeeded];
    
    [self.bgView changeBgView:@[HEX_COLOR(0xF5F5F5), HEX_COLOR(0xA4CDFB)] startPoint:CGPointMake(0, 0) endPoint:CGPointMake(0, 1)];
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titleArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    myMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"item" forIndexPath:indexPath];
    cell.titleLb.text = _titleArr[indexPath.row];
    cell.imageV.image = MY_IMAHE(_imageArr[indexPath.row]);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    !self.selecteItem ? : self.selecteItem(indexPath.row);
}

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = ScreenScale(5);
        layout.minimumLineSpacing = ScreenScale(5);
        CGFloat itemSize = (SCREEN_WIDTH - (24 + 15)) / 4;
        layout.itemSize = CGSizeMake(ScreenScale(84), ScreenScale(84));
        _menuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.delegate = self;
        _menuCollectionView.dataSource = self;
        [_menuCollectionView registerClass:[myMenuCollectionViewCell class] forCellWithReuseIdentifier:@"item"];
    }
    return _menuCollectionView;
}

@end
