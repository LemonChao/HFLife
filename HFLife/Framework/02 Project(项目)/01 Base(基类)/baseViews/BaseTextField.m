//
//  BaseTextField.m
//  GDP
//
//  Created by mac on 2018/8/18.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseTextField.h"

@implementation BaseTextField

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    [UIMenuController sharedMenuController].menuVisible = NO;
    UIPasteboard* pasteboard = [UIPasteboard generalPasteboard];
    if (self.textFieldType == TextFieldPhoneType) {
        if (action == @selector(paste:)) {
            if ([pasteboard.string isValidateMobile]) {
                 return [super canPerformAction:action withSender:sender];;
            }else{
                return NO;
            }
        }else{
             return [super canPerformAction:action withSender:sender];;
        }
    }else if (self.textFieldType == TextFieldPayPassType){
        if (action == @selector(paste:)) {
            return NO;
        }
        if (action == @selector(copy:)){
            return NO;
        }
        if (action == @selector(cut:)) {
            return NO;
        }
    }else if (self.textFieldType == TextFieldPassType){
        if (action == @selector(copy:)){
            return NO;
        }
        if (action == @selector(cut:)) {
            return NO;
        }
       if (action == @selector(paste:)) {
           if ([pasteboard.string checkPassWord]) {
                return [super canPerformAction:action withSender:sender];
           }else{
               return NO;
           }
       }else{
           return [super canPerformAction:action withSender:sender]                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
       }
       
    }else if (self.textFieldType == TextFieldNumberType){
        if (action == @selector(paste:)) {
            if ([self isPureFloat:pasteboard.string]) {
                 return [super canPerformAction:action withSender:sender];
            }else{
                return NO;
            }
        }
        
    }else{
         return [super canPerformAction:action withSender:sender];
    }
   return [super canPerformAction:action withSender:sender];
    
}

-(BOOL)isNumber:(NSString *)str{
    
    NSRegularExpression *tNumRegularExpression = [NSRegularExpression regularExpressionWithPattern:@"[0-9]" options:NSRegularExpressionCaseInsensitive error:nil];
    
    int tLetterMatchCount = [tNumRegularExpression numberOfMatchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0, str.length)];
    
    
    
    if(tLetterMatchCount>=1){
        
        return YES;
        
    }else{
        
        return NO;
        
    }
    
    
}
- (BOOL)isPureFloat:(NSString *)string{
    if ([NSString isNOTNull:string]) {
        return NO;
    }
    NSScanner* scan = [NSScanner scannerWithString:string];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}
@end
