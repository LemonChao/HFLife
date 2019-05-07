//
//  UITableView+JQMMnodata.h
//  JiuQu
//
//  Created by jqugo on 2017/4/28.
//  Copyright © 2017年 883. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (JQMMnodata)

- (void)tableViewDisplayWitMsg:(NSString *)message withimagetype:(NSInteger)type ifNecessaryForRowCount:(NSUInteger)rowCount;

//@property(nonatomic,copy)void (^clearnParamsBlock)();

@end
