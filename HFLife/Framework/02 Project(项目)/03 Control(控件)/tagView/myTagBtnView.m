//
//  myTagBtnView.m
//  SQButtonTagView
//
//  Created by mini on 2018/2/23.
//  Copyright © 2018年 yangsq. All rights reserved.
//

#import "myTagBtnView.h"
#import "SQButtonTagView.h"


#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@interface myTagBtnView()
@property (nonatomic, strong) SQButtonTagView *tagView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, assign) BOOL type;
@property (nonatomic, strong) NSArray *titleArr;
@end


@implementation myTagBtnView

- (instancetype)initWithFrame:(CGRect)frame withTitleArr:(NSArray *)titleArr withType:(BOOL)btnType{
    self = [[myTagBtnView alloc] initWithFrame:frame];
    _type = btnType;
    self.titleArr = titleArr;
    [self addTagView];
    [self setTitleArr:self.titleArr withType:_type];
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
    }
    return self;
}

- (void) addTagView{
    _tagView = [[SQButtonTagView alloc]initWithTotalTagsNum:self.titleArr.count
                                                  viewWidth:self.frame.size.width -20
                                                    eachNum:0
                                                    Hmargin:10
                                                    Vmargin:10
                                                  tagHeight:30
                                                tagTextFont:[UIFont systemFontOfSize:14.f]
                                               tagTextColor:[[UIColor redColor] colorWithAlphaComponent:0.5]
                                       selectedTagTextColor:[UIColor whiteColor]
                                    selectedBackgroundColor:[[UIColor redColor] colorWithAlphaComponent:0.5]];
    
    _tagView.selectType = YES;//多选还是单选
//    _tagView.maxSelectNum = 10;//最大选择个数
    [self addSubview:_tagView];
    
    _tagView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:10];
    
    NSLayoutConstraint *left = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1 constant:10];
    
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:-10];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:_tagView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeRight multiplier:1 constant:-10];
    
    [self addConstraints:@[top,left,bottom,right]];
    
    
    
    
    __weak typeof(self)weakSelf = self;
    self.tagView.selectBlock = ^(SQButtonTagView * _Nonnull tagView, NSArray * _Nonnull selectArray) {
        
        
        //block回调
        if (weakSelf.selectResultBlock) {
            weakSelf.selectResultBlock(selectArray);
        }
        
        //代理回调
        if (self.tagBtnDelegate && [self.tagBtnDelegate respondsToSelector:@selector(selectResultDelegate:)]) {
            [weakSelf.tagBtnDelegate selectResultDelegate:selectArray];
        }
    };
    
    
    
}
- (void)setSelectType:(BOOL)selectType{
    _selectType = selectType;
    self.tagView.selectType = selectType;
}

- (void)setTitleArr:(NSArray *)titleArr withType:(BOOL)btnType{
    self.titleArr = titleArr;
   
    if (btnType) {
        _tagView.eachNum = 3;
    }else{
        _tagView.eachNum = 0;
    }
    _tagView.tagTexts = titleArr;
    _tagView.maxSelectNum = titleArr.count;//最大选择个数
    
    //计算高度
    [self viewHeightTextArray:self.titleArr withType:btnType];
    
}

- (CGFloat)viewHeightTextArray:(NSArray *)textArray withType:(BOOL)btnType{
    CGFloat height;
    NSInteger eachNum;
    //0， 不等款布局
    if (btnType) {
        eachNum = 3;
    }else{
        eachNum = 0;
    }
    height = [SQButtonTagView returnViewHeightWithTagTexts:textArray
                                                 viewWidth:self.frame.size.width -20
                                                   eachNum:eachNum
                                                   Hmargin:10
                                                   Vmargin:10
                                                 tagHeight:30
                                               tagTextFont:[UIFont systemFontOfSize:14.f]];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height + 20);
    return height+20;
}


- (void)dealloc{
    [self.tagView removeFromSuperview];
    self.tagView = nil;
}

@end
