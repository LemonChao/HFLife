
//
//  SXF_HF_GetMoneyView.m
//  HFLife
//
//  Created by mac on 2019/5/17.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "SXF_HF_GetMoneyView.h"
#import "SXF_HF_getMoneyTabHeaderView.h"
#import "SXF_HF_getMoneyCellTableViewCell.h"
#import "SXF_HF_saveCodeView.h"
@interface SXF_HF_GetMoneyView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)SXF_HF_getMoneyTabHeaderView *tableHeader;

@property (nonatomic, strong)UITableView *tableView;

//需要保存的view
@property (nonatomic, strong)SXF_HF_saveCodeView *saveCodeView;
@end



@implementation SXF_HF_GetMoneyView
{
    NSArray *_titleArr;
    NSArray *_imageArr;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        [self addChildrenViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildrenViews];
    }
    return self;
}
- (void) addChildrenViews{
    
    
    _titleArr = @[@"收款记录",@"",@"商家入驻"];
    _imageArr = @[@"记录",@"",@"入驻 (1)"];
    self.tableHeader = [[SXF_HF_getMoneyTabHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 432)];
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class])];
    self.tableView.tableFooterView = [UIView new];
    [self addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeader;
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = HEX_COLOR(0xCA1400);
    WEAK(weakSelf);
    self.tableHeader.clickHeaderBtn = ^(NSInteger tag) {
        if (tag == 1) {
            [weakSelf loadImageFinished:weakSelf.saveCodeView];
            return ;
        }
        !weakSelf.tabBtnCallback ? : weakSelf.tabBtnCallback(tag);
    };
    [self.tableHeader setDataForView:@""];
    
    //需要保存的view
    self.saveCodeView = [[SXF_HF_saveCodeView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.saveCodeView setDataForView:@""];
}


- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_getMoneyCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class]) forIndexPath:indexPath];
    if (indexPath.section == 1) {
        cell.cellType = NO;
        cell.userNameLb.text = @"SXF";
        cell.userHeaderImageV.image = MY_IMAHE(@"logo_title");
    }else{
        cell.cellType = YES;
        cell.titleLb.text = _titleArr[indexPath.section];
        cell.titltImageV.image = MY_IMAHE(_imageArr[indexPath.section]);
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.tabBtnCallback ? : self.tabBtnCallback(indexPath.section + 2);
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 1){
        return 1.0f;
    }
    return 10.0f;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}


- (void)layoutSubviews{
    [super layoutSubviews];
}


#pragma mark 保存图片
- (void)loadImageFinished:(UIView *)saveView{
    // 设置绘制图片的大小
    UIGraphicsBeginImageContextWithOptions(saveView.bounds.size, NO, 0.0);
    // 绘制图片
    [saveView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // 保存图片到相册   如果需要获取保存成功的事件第二和第三个参数需要设置响应对象和方法，该方法为固定格式。
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    NSLog(@"image = %@, error = %@, contextInfo = %@", image, error, contextInfo);
    if (error != NULL)
    {
        [WXZTipView showCenterWithText:@"图片保存失败"];
    }
    else  // No errors
    {
        [WXZTipView showCenterWithText:@"图片保存成功"];
    }
}
@end
