//
//  SXF_HF_RecommentCell.m
//  HFLife
//
//  Created by mac on 2019/5/8.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "SXF_HF_RecommentCell.h"
#import "SXF_HF_RecommentView.h"

@interface SXF_HF_RecommentCell()

@property (nonatomic, strong) SXF_HF_RecommentView  *collectionV;

@end


@implementation SXF_HF_RecommentCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionV];
    self.collectionV.dataSource = self.dataSourceArr;
    WEAK(weakSelf);
    self.collectionV.selectedItem = ^(NSInteger indexPath, id value) {
        !weakSelf.selectedItem ? : weakSelf.selectedItem(indexPath, value);
    };
    
    //上面按钮点击事件  全链接
    self.collectionV.activityBtnCallback = ^(NSString * _Nonnull urlStr) {
        !weakSelf.activityBtnCallback ? : weakSelf.activityBtnCallback(urlStr);
    };
    
}

- (void)setDataSourceArr:(NSArray *)dataSourceArr{
    _dataSourceArr = dataSourceArr;
    self.collectionV.dataSource = dataSourceArr;
}


- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.contentView);
    }];
}

- (SXF_HF_RecommentView *)collectionV{
    if (!_collectionV) {
        _collectionV = [[SXF_HF_RecommentView alloc] init];
    }
    
    return _collectionV;
}






@end
