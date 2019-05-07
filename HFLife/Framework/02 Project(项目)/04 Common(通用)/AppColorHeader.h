//
//  AppColorHeader.h
//  HanPay
//
//  Created by zchao on 2019/2/26.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef AppColorHeader_h
#define AppColorHeader_h

// rgb三原色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/** 背景 - f5f6f7 */
#define BackGroundColor HEX_COLOR(0xf5f6f7)

/** 线条 - eaeaea */
#define LineColor RGBA(234,234,234,1)

/** 重要 - 333333 */
#define ImportantColor RGBA(51,51,51,1)

/** 一级 - 4a4a4a */
#define PrimaryColor RGBA(74,74,74,1)

/** 次要 - 666666 */
#define MinorColor RGBA(102,102,102,1)

/** 辅助 - 999999 */
#define AssistColor RGBA(153,153,153,1)

#endif /* AppColorHeader_h */
