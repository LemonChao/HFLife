//
//  DMDropDownMenu.m
//  DMDropDownMenu
//
//  Created by 王佳斌 on 16/5/19.
//  Copyright © 2016年 Draven_M. All rights reserved.
//

#import "DMDropDownMenu.h"
#define tableH 180
#define DEGREES_TO_RADIANS(angle) ((angle)/180.0 *M_PI)
#define kBorderColor [UIColor colorWithRed:219/255.0 green:217/255.0 blue:216/255.0 alpha:1]

@interface DMDropDownMenu ()
@property (nonatomic ,assign) BOOL rowNum;
@end
@implementation DMDropDownMenu

- (void)setMenuType:(MenuType)menuType
{
    _menuType = menuType;
}

- (id)initWithFrame:(CGRect)frame WithType:(MenuType)type withRowNum:(BOOL)rowNum
{
    self.rowNum = rowNum;//记录是否使用自己的行数 ， 如果使用默认匹配的行数 那就传yes
    self = [super initWithFrame:frame];https://github.com/baiiu/DropDownMenu
    _menuType = type;
    if (self) {
        [self p_setUpViewWithType:type];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self p_setUpViewWithType:_menuType];
}

- (void)setListArray:(NSArray *)arr
{
    self.listArr = arr;
    _curText.text = self.listArr[0];
}

- (void)p_setUpViewWithType:(MenuType)menuType
{
    
    
    self.arrowImageName = @"sort33 3";
    _isOpen = NO;
    self.menuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _menuBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    _menuFelid = [[UITextField alloc] init];
    _menuFelid.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.arrowBtn = [[UIButton alloc] initWithFrame:CGRectMake(_menuBtn.frame.size.width - 20, (_menuBtn.frame.size.height - 20)*0.5, 20, 20)];
    [self.arrowBtn setImage:[UIImage imageNamed:@"向下箭头"] forState:UIControlStateNormal];
    
    
    [self.arrowBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [_arrowBtn.layer setMasksToBounds:YES];
    _arrowBtn.clipsToBounds = YES;
    _arrowBtn.layer.masksToBounds = YES;
    UIImage *image = [UIImage imageNamed:_arrowImageName];
    self.arrowImg = [[UIImageView alloc] initWithImage:image];
    _arrowImg.center = CGPointMake(self.frame.size.width - 15, self.frame.size.height/2);
    
    
    if (menuType == buttonType)
    {
        [_menuBtn addSubview:_arrowImg];
        _menuBtn.layer.borderColor = kBorderColor.CGColor;
        //设置button的边框
        [_menuBtn.layer setMasksToBounds:YES];
        [_menuBtn.layer setCornerRadius:5.0];
        _menuBtn.layer.borderWidth = 1;
        _menuBtn.clipsToBounds = YES;
        _menuBtn.layer.masksToBounds = YES;
        [_menuBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_menuBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
        self.curText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width - 30, self.frame.size.height)];
        _curText.textColor = [UIColor blackColor];
        _curText.textAlignment = NSTextAlignmentLeft;
        _curText.font = [UIFont systemFontOfSize:12];
        [_menuBtn addSubview:_curText];

        
        [self addSubview:_menuBtn];
        [self addSubview:_arrowBtn];
    }
    else if (menuType == textFieldType)
    {
        self.menuFelid.delegate = self;
        self.menuFelid.rightViewMode = UITextFieldViewModeAlways;
        self.menuFelid.rightView = self.arrowBtn;
        self.menuFelid.font = [UIFont systemFontOfSize:15];
        [self addSubview:self.menuFelid];
    }
    
   
    
    
    
    
    
    
    
//    _menuBtn.backgroundColor = [UIColor yellowColor];
//    _curText.backgroundColor = [UIColor redColor];
//    _menuBtn.backgroundColor = [UIColor blueColor];
//    _menuFelid.backgroundColor = [UIColor greenColor];
    
    
    self.menuTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0) style:UITableViewStylePlain];
    _menuTableView.delegate = self;
    _menuTableView.dataSource = self;
    [_menuTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    _menuTableView.layer.borderWidth = 1;
    _menuTableView.layer.borderColor = kBorderColor.CGColor;
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.layer.cornerRadius = 5;
    
    _menuTableView.showsHorizontalScrollIndicator = YES;
    _menuTableView.showsVerticalScrollIndicator = YES;

    [_menuTableView flashScrollIndicators];
    [self.superview addSubview:_menuTableView];
}

- (void)setTitle:(NSString *)str
{
    _titleLabel.text = str;
}

- (void)setTitleHeight:(CGFloat)height
{
    CGRect frame = CGRectMake(0, self.frame.origin.y - height, self.frame.size.width, height);
    _titleLabel.frame = frame;
}




