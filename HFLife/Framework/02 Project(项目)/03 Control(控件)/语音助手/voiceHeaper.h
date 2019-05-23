//
//  voiceHeaper.h
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface voiceHeaper : NSObject
+(void) say:(NSString *)voiceStr;
+(void) playVioce:(NSString *)voicePath;
@end

NS_ASSUME_NONNULL_END
