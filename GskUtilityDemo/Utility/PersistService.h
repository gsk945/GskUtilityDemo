//
//  PersistService.h
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersistService : NSObject
/**
 保存数据
 
 @param obj 数据
 @param key 键值名
 @param classKey 类名
 */
+ (void)saveObject:(id<NSCoding>)obj withKey:(NSString *)key AndClassKey:(NSString*)classKey;

/**
 获取数据
 
 @param key 键值名
 @param classKey 类名
 @return 数据
 */
+ (id)getDataWithKey:(NSString *)key AndClassKey:(NSString *)classKey;
@end
