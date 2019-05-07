//
//  NSObject+Extension.h
//  AFNTest
//
//  Created by mac on 2017/3/17.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (Extension)
/**
 *  获取Model类里的属性名字
 */
@property (nonatomic , strong)NSMutableArray  *properties;
/**
 *  根据Model类里的属性创建的一个字典
 */
@property (nonatomic , strong)NSMutableDictionary *propertiesDictionary;
@end
