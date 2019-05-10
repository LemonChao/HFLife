//
//  AppColorHeader.h
//  HFLife
//
//  Created by zchao on 2019/2/26.
//  Copyright © 2019 mac. All rights reserved.
//

#ifndef AppColorHeader_h
#define AppColorHeader_h

// rgb三原色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

/** 背景白 - f5f5f5 */
#define BackGroundColor HEX_COLOR(0xf5f5f5)

/** 线条 - f5f5f5 */
#define LineColor RGBA(245,245,245,1)

/** 重要 - 0c0b0b 导航标题，重要提醒*/
#define ImportantColor RGBA(12,11,11,1)

/** 一级 - 4a4a4a */
#define PrimaryColor RGBA(74,74,74,1)

/** 次要 - 666666 */
#define MinorColor RGBA(102,102,102,1)

/** 辅助 - aaaaaa */
#define AssistColor RGBA(170,170,170,1)

#endif /* AppColorHeader_h */
