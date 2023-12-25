//
//  TestFunc.m
//  TempProject
//
//  Created by gsk on 2023/12/25.
//

#import "TestFunc.h"

@implementation TestFunc

static TestFunc *sharedInstance;

+ (instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [TestFunc new];
        NSLog(@"嗯啊😄");
    });
    return sharedInstance;
}

-(void)printTest{
    NSLog(@"哈哈😄");
}

- (void)registListener:(void(^)(NSString *ref))listener{
    if(listener){
        listener(@"对的，这是个 Block");
    }
}
@end
