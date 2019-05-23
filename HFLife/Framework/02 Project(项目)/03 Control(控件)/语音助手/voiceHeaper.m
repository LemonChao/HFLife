//
//  voiceHeaper.m
//  HFLife
//
//  Created by mac on 2019/5/23.
//  Copyright © 2019 luyukeji. All rights reserved.
//

#import "voiceHeaper.h"

@implementation voiceHeaper


+(void) say:(NSString *)voiceStr{
    
    if (![voiceStr isKindOfClass:[NSString class]] || voiceStr.length == 0) {
        return;
    }
    
    
    
//    AVSpeechUttrance          代表你想说什么
//
//    AVSpeechSynthesizer      用来发出声音
    
    
    NSArray *ary = [AVSpeechSynthesisVoice speechVoices]; //获取系统提供的语言种类
    
    AVSpeechSynthesizer *synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:voiceStr];    //设置你想说的话
    
    utterance.rate = AVSpeechUtteranceDefaultSpeechRate / 1.1; //设置语速
    
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]; //设置哪国语言
    
    [synthesizer speakUtterance:utterance];
    
    
    
    /*
     
     语言种类 : Language
     
     ar-SA  沙特阿拉伯（阿拉伯文）
     
     en-ZA, 南非（英文）
     
     nl-BE, 比利时（荷兰文）
     
     en-AU, 澳大利亚（英文）
     
     th-TH, 泰国（泰文）
     
     de-DE, 德国（德文）
     
     en-US, 美国（英文）
     
     pt-BR, 巴西（葡萄牙文）
     
     pl-PL, 波兰（波兰文）
     
     en-IE, 爱尔兰（英文）
     
     el-GR, 希腊（希腊文）
     
     id-ID, 印度尼西亚（印度尼西亚文）
     
     sv-SE, 瑞典（瑞典文）
     
     tr-TR, 土耳其（土耳其文）
     
     pt-PT, 葡萄牙（葡萄牙文）
     
     ja-JP, 日本（日文）
     
     ko-KR, 南朝鲜（朝鲜文）
     
     hu-HU, 匈牙利（匈牙利文）
     
     cs-CZ, 捷克共和国（捷克文）
     
     da-DK, 丹麦（丹麦文）
     
     es-MX, 墨西哥（西班牙文）
     
     fr-CA, 加拿大（法文）
     
     nl-NL, 荷兰（荷兰文）
     
     fi-FI, 芬兰（芬兰文）
     
     es-ES, 西班牙（西班牙文）
     
     it-IT, 意大利（意大利文）
     
     he-IL, 以色列（希伯莱文，阿拉伯文）
     
     no-NO, 挪威（挪威文）
     
     ro-RO, 罗马尼亚（罗马尼亚文）
     
     zh-HK, 香港（中文）
     
     zh-TW, 台湾（中文）
     
     sk-SK, 斯洛伐克（斯洛伐克文）
     
     zh-CN, 中国（中文）
     
     ru-RU, 俄罗斯（俄文）
     
     en-GB, 英国（英文）
     
     fr-FR, 法国（法文）
     
     hi-IN  印度（印度文）
     
     //这个语音说话在ios 8的模拟器上有问题，不能发出声音​,我只在模拟器 ios 7 / 8 上测过。
     */
    
    
}

//播放短音乐
+(void) playVioce:(NSString *)voicePath{
    //这里是指你的音乐名字和文件类型
    NSLog(@"path---%@",voicePath);
    //组装并播放音效
    SystemSoundID soundID;
    NSURL *filePath = [NSURL fileURLWithPath:voicePath isDirectory:NO];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)filePath, &soundID);
    AudioServicesPlaySystemSound(soundID);
}




@end
