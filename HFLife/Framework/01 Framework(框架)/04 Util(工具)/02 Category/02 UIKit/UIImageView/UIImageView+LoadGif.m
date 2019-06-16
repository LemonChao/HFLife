//
//  UIImageView+sxfCustomLoadGif.m
//  HFLife
//
//  Created by mac on 2019/5/11.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "UIImageView+LoadGif.h"

@implementation UIImageView (LoadGif)



//获取gif图片的总时长和循环次数
- (NSTimeInterval)durationForGifData:(NSData *)data{
    //将GIF图片转换成对应的图片源
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    //获取其中图片源个数，即由多少帧图片组成
    size_t frameCout = CGImageSourceGetCount(gifSource);
    //定义数组存储拆分出来的图片
    NSMutableArray* frames = [[NSMutableArray alloc] init];
    NSTimeInterval totalDuration = 0;
    for (size_t i=0; i<frameCout; i++) {
        //从GIF图片中取出源图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        //将图片源转换成UIimageView能使用的图片源
        UIImage* imageName = [UIImage imageWithCGImage:imageRef];
        //将图片加入数组中
        [frames addObject:imageName];
        NSTimeInterval duration = [self gifImageDeleyTime:gifSource index:i];
        totalDuration += duration;
        CGImageRelease(imageRef);
    }
    
    //获取循环次数
    NSInteger loopCount;//循环次数
    CFDictionaryRef properties = CGImageSourceCopyProperties(gifSource, NULL);
    if (properties) {
        CFDictionaryRef gif = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gif) {
            CFTypeRef loop = CFDictionaryGetValue(gif, kCGImagePropertyGIFLoopCount);
            if (loop) {
                //如果loop == NULL，表示不循环播放，当loopCount  == 0时，表示无限循环；
                CFNumberGetValue(loop, kCFNumberNSIntegerType, &loopCount);
            };
        }
    }
    
    CFRelease(gifSource);
    return totalDuration;
}


//获取GIF图片每帧的时长
- (NSTimeInterval)gifImageDeleyTime:(CGImageSourceRef)imageSource index:(NSInteger)index {
    NSTimeInterval duration = 0;
    CFDictionaryRef imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, index, NULL);
    if (imageProperties) {
        CFDictionaryRef gifProperties;
        BOOL result = CFDictionaryGetValueIfPresent(imageProperties, kCGImagePropertyGIFDictionary, (const void **)&gifProperties);
        if (result) {
            const void *durationValue;
            if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFUnclampedDelayTime, &durationValue)) {
                duration = [(__bridge NSNumber *)durationValue doubleValue];
                if (duration < 0) {
                    if (CFDictionaryGetValueIfPresent(gifProperties, kCGImagePropertyGIFDelayTime, &durationValue)) {
                        duration = [(__bridge NSNumber *)durationValue doubleValue];
                    }
                }
            }
        }
    }
    
    return duration;
}

//获取gif图片的循环次数
-(NSInteger)repeatCountForGifData:(NSData *)data{
    //将GIF图片转换成对应的图片源
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    //获取循环次数
    NSInteger loopCount = 0;//循环次数
    CFDictionaryRef properties = CGImageSourceCopyProperties(gifSource, NULL);
    if (properties) {
        CFDictionaryRef gif = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gif) {
            CFTypeRef loop = CFDictionaryGetValue(gif, kCGImagePropertyGIFLoopCount);
            if (loop) {
                //如果loop == NULL，表示不循环播放，当loopCount  == 0时，表示无限循环；
                CFNumberGetValue(loop, kCFNumberNSIntegerType, &loopCount);
            };
        }
    }
    CFRelease(gifSource);
    
    return loopCount;
};



//解析gif图片
- (NSArray *)getImagesFormGif:(NSString *)gifName{
    //得到GIF图片的url
    NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:gifName withExtension:@""];
    
    //将GIF图片转换成对应的图片源
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) fileUrl, NULL);
    //获取其中图片源个数，即由多少帧图片组成
    size_t frameCount = CGImageSourceGetCount(gifSource);
    //定义数组存储拆分出来的图片
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < frameCount; i++) {
        //从GIF图片中取出源图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        //将图片源转换成UIimageView能使用的图片源
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];
        //将图片加入数组中
        [frames addObject:imageName];
        CGImageRelease(imageRef);
    }
    return frames;
}

- (void)playGifImagePath:(NSString *)imagePath repeatCount:(NSInteger)repeatCount{
    //得到GIF图片的url
    //将GIF图片转换成对应的图片源
//    CGImageSourceRef gifSource = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    //url 转资源
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef) [NSURL fileURLWithPath:imagePath], NULL);
    //获取其中图片源个数，即由多少帧图片组成
    size_t frameCount = CGImageSourceGetCount(gifSource);
    //定义数组存储拆分出来的图片
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < frameCount; i++) {
        //从GIF图片中取出源图片
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        //将图片源转换成UIimageView能使用的图片源
        UIImage *imageName = [UIImage imageWithCGImage:imageRef];
        //将图片加入数组中
        [frames addObject:imageName];
        CGImageRelease(imageRef);
    }
    //    UIImageView *gifImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH*0.5-15, 15, 30, 30)];
    //将图片数组加入UIImageView动画数组中
    self.animationImages = frames;
    //每次动画时长
    //获取总时长
    self.animationDuration = [self durationForGifData:imageData];
    //开启动画，此处没有调用播放次数接口，UIImageView默认播放次数为无限次，故这里不做处理
    if (repeatCount == 0) {
        //不设置 就是无限次
//         self.animationRepeatCount = MAXFLOAT;
    }else{
        self.animationRepeatCount = repeatCount;
    }
    
//    [self performSelector:@selector(startPlayGifImage) withObject:nil afterDelay:0.01 inModes:@[NSRunLoopCommonModes]];
//
//    [self performSelector:@selector(stopPlayGifImage) withObject:nil afterDelay:[self durationForGifData:imageData] * repeatCount inModes:@[NSRunLoopCommonModes]];
    
    
    
    
    
    
    [[NSOperationQueue currentQueue] addOperationWithBlock:^{
        [self performSelectorOnMainThread:@selector(startPlayGifImage) withObject:nil waitUntilDone:0.0];
    }];
    
    [self performSelector:@selector(stopPlayGifImage) withObject:nil afterDelay:[self durationForGifData:imageData] * repeatCount - 0.05 inModes:@[NSRunLoopCommonModes]];
   
    
    //不释放 会内存暴涨 导致creash
    CFRelease(gifSource);
}

- (void) stopPlayGifImage{
    [self stopAnimating];
    self.animationImages = nil;
}

- (void) startPlayGifImage{
    [self startAnimating];
}


@end
