//
//  AddressTableViewCell.m
//  ChooseLocation
//
//  Created by Sekorm on 16/8/26.
//  Copyright © 2016年 HY. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "AddressItem.h"

@interface AddressTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectFlag;
@end
@implementation AddressTableViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setItem:(AddressItem *)item{
    self.addressLabel.font = [UIFont systemFontOfSize:WidthRatio(28)];
    self.addressLabel.textColor = HEX_COLOR(0x989898);
    _item = item;
    _addressLabel.text = item.name;
    _addressLabel.textColor = item.isSelected ? SUBJECTCOLOR: [UIColor blackColor] ;
    _selectFlag.hidden = !item.isSelected;
}
@end
