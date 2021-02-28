//
//  ScopeExit.h
//  Animation
//
//  Created by Vic Wan on 2021/2/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScopeExit : NSObject

+ (instancetype)exitBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
