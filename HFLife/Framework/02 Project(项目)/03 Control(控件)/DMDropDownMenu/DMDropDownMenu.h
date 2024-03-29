//
//  DMDropDownMenu.h
//  DMDropDownMenu
//
//  Created by 王佳斌 on 16/5/19.
//  Copyright © 2016年 Draven_M. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum dropMenuType
{
    buttonType,
    textFieldType,
}MenuType;
@class DMDropDownMenu;

@protocol DMDropDownMenuDelegate <NSObject>

- (void)selectIndex:(NSInteger)index AtDMDropDownMenu:(DMDropDownMenu *)dmDropDownMenu;
- (void) deleteRowAtIndexPath:(NSString *)userStr;
@end


@interface DMDropDownMenu : UIView <UITableViewDataSource,UITableViewDelegate , UITextFieldDelegate , UIScrollViewDelegate>

@property(nonatomic,strong)UILabel      *titleLabel;        //  标题
@property(nonatomic,strong)UILabel      *curText;           //  当前选中内容
@property(nonatomic,strong)UIImageView  *arrowImg;          //  箭头图片
@property(nonatomic,strong)NSString     *arrowImageName;
@property(nonatomic,strong)UIButton     *menuBtn;           //显示的是button
@property(nonatomic,strong)UIButton     *arrowBtn;           //箭头按钮
@property(nonatomic,strong)UITextField  *menuFelid;         //显示一个feild
@property(nonatomic,strong)UITableView  *menuTableView;
@property(nonatomic,strong)NSArray      *listArr;
@property(nonatomic,assign)BOOL         isOpen;
@property(nonatomic,assign)id<DMDropDownMenuDelegate>delegate;
@property (nonatomic ,assign) MenuType menuType;

- (void)p_setUpViewWithType:(MenuType)menuType ;
- (void)setListArray:(NSArray *)arr;
- (void)tapAction;
- (void)setTitle:(NSString *)str;
- (void)setTitleHeight:(CGFloat)height;
- (void)awakeFromNib;
- (id)initWithFrame:(CGRect)frame WithType:(MenuType)type withRowNum:(BOOL)rowNum;


@end
