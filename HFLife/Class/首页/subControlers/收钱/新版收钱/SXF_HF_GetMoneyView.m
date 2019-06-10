
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
//#import "SXF_HF_saveCodeView.h"
#import "SXF_HF_saveCodeView2.h"
#import "SXF_HF_payMoneyTabHeader.h"
@interface SXF_HF_GetMoneyView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)UIView *headerView;
@property (nonatomic, strong)SXF_HF_getMoneyTabHeaderView *getMoneyHeader;
@property (nonatomic, strong)SXF_HF_payMoneyTabHeader *payMoneyHeader;

@property (nonatomic, strong)UITableView *tableView;

//需要保存的view
//@property (nonatomic, strong)SXF_HF_saveCodeView *saveCodeView;
@property (nonatomic, strong)SXF_HF_saveCodeView2 *saveCodeView2;
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
    self.getMoneyHeader = [[SXF_HF_getMoneyTabHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 432)];
    self.payMoneyHeader = [[SXF_HF_payMoneyTabHeader alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, ScreenScale(410))];
    
    
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class])];
    self.tableView.tableFooterView = [UIView new];
    [self addSubview:self.tableView];
    
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = HEX_COLOR(0xCA1400);
    WEAK(weakSelf);
    
    self.getMoneyHeader.clickHeaderBtn = ^(NSInteger tag) {
        if (tag == 1) {
//            [weakSelf loadImageFinished:weakSelf.saveCodeView];
            [weakSelf loadImageFinished:weakSelf.saveCodeView2];
            return ;
        }
        !weakSelf.tabBtnCallback ? : weakSelf.tabBtnCallback(tag);
    };
    
    self.payMoneyHeader.barCodeClick = ^(UIImage * _Nonnull image,  NSString *barCodeStr) {
        !weakSelf.clickBarCodeImageV ? : weakSelf.clickBarCodeImageV(image, barCodeStr);
    };
    //需要保存的view
//    self.saveCodeView = [[SXF_HF_saveCodeView alloc] initWithFrame:self.bounds];
//    [self insertSubview:self.saveCodeView atIndex:0];
    
    self.saveCodeView2 = [[SXF_HF_saveCodeView2 alloc] initWithFrame:self.bounds];
    [self insertSubview:self.saveCodeView2 atIndex:0];
}

- (void)setOpenCell:(BOOL)openCell{
    _openCell = openCell;
    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationFade];
}


- (void)setPayUserDic:(NSMutableDictionary *)payUserDic{
    _payUserDic = payUserDic;
    [self.tableView reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

- (void)setPayType:(BOOL)payType{
    _payType = payType;
    if (payType) {
        //收款
        self.tableView.tableHeaderView = self.getMoneyHeader;
    }else{
        //向商家付款
        self.tableView.tableHeaderView = self.payMoneyHeader;
    }
    [self.tableView reloadData];
}
- (void)setDataForView:(id)code type:(BOOL)isCustom{
    [self.getMoneyHeader setDataForView:code];
    [self.payMoneyHeader setDataForView:code];
    if (!isCustom) {
//        [self.saveCodeView setDataForView:code];
        [self.saveCodeView2 setDataForView:code];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.payType) {
        //付款
        return 2;
    }
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SXF_HF_getMoneyCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([SXF_HF_getMoneyCellTableViewCell class]) forIndexPath:indexPath];
    if (!self.payType) {
        //付款
        cell.cellType = YES;
        if (indexPath.section == 0) {
            cell.titleLb.text = @"余额支付";
            cell.titltImageV.image = MY_IMAHE(@"余额");
        }else{
            cell.titleLb.text = @"付款记录";
            cell.titltImageV.image = MY_IMAHE(@"记录");
        }
    }else{
        if (indexPath.section == 1) {
            cell.cellType = NO;
            cell.userNameLb.text = self.payUserDic[@"nickname"];
            [cell.userHeaderImageV sd_setImageWithURL:MY_URL_IMG(self.payUserDic[@"photo"]) placeholderImage:MY_IMAHE(@"user__easyico")];
            if ([self.payUserDic valueForKey:@"pay_money"]) {
                cell.payStatusLb.text = [NSString stringWithFormat:@"￥%@", self.payUserDic[@"pay_money"]];
            }
            cell.hidden = !self.openCell;
            if (cell.hidden) {
                cell.payStatusLb.text = @"支付中";
            }
        }else{
            cell.cellType = YES;
            cell.titleLb.text = _titleArr[indexPath.section];
            cell.titltImageV.image = MY_IMAHE(_imageArr[indexPath.section]);
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    !self.tabBtnCallback ? : self.tabBtnCallback(indexPath.section + 2);
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.payType) {
        if (indexPath.section == 1) {
            if (self.openCell) {
                return 44;
            }else{
                return 0.01;
            }
        }
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.payType) {
        //收钱使用
        if(section == 1){
            return 1.0f;
        }
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