int i = 0;
- (void)tapAction
{
//    [self closeOtherJRView];
    
    
        if (i % 2 == 0)
        {
//            NSLog(@"%d箭头向上" , i);
            _arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
            //箭头向下，弹出选择框
        }
        else
        {
            _arrowBtn.transform = CGAffineTransformIdentity;
//            NSLog(@"%d箭头向下" , i);
            //箭头向上收起选择框
        }
        i++;

    
    
    if (_isOpen) {
        _isOpen = NO;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = _menuTableView.frame;
            frame.size.height = 0;
            [_menuTableView setFrame:frame];
        } completion:^(BOOL finished) {
            [_menuTableView removeFromSuperview];
//            self.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
            _arrowImg.transform = CGAffineTransformRotate(_arrowImg.transform, DEGREES_TO_RADIANS(180));
        }];
    }else
    {
        _isOpen = YES;
        [UIView animateWithDuration:0.3 animations:^{
            
//                     [self.superview addSubview:_menuTableView];
            [_menuTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            [self.superview addSubview:_menuTableView];
            [self.superview bringSubviewToFront:_menuTableView];
            CGRect frame = _menuTableView.frame;
//            frame.size.height = tableH;
            
            if (self.rowNum == NO)
            {
                if (self.listArr.count < 4)
                {
                    frame.size.height = self.listArr.count * 30;
                }
                else
                {
                    frame.size.height = 120;
                }

            }
            else
            {
                frame.size.height = self.listArr.count * 30;
            }
            
            [_menuTableView setFrame:frame];
            
        } completion:^(BOOL finished) {
           self.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
//            _arrowImg.transform = CGAffineTransformRotate(_arrowImg.transform, DEGREES_TO_RADIANS(180));
        }];
    }
}
- (void)closeOtherJRView
{
    for (UIView * view in self.superview.subviews) {
        if ([view isKindOfClass:[DMDropDownMenu class]] && view!=self) {
            DMDropDownMenu * otherView = (DMDropDownMenu *)view;
            if (otherView.isOpen) {
                otherView.isOpen = NO;
                [UIView animateWithDuration:0.3 animations:^{
                    CGRect frame = otherView.menuTableView.frame;
                    frame.size.height = 0;
                    [otherView.menuTableView setFrame:frame];
                } completion:^(BOOL finished) {
                    [otherView.menuTableView removeFromSuperview];
//                    otherView.arrowImg.transform = CGAffineTransformRotate(otherView.arrowImg.transform, DEGREES_TO_RADIANS(180));
                    otherView.arrowBtn.transform = CGAffineTransformMakeRotation(M_PI);
                }];
            }
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MenuCell"];
        
        cell.backgroundColor = [UIColor clearColor];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.frame.size.width - 20, 30)];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        label.tag = 1000;
        label.numberOfLines = 0;
        [cell addSubview:label];
        
//        UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(10, self.frame.size.height + 5, cell.frame.size.width - 20, 0.5)];
//        line.image = [UIImage imageNamed:@"line"];
        
//        [cell addSubview:line];
    }
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = self.listArr[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
};


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self tapAction];
    if (self.menuType == buttonType)
    {
        _curText.text = self.listArr[indexPath.row];
//        [_menuBtn setTitle:self.listArr[indexPath.row] forState:UIControlStateNormal];
    }
    else
    {
        _menuFelid.text = self.listArr[indexPath.row];
    }
    if ([_delegate respondsToSelector:@selector(selectIndex:AtDMDropDownMenu:)]) {
        [_delegate selectIndex:indexPath.row AtDMDropDownMenu:self];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * string = self.listArr[indexPath.row];
    CGRect bounds = [string boundingRectWithSize:CGSizeMake(self.frame.size.width - 20, 200) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14] } context:NULL];
//    NSLog(@"%f",bounds.size.height);
    return 30;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.menuType == textFieldType)
    {
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleDelete;
}
- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"删除");
        
        NSMutableArray * listArrM = [self.listArr mutableCopy];
        if ([_delegate respondsToSelector:@selector(deleteRowAtIndexPath:)]) {
            [_delegate deleteRowAtIndexPath:listArrM[indexPath.row]];
        }
        [listArrM removeObjectAtIndex:indexPath.row];
        self.listArr  = [NSArray arrayWithArray:listArrM];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationLeft];

        
        
    }
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    //编辑结束 调用 隐藏 并减小tableView的高度
    if (self.listArr.count == 0)
    {
        self.hidden = YES;
        self.menuTableView.hidden = YES;
    }
    else
    {
        self.hidden = NO;
        self.menuTableView.hidden = NO;
    }
    if (self.listArr.count <= 4)
    {
        CGRect frame = self.menuTableView.frame;
        frame.size.height = self.listArr.count * 30;
        self.menuTableView.frame = frame;
    }
    
    
}

- (void) flashScrollIndicators
{
    
}

@end
