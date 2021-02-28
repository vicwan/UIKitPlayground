//
//  CanvasView.h
//  LayerDemo
//
//  Created by Vic Wan on 2020/12/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CanvasView : UIView

- (void)rotate;
- (void)scale;
- (void)resetScale;


//static CGPathRef createPathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians);

@end

NS_ASSUME_NONNULL_END
