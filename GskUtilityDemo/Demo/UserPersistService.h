//
//  UserPersistService.h
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UtilityHeader.h"

@interface UserPersistService : NSObject

/**
 缓存数据

 @param obj 缓存数据
 @param key 对应键值
 */
+(void)saveData:(id<NSCoding>)obj withKey:(NSString *)key;

/**
 取出字典型数据

 @param key 对应键值
 @return 取出的数据
 */
+(NSDictionary *)getUserDataWithKey:(NSString *)key;

/**
 缓存数组型数据（其实上面那个缓存方式就可以了，故意区分开）

 @param obj 缓存数据型数据
 @param key 对应键值
 */
+(void)saveArray:(id<NSCoding>)obj withKey:(NSString *)key;

/**
 取出数组型数据

 @param key 对应的键值
 @return 数组型数据
 */
+(NSArray *)getUserDataArrayWithKey:(NSString *)key;

/**
 清空缓存数据

 @param key 对应键值
 */
+(void)clearDatawithKey:(NSString *)key;
@end
