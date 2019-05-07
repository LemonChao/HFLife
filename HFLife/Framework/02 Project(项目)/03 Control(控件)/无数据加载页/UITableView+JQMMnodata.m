//
//  UITableView+JQMMnodata.m
//  JiuQu
//
//  Created by jqugo on 2017/4/28.
//  Copyright © 2017年 883. All rights reserved.
//

#import "UITableView+JQMMnodata.h"
#import "JQBlankPageViewController.h"

@implementation UITableView (JQMMnodata)

- (void)tableViewDisplayWitMsg:(NSString *)message withimagetype:(NSInteger)type ifNecessaryForRowCount:(NSUInteger)rowCount{
    if (rowCount == 0) {
        // Display a message when the table is empty
        // 没有数据的时候，UILabel的显示样式
        JQBlankPageViewController *controller=[[JQBlankPageViewController alloc]init];
        controller.titleStr=message;
        controller.index= [NSString stringWithFormat:@"%.2ld",(long)type];
        controller.clearnDicBlock = ^{
            //创建一个消息对象
            NSNotification * notice = [NSNotification notificationWithName:@"cleanParams" object:nil userInfo:nil];
            //发送消息
            [[NSNotificationCenter defaultCenter]postNotification:notice];
        };
//        WEAK(weakSelf);
//        controller.clearnDicBlock = ^{
//            if (weakSelf.clearnParamsBlock) {
//                weakSelf.clearnParamsBlock();
//            }
//        };
//        UILabel *messageLabel = [UILabel new];
//        
//        messageLabel.text = message;
//        messageLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//        messageLabel.textColor = [UIColor lightGrayColor];
//        messageLabel.textAlignment = NSTextAlignmentCenter;
//        [messageLabel sizeToFit];
        
        self.backgroundView = controller.view;
        
        
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    } else {
        self.backgroundView = nil;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
}

@end
