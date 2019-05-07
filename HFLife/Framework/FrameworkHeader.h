//
//  frameworkHeader.h
//  HFLife
//
//  Created by mac on 2019/4/30.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef frameworkHeader_h
#define frameworkHeader_h



#ifdef __OBJC__

#pragma mark - ---------- Framework (框架) ----------
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "01 HRCommon.h"


#pragma mark - ---------- Project (项目) ----------
#import "02 Macro.h"
#import "03 Constant.h"
#import "04 URL.h"
#import "baseHeader.h"



#pragma mark - ---------- Tool (工具) ----------
//#import "HRRequest.h"
#import "networkingManagerTool.h"
#import "HR_dataManagerTool.h"

#endif



#endif /* frameworkHeader_h */
