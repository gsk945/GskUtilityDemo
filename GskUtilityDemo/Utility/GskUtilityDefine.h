//
//  GskUtilityDefine.h
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#ifndef GskUtilityDefine_h
#define GskUtilityDefine_h

#define kBound [UIScreen mainScreen].bounds//屏幕尺寸
#define kHeight [UIScreen mainScreen].bounds.size.height// 屏幕高度
#define kWidth [UIScreen mainScreen].bounds.size.width// 屏幕宽度
#define kiPhone6W 375.0
#define kiPhone6H 667.0

// 计算比例
#define kScaleX kWidth /kiPhone6W
#define kScaleY kHeight / kiPhone6H
#define LineX(l) l*kScaleX// X坐标
#define LineY(l) l*kScaleY// Y坐标
#define Font(x) [UIFont systemFontOfSize:x]// 字体

#define kStatuHeigh [[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height  //状态栏＋导航栏的高度
#define kstatusBarHeigh [[UIApplication sharedApplication] statusBarFrame].size.height //状态栏
#define kCenteStatuHeigh self.navigationController.navigationBar.frame.size.height/2 + [[UIApplication sharedApplication] statusBarFrame].size.height//导航栏返回按钮y的中心点
#define kTabbarHeight     ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)//tabBar高度
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]//宏定义的RGB

// 随机色
#define RandomColor RGBA(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256),1)
/** 弱引用 */
#define kWeakSelf(type)  __weak typeof(type) weak##type = type;

/**
 *  如果是调试模式，GSKLog就和NSLog一样，如果不是调试模式，GSKLog就什么都不做
 *  __VA_ARGS__ 表示见面...的参数列表
 */
#ifdef DEBUG
# define GSKLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define GSKLog(...);
#endif

#endif /* GskUtilityDefine_h */
