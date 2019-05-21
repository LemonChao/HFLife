//
//  YYB_HF_ModifyHeadIconVC.m
//  HFLife
//
//  Created by mac on 2019/5/20.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "YYB_HF_ModifyHeadIconVC.h"

@interface YYB_HF_ModifyHeadIconVC ()
@property(nonatomic, strong) UIButton *imageBtn;
@end

@implementation YYB_HF_ModifyHeadIconVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavBar];
    
    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

-(void)setupNavBar{
    WS(weakSelf);
    [super setupNavBar];
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"back"]];
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"icon_more"]];
//    [self.customNavBar wr_setRightButtonWithTitle:@"发布" titleColor:HEX_COLOR(0xC04CEB)];
    //    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"yynavi_bg"];
    [self.customNavBar setOnClickLeftButton:^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    [self.customNavBar setOnClickRightButton:^{
        
        NSLog(@"改头像");
        ZHB_HP_PreventWeChatPopout *preView = [[ZHB_HP_PreventWeChatPopout alloc]initWithTitle:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@[@"从相册上传",@"拍照上传"] actionSheetBlock:^(NSInteger index) {
            
        }];
        [preView show];
    }];
    //    [self.customNavBar wr_setBackgroundAlpha:0];
    [self.customNavBar wr_setBottomLineHidden:YES];
    self.customNavBar.title = @"头像";
    self.customNavBar.backgroundColor = [UIColor whiteColor];
    self.customNavBar.titleLabelColor = [UIColor blackColor];
}

- (void)initView {
    UIButton *imageV = [[UIButton alloc]init];
    imageV.userInteractionEnabled = NO;
    [self.view addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.height.mas_equalTo(SCREEN_WIDTH);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    self.imageBtn = imageV;
    [imageV setImage:image(@"dumpling") forState:UIControlStateNormal];
    
}



@end
