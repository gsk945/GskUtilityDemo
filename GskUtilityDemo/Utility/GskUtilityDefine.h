//
//  GskUtilityDefine.h
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#ifndef GskUtilityDefine_h
#define GskUtilityDefine_h

#define gskBound [UIScreen mainScreen].bounds//屏幕尺寸
#define gskHeight [UIScreen mainScreen].bounds.size.height// 屏幕高度
#define gskWidth [UIScreen mainScreen].bounds.size.width// 屏幕宽度
#define gskiPhone6W 375.0
#define gskiPhone6H 667.0

// 计算比例
#define gskScaleX gskWidth /gskiPhone6W
#define gskScaleY gskHeight / gskiPhone6H
#define LineX(l) l*gskScaleX// X坐标
#define LineY(l) l*gskScaleY// Y坐标
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

#endif /* GskUtilityDefine_h */
