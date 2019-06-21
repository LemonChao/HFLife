//
//  ZCShopCartTableViewCell.m
//  HFLife
//
//  Created by zchao on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "ZCShopCartTableViewCell.h"
#import "UILabelEdgeInsets.h"

@interface ZCShopCartTableViewCell ()

@property(nonatomic, strong) UIButton *selectButton;

@property(nonatomic, strong) UIImageView *godsImgView;

@property(nonatomic, strong) UILabel *nameLab;

/** 商品特殊信息，颜色，尺码等 */
@property(nonatomic, strong) UILabelEdgeInsets *specialLab;

/** 促销价 */
@property(nonatomic, strong) UILabel *priceLab;

@property(nonatomic, strong) UIButton *addButton;

@property(nonatomic, strong) UIButton *subtractionButton;

@property(nonatomic, strong) UILabel *countLabel;

/** 商品数量操作 */
@property(nonatomic, strong) RACCommand *addCmd;

@property(nonatomic, strong) RACCommand *subtractionCmd;

@end

@implementation ZCShopCartTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.selectButton];
        [self.contentView addSubview:self.godsImgView];
        [self.contentView addSubview:self.nameLab];
        [self.contentView addSubview:self.specialLab];
        [self.contentView addSubview:self.priceLab];
        [self.contentView addSubview:self.subtractionButton];
        [self.contentView addSubview:self.countLabel];
        [self.contentView addSubview:self.addButton];
        
        [self initConstraints];
    }
    return self;
}

- (void)initConstraints {

    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).inset(ScreenScale(12));
        make.centerY.equalTo(self.godsImgView);
        make.size.mas_equalTo(CGSizeMake(ScreenScale(20), ScreenScale(20)));
    }];
    
    [self.godsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectButton.mas_right).offset(ScreenScale(10));
        make.size.mas_equalTo(CGSizeMake(ScreenScale(80), ScreenScale(80)));
        make.top.equalTo(self.contentView).inset(ScreenScale(10));
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).inset(ScreenScale(20));
        make.left.equalTo(self.godsImgView.mas_right).offset(ScreenScale(10));
        make.right.equalTo(self.contentView).inset(ScreenScale(22));
//        make.height.mas_lessThanOrEqualTo(ScreenScale(30));
    }];
    
    [self.specialLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nameLab.mas_bottom).offset(ScreenScale(10));
        make.left.equalTo(self.nameLab);
        make.right.lessThanOrEqualTo(self.nameLab);
    }];
    
    [self.priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.lessThanOrEqualTo(self.nameLab.mas_bottom).offset(ScreenScale(16));
//        make.top.equalTo(self.specialLab.mas_bottom).offset(ScreenScale(16)).priorityLow();
//        make.top.lessThanOrEqualTo(self.specialLab.mas_bottom).offset(ScreenScale(16));
        make.top.equalTo(self.nameLab.mas_bottom).offset(ScreenScale(16));

        make.left.equalTo(self.nameLab);
        make.bottom.equalTo(self.contentView).inset(ScreenScale(24));
    }];
    
    [self.subtractionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLab);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self.subtractionButton);
        make.left.equalTo(self.subtractionButton.mas_right).offset(ScreenScale(6));
        make.width.mas_equalTo(ScreenScale(30));
    }];
    
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.countLabel);
        make.left.equalTo(self.countLabel.mas_right).offset(ScreenScale(6));
        make.right.equalTo(self.contentView).inset(ScreenScale(12));
    }];
}

-(void)updateConstraints {
    [self.priceLab mas_remakeConstraints:^(MASConstraintMaker *make) {
        if (StringIsEmpty(self.model.goods_spec)) {
            make.top.equalTo(self.nameLab.mas_bottom).offset(ScreenScale(16));
            make.bottom.equalTo(self.contentView).inset(ScreenScale(30));
        }else {
            make.top.equalTo(self.specialLab.mas_bottom).offset(ScreenScale(16));
            make.bottom.equalTo(self.contentView).inset(ScreenScale(24));
        }
        make.left.equalTo(self.nameLab);
    }];
    
    [super updateConstraints];
}




