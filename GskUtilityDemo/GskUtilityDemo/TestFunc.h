//
//  TestFunc.h
//  TempProject
//
//  Created by gsk on 2023/12/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestFunc : NSObject

+ (instancetype)shareManager;

-(void)printTest;

- (void)registListener:(void(^)(NSString *ref))listener;

@end

NS_ASSUME_NONNULL_END
