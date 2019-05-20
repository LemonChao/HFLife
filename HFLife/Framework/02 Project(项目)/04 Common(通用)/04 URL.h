

#ifndef HRURLConstant_h
#define HRURLConstant_h

#import <Foundation/Foundation.h>

#pragma mark - ---------- 协议(protocol) ----------
//协议（http/https）（含“//”后缀，不能为空）
#if DEBUG
static NSString *const URL_PROTOCOL = @"http://";
#else
static NSString *const URL_PROTOCOL = @"https://";
#endif


#pragma mark - ---------- 地址(host) ----------
//http://xm_hanfu2.com/api/mobile/index.php?w=index&t=index
//地址(host) （不能为空）http://hzf-takeout    备用@"hzf2-mall.zhongchangjy.com/
#if DEBUG
static NSString *const URL_HOST = @"ceshi-shop.hfgld.net/api/mobile/index.php?";//@"ceshi-ucenter.hfgld.net/";
#else
static NSString *const URL_HOST = @"<#www.xxx.xxx#>";
#endif

#pragma mark - ---------- 端口(port) ----------
//端口（port），（含“:”前缀，如果 URL_PORT 为空，则不含）
#if DEBUG

static NSString *const URL_PORT = @"";//@"api/mobile/index.php?";
#else
static NSString *const URL_PORT = @"<#:xxxx#>";
#endif

#pragma mark - ---------- 路径(path) ----------
//路径通用前缀，（含后缀“/” ，如果 URL_PREFIX 为空， 则不含）
static NSString *const URL_PATH_PREFIX = @"";//后缀
//static NSString *const URL_PATH_PREFIX = @"<#xxx/#>";




//XXXX
static NSString *const PATH_XXXX = @"PATH_XXXX"; // ⚠️：变量名称全部大写，用下划线分割




#pragma mark - ---------- 其他（others） ----------

#pragma mark 图片路径通用前缀
//包括协议、地址、端口号...。含“/”，如果 URL_IMG_PREFIX 为空，则不含。
static NSString *const URL_IMG_PREFIX = @"<#xxx/#>";


#endif /* HRURLConstant_h */