- (void)setModel:(ZCShopCartGoodsModel *)model {
    _model = model;
    
    [self.godsImgView sd_setImageWithURL:[NSURL URLWithString:model.goods_image]];
    self.nameLab.text = model.goods_name;
    self.priceLab.text = model.goods_price;
    self.selectButton.selected = model.selected;
    self.countLabel.text = model.goods_num;
    self.specialLab.text = model.goods_spec;
    if (StringIsEmpty(model.goods_spec)) {
        self.specialLab.edgeInsets = UIEdgeInsetsZero;
    }
    [self setNeedsUpdateConstraints];
}

- (void)selectButtonAction:(UIButton *)button {
    
    self.model.selected = !self.model.isSelected;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
}




- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UITool imageButton:image(@"cart_gods_normal")];
        [_selectButton setImage:image(@"cart_gods_select") forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        [_selectButton setEnlargeEdgeWithTop:15 right:10 bottom:15 left:10];
    }
    return _selectButton;
}

- (UIImageView *)godsImgView {
    if (!_godsImgView) {
        _godsImgView = [UITool imageViewPlaceHolder:nil contentMode:UIViewContentModeScaleAspectFill cornerRadius:WidthRatio(5) borderWidth:0 borderColor:[UIColor clearColor]];
    }
    return _godsImgView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UITool labelWithTextColor:ImportantColor font:SystemFont(14)];
        _nameLab.numberOfLines = 2;
    }
    return _nameLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab = [UITool labelWithTextColor:GeneralRedColor font:MediumFont(14)];
    }
    return _priceLab;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [UITool imageButton:image(@"shop_cart_add")];
        _addButton.rac_command = self.addCmd;
    }
    return _addButton;
}

- (UIButton *)subtractionButton {
    if (!_subtractionButton) {
        _subtractionButton = [UITool imageButton:image(@"shop_cart_subtraction")];
        _subtractionButton.rac_command = self.subtractionCmd;
    }
    return _subtractionButton;
}

- (UILabel *)countLabel {
    if (!_countLabel) {
        _countLabel = [UITool labelWithTextColor:ImportantColor font:SystemFont(14) alignment:NSTextAlignmentCenter ];
        _countLabel.backgroundColor = BackGroundColor;
    }
    return _countLabel;
}

- (RACCommand *)addCmd {
    if (!_addCmd) {
        @weakify(self);
        _addCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                NSInteger count = self.model.goods_num.integerValue+1;
                [self executeCmdWithSubscriber:subscriber goodsCount:count];

                return nil;
            }];
        }];
    }
    return _addCmd;
}


- (RACCommand *)subtractionCmd {
    if (!_subtractionCmd) {
        @weakify(self);
        _subtractionCmd = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                NSInteger count = self.model.goods_num.integerValue-1;
                if (count <= 0) {
                    [WXZTipView showCenterWithText:@"商品数量最小为1"];
                    [subscriber sendCompleted];
                    return nil;
                }
                [self executeCmdWithSubscriber:subscriber goodsCount:count];
                return nil;
            }];
        }];
    }
    return _subtractionCmd;
}


- (void)executeCmdWithSubscriber:(id<RACSubscriber>  _Nonnull) subscriber goodsCount:(NSInteger)count{
    @weakify(self);
    [networkingManagerTool requestToServerWithType:POST withSubUrl:shopCartQuantity withParameters:@{@"cart_id":self.model.cart_id,@"quantity":@(count)} withResultBlock:^(BOOL result, id value) {
        @strongify(self);
        if (result) {
            self.model.goods_num = [NSString stringWithFormat:@"%ld",count];
            self.countLabel.text = self.model.goods_num;
            [subscriber sendCompleted];
            [[NSNotificationCenter defaultCenter] postNotificationName:cartValueChangedNotification object:@"selectAction"];
        }else {
            if (value) {
                
            }
            
            [subscriber sendError:nil];
        }
    }];
}

- (UILabelEdgeInsets *)specialLab {
    if (!_specialLab) {
        _specialLab = [[UILabelEdgeInsets alloc] init];
        _specialLab.textColor = AssistColor;
        _specialLab.textAlignment = NSTextAlignmentLeft;
        _specialLab.numberOfLines = 0;
        _specialLab.backgroundColor = BackGroundColor;
        _specialLab.layer.cornerRadius = ScreenScale(5);
        _specialLab.clipsToBounds = YES;
        _specialLab.font = SystemFont(14);
        _specialLab.edgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
    }
    return _specialLab;
}


@end
