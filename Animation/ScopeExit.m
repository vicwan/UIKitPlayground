//
//  ScopeExit.m
//  Animation
//
//  Created by Vic Wan on 2021/2/8.
//

#import "ScopeExit.h"

@interface ScopeExit ()
@property (nonatomic, strong) void(^internalBlock)(void);
@end

@implementation ScopeExit

+ (instancetype)exitBlock:(void (^)(void))block {
    ScopeExit *ret = [[ScopeExit alloc] init];
    ret.internalBlock = block;
    return ret;
}

- (void)dealloc {
    self.internalBlock();
}

@end
