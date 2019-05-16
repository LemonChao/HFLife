//
//  Password.h
//  Password
//
//  Created by ZAREMYDREAM on 2017/12/15.
//  Copyright © 2017年 Devil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SXF_HF_Password : UIView
@property (nonatomic, strong)void(^keyBoardCallback)(NSString *contentStr);
- (void)closeKeyborad;
@property (nonatomic, assign)BOOL editingEable;

@end
