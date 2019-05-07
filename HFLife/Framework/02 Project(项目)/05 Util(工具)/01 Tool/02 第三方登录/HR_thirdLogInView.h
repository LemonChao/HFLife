//
//  HR_thirdLogInView.h
//  HRFramework
//
//  Created by sxf_pro on 2018/3/22.
//

#import <UIKit/UIKit.h>

@interface HR_thirdLogInView : UIView
@property (nonatomic, copy) void (^selecteBtnBlock)(NSInteger index);
@end


@interface selecteBtnView:UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *imageV;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, copy) void (^selecteBtnBlock)(NSInteger index);
@end

