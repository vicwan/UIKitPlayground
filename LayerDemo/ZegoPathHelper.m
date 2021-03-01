//
//  ZegoPathHelper.m
//  LayerDemo
//
//  Created by Vic Wan on 2021/3/1.
//

#import "ZegoPathHelper.h"


@implementation ZegoPathHelper

#pragma mark - Scale
inline CGPathRef createPathScaledBasingOriginInBoundingBox(CGPathRef path, CGPoint origin, CGFloat scaleX, CGFloat scaleY) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    if (!_pointInRect(origin, bounds)) {
        return path;
    }
    return _createPathScaledBasingOrigin(path, origin, scaleX, scaleY);
}

inline CGPathRef createPathScaledBasingBoundingBoxOriginType(CGPathRef path, ZegoPathTransformOrigin originType, CGFloat scaleX, CGFloat scaleY) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint origin = _resolveBoundingBoxOrigin(bounds, originType);
    return _createPathScaledBasingOrigin(path, origin, scaleX, scaleY);
}

#pragma mark - Rotate
inline CGPathRef createPathRotatedBasingOriginInBoundingBox(CGPathRef path, CGPoint origin, CGFloat angle) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    if (!_pointInRect(origin, bounds)) {
        return path;
    }
    return _createPathRotatedBasingOrigin(path, origin, angle);
}

inline CGPathRef createPathRotatedBasingBoundingBoxOriginType(CGPathRef path, ZegoPathTransformOrigin originType, CGFloat angle) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint origin = _resolveBoundingBoxOrigin(bounds, originType);
    return _createPathRotatedBasingOrigin(path, origin, angle);
}

#pragma mark - Private
CGPoint _resolveBoundingBoxOrigin(CGRect bounds, ZegoPathTransformOrigin originType) {
    CGFloat x, y = 0;
    switch (originType) {
        case ZegoPathTransformOriginTopLeft:      //左上
            x = CGRectGetMinX(bounds);
            y = CGRectGetMinY(bounds);
            break;
        case ZegoPathTransformOriginTopRight:     //右上
            x = CGRectGetMaxX(bounds);
            y = CGRectGetMinY(bounds);
            break;
        case ZegoPathTransformOriginBottomLeft:   //左下
            x = CGRectGetMinX(bounds);
            y = CGRectGetMaxY(bounds);
            break;
        case ZegoPathTransformOriginBottomRight:  //右下
            x = CGRectGetMaxX(bounds);
            y = CGRectGetMaxY(bounds);
            break;
        case ZegoPathTransformOriginTop:          //上
            x = CGRectGetMidX(bounds);
            y = CGRectGetMinY(bounds);
            break;
        case ZegoPathTransformOriginLeft:         //左
            x = CGRectGetMinX(bounds);
            y = CGRectGetMidY(bounds);
            break;
        case ZegoPathTransformOriginRight:        //右
            x = CGRectGetMaxX(bounds);
            y = CGRectGetMidY(bounds);
            break;
        case ZegoPathTransformOriginBottom:       //下
            x = CGRectGetMidX(bounds);
            y = CGRectGetMaxY(bounds);
            break;
        
        default:
            x = CGRectGetMidX(bounds);
            y = CGRectGetMidY(bounds);             // 默认 center
            break;
    }
    return CGPointMake(x, y);
}

//CGPathRef _createPathRotatedBasingOrigin(CGPathRef path,
//                                        CGPoint origin,
//                                        CGFloat angle) {
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformTranslate(transform, origin.x, origin.y);
//    transform = CGAffineTransformRotate(transform, angle);
//    transform = CGAffineTransformTranslate(transform, -origin.x, -origin.y);
//    return CGPathCreateCopyByTransformingPath(path, &transform);
//}
//
//CGPathRef _createPathScaledBasingOrigin(CGPathRef path,
//                                        CGPoint origin,
//                                        CGFloat scaleX,
//                                        CGFloat scaleY) {
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformTranslate(transform, origin.x, origin.y);
//    transform = CGAffineTransformScale(transform, scaleX, scaleY);
//    transform = CGAffineTransformTranslate(transform, -origin.x, -origin.y);
//    return CGPathCreateCopyByTransformingPath(path, &transform);
//}
CGPathRef _createPathRotatedBasingOrigin(CGPathRef path,
                                        CGPoint origin,
                                        CGFloat angle) {
    return _createPathBasingTranformOrigin(path, origin, ^CGAffineTransform(CGAffineTransform transform) {
        return CGAffineTransformRotate(transform, angle);;
    });
}

CGPathRef _createPathScaledBasingOrigin(CGPathRef path,
                                        CGPoint origin,
                                        CGFloat scaleX,
                                        CGFloat scaleY) {
    return _createPathBasingTranformOrigin(path, origin, ^CGAffineTransform(CGAffineTransform transform) {
        return CGAffineTransformScale(transform, scaleX, scaleY);
    });
}

CGPathRef _createPathBasingTranformOrigin(CGPathRef path, CGPoint origin, CGAffineTransform(^block)(CGAffineTransform transform)) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, origin.x, origin.y);
    transform = block(transform);
    transform = CGAffineTransformTranslate(transform, -origin.x, -origin.y);
    return CGPathCreateCopyByTransformingPath(path, &transform);
}

static bool _pointInRect(CGPoint point, CGRect rect) {
    return CGRectContainsPoint(rect, point);
}

@end
