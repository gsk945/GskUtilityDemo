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
+(void)saveData:(id<NSCoding>)obj withKey:(NSString *)key;
+(NSDictionary *)getUserDataWithKey:(NSString *)key;
+(void)saveArray:(id<NSCoding>)obj withKey:(NSString *)key;
+(NSArray *)getUserDataArrayWithKey:(NSString *)key;
@end
