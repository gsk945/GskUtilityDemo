//
//  UserPersistService.m
//  GskUtilityDemo
//
//  Created by gsk on 2018/4/4.
//  Copyright © 2018年 gsk. All rights reserved.
//

#import "UserPersistService.h"
#define UserData @"userData"
@implementation UserPersistService
+(void)saveData:(id<NSCoding>)obj withKey:(NSString *)key{
    [PersistService saveObject:obj withKey:key AndClassKey:UserData];
}
+(NSDictionary *)getUserDataWithKey:(NSString *)key{
    NSDictionary *dic = [PersistService getDataWithKey:key AndClassKey:UserData];
    return dic;
}
+(void)saveArray:(id<NSCoding>)obj withKey:(NSString *)key{
    [PersistService saveObject:obj withKey:key AndClassKey:UserData];
}
+(NSArray *)getUserDataArrayWithKey:(NSString *)key{
    NSArray *array = [PersistService getDataWithKey:key AndClassKey:UserData];
    return array;
}
@end
