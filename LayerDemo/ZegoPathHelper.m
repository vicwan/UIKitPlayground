//
//  ZegoPathHelper.m
//  LayerDemo
//
//  Created by Vic Wan on 2021/3/1.
//

#import "ZegoPathHelper.h"


@implementation ZegoPathHelper

inline CGPathRef createPathScaledBasingOriginInBoundingBox(CGPathRef path,
                                                         CGPoint origin,
                                                         CGFloat scaleX,
                                                         CGFloat scaleY) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    if (!_pointInRect(origin, bounds)) {
        return path;
    }
    return _createPathScaledBasingOrigin(path, origin, scaleX, scaleY);
}




inline CGPathRef createPathScaledBasingBoundingBoxOriginType(CGPathRef path,
                                                             ZegoPathTransformOrigin originType,
                                                             CGFloat scaleX,
                                                             CGFloat scaleY) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint origin = CGPointZero;
    switch (originType) {
        case ZegoPathTransformOriginTopLeft:      //左上
            origin = CGPointMake(CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            break;
        case ZegoPathTransformOriginTopRight:     //右上
            origin = CGPointMake(CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            break;
        case ZegoPathTransformOriginBottomLeft:   //左下
            origin = CGPointMake(CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            break;
        case ZegoPathTransformOriginBottomRight:  //右下
            origin = CGPointMake(CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            break;
        case ZegoPathTransformOriginTop:          //上
            origin = CGPointMake(CGRectGetMidX(bounds), CGRectGetMinY(bounds));
            break;
        case ZegoPathTransformOriginLeft:         //左
            origin = CGPointMake(CGRectGetMinX(bounds), CGRectGetMidY(bounds));
            break;
        case ZegoPathTransformOriginRight:        //右
            origin = CGPointMake(CGRectGetMaxX(bounds), CGRectGetMidY(bounds));
            break;
        case ZegoPathTransformOriginBottom:       //下
            origin = CGPointMake(CGRectGetMidX(bounds), CGRectGetMaxY(bounds));
            break;
        
        default:
            origin = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
            break;
    }
    return _createPathScaledBasingOrigin(path, origin, scaleX, scaleY);
}

#pragma mark - Private

CGPathRef _createPathScaledBasingOrigin(CGPathRef path,
                                        CGPoint origin,
                                        CGFloat scaleX,
                                        CGFloat scaleY) {
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, origin.x, origin.y);
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    transform = CGAffineTransformTranslate(transform, -origin.x, -origin.y);
    return CGPathCreateCopyByTransformingPath(path, &transform);
}

static bool _pointInRect(CGPoint point, CGRect rect) {
    if (point.x < CGRectGetMinX(rect)) return NO;
    if (point.x > CGRectGetMaxX(rect)) return NO;
    if (point.y < CGRectGetMinY(rect)) return NO;
    if (point.y > CGRectGetMaxY(rect)) return NO;
    return YES;
}

@end
