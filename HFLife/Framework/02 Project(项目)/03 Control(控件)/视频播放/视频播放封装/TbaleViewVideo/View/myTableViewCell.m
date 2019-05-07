//
//  myTableViewCell.m
//  myVideoPlayer
//
//  Created by 史小峰 on 13/11/17.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import "myTableViewCell.h"

#import "myCollectionViewCell.h"
@interface myTableViewCell()<UICollectionViewDelegate  , UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *myImageCollectionView;

@end


@implementation myTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    

    for (int i = 0 ; i < self.imageArr.count ; i++)
    {
        UIImageView *imageV = self.imageArr[i];
        NSLog(@"tag = %ld" , imageV.tag);
        imageV.image = [UIImage imageNamed:@"image100x100.jpg"];
//        if (imageV.tag > 5)
//        {
//            imageV.image = [UIImage imageNamed:@"image1x1.jpg"];
//        }
    }
    
    [self.myImageCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([myCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([myCollectionViewCell class])];
    self.myImageCollectionView.delegate = self;
    self.myImageCollectionView.dataSource = self;
    
    
}


- (void) setImageForCell:(NSIndexPath *)indexPath
{
    for (int i = 0 ; i < self.imageArr.count ; i++)
    {
        UIImageView *imageV = self.imageArr[i];
        NSLog(@"tag = %ld" , imageV.tag);
        imageV.image = [UIImage imageNamed:@"image100x100.jpg"];
//        if (imageV.tag > 4)
//        {
//            imageV.image = [UIImage imageNamed:@"image1x1.jpg"];
//        }
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSLog(@"%lf------%lf---%lf-----%lf"  , self.frame.origin.x , self.frame.origin.y , self.frame.size.width , self.frame.size.height);
    self.myImageCollectionView.frame = CGRectMake(0, 0, self.frame.size.width, 200);
    
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    myCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([myCollectionViewCell class]) forIndexPath:indexPath];
    
    
    return cell;
}
- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了%ld行" , indexPath.row);
}
@end
