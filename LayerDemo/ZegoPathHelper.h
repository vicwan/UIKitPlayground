//
//  ZegoPathHelper.h
//  LayerDemo
//
//  Created by Vic Wan on 2021/3/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ZegoPathTransformOrigin) {
    ZegoPathTransformOriginCenter,        // 中心
    ZegoPathTransformOriginTopLeft,       // 左上
    ZegoPathTransformOriginTopRight,      // 右上
    ZegoPathTransformOriginBottomLeft,    // 左下
    ZegoPathTransformOriginBottomRight,   // 右下
    ZegoPathTransformOriginTop,           // 上
    ZegoPathTransformOriginLeft,          // 左
    ZegoPathTransformOriginRight,         // 右
    ZegoPathTransformOriginBottom,        // 下
};

@interface ZegoPathHelper : NSObject

CGPathRef createPathScaledBasingOriginInBoundingBox(CGPathRef path,
                                                    CGPoint origin,
                                                    CGFloat scaleX,
                                                    CGFloat scaleY);

CGPathRef createPathScaledBasingBoundingBoxOriginType(CGPathRef path,
                                                      ZegoPathTransformOrigin originType,
                                                      CGFloat scaleX,
                                                      CGFloat scaleY);

@end

NS_ASSUME_NONNULL_END
