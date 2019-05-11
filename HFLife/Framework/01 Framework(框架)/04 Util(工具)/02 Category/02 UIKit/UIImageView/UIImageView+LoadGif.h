//
//  UIImageView+sxfCustomLoadGif.h
//  HFLife
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (LoadGif)





/**
 播放gif
 */
- (void)playGifImageData:(NSData *)imageData repeatCount:(NSInteger)repeatCount;


/**
 停止播放gif
 */
- (void) stopPlayGifImage;
@end

NS_ASSUME_NONNULL_END
