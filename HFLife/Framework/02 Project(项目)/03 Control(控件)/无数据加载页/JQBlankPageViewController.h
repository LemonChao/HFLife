//
//  JQBlankPageViewController.h
//  JiuQu
//
//  Created by kk on 2017/4/27.
//  Copyright © 2017年 883. All rights reserved.
//

#import "JQBlankPageViewController.h"

@interface JQBlankPageViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIImageView *middleImage;



@property (weak, nonatomic) IBOutlet UILabel *blankLabel;


@property (nonatomic,copy) NSString *index;

@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) void(^clearnDicBlock)();

@end
