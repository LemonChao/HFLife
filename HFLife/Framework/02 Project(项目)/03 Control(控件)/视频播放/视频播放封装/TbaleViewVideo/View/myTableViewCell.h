//
//  myTableViewCell.h
//  myVideoPlayer
//
//  Created by 史小峰 on 13/11/17.
//  Copyright © 2017年 sxf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface myTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myTitleLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArr;
- (void) setImageForCell:(NSIndexPath *)indexPath;
@end
