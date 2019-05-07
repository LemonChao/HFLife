//
//  myCollectionViewFlowLayout.m
//  myVideoPlayer
//
//  Created by 史小峰 on 13/11/17.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "myCollectionViewFlowLayout.h"

@implementation myCollectionViewFlowLayout

- (instancetype)init
{
    if (self = [super init])
    {
        self.minimumLineSpacing = 10;
        self.minimumInteritemSpacing = 10;
        self.itemSize = CGSizeMake(100, 100);
        
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    
    return self;
}


@end
