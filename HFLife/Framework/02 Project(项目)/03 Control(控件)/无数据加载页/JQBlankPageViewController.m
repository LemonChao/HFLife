//
//  JQBlankPageViewController.m
//  JiuQu
//
//  Created by kk on 2017/4/27.
//  Copyright © 2017年 883. All rights reserved.
//

#import "JQBlankPageViewController.h"

@interface JQBlankPageViewController ()

@property (weak, nonatomic) IBOutlet UIButton *moreButton;

@end

@implementation JQBlankPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.middleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.index]]];
    [self.middleImage setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",@"无数据"]]];
    
    self.blankLabel.text  = self.titleStr;
    self.moreButton.userInteractionEnabled = YES;
    self.moreButton.enabled = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)goBack
{
    if (self.clearnDicBlock) {
        self.clearnDicBlock();
    }

}


-(void)dealloc
{
    
}


@end
