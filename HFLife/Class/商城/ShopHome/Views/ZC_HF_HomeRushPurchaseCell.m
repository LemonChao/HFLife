//
//  ZC_HF_HomeRushPurchaseCell.m
//  HFLife
//
//  Created by zchao on 2019/5/9.
//  Copyright © 2019 sxf. All rights reserved.
//

#import "ZC_HF_HomeRushPurchaseCell.h"


@interface ZC_HF_HomeRushPurchaseCell ()

@property(nonatomic, strong)NSArray<UIButton *> *subButtons;

@end


@implementation ZC_HF_HomeRushPurchaseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *imgButton = [UITool imageButton:image(@"zhendianzhibao") cornerRadius:4 borderWidth:0.f borderColor:[UIColor clearColor]];
        
        UIStackView *stack = [[UIStackView alloc] initWithArrangedSubviews:self.subButtons];
        stack.axis = UILayoutConstraintAxisHorizontal;
        stack.distribution = UIStackViewDistributionFillEqually;
        stack.alignment = UIStackViewAlignmentFill;
        //        stack.spacing = WidthRatio(40);
        
        [self.contentView addSubview:imgButton];
        [self.contentView addSubview:stack];
        [imgButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.left.right.equalTo(self.contentView).inset(ScreenScale(12));
        }];
        
        //        [stack mas_makeConstraints:^(MASConstraintMaker *make) {
        //
        //        }];
    }
    return self;
}



- (NSArray<UIButton *> *)subButtons {
    if (!_subButtons) {
        NSArray *imageNames = @[@"pinpaizhekou",@"tiantiantemai",@"shihuihaohuo",@"pinleimiaosha"];
        NSMutableArray *array = [NSMutableArray array];
        for (int i = 0; i < imageNames.count; i++) {
            UIButton *button = [UITool imageButton:image(imageNames[i]) cornerRadius:4 borderWidth:0.f borderColor:[UIColor clearColor]];
            [button addTarget:self action:@selector(imageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            [array addObject:button];
        }
        _subButtons = array.copy;

    }
    return _subButtons;
}


- (void)imageButtonAction:(UIButton *)button {
    
}

@end
