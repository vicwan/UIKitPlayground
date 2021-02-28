//
//  MyView.m
//  Animation
//
//  Created by Vic Wan on 2021/2/12.
//

#import "MyView.h"

@implementation MyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)drawRect:(CGRect)rect {
//    [self drawBorderWithFrame:rect lineWidth:5 padding:10 color:UIColor.redColor dash:NO];
    [UIColor.redColor setFill];
    UIRectFill(rect);
}

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
////    return;
//    CGContextSetFillColorWithColor(ctx, UIColor.whiteColor.CGColor);
//    CGContextBeginPath(ctx);
//    CGContextMoveToPoint(ctx, 16.72, 7.22);
//    CGContextAddLineToPoint(ctx, 3.29, 20.83);
//    CGContextAddLineToPoint(ctx, 10, 30);
//    CGContextAddLineToPoint(ctx, 20, 60);
//    CGContextFillPath(ctx);
//}

- (void)drawBorderWithFrame:(CGRect)rect lineWidth:(CGFloat)lineWidth padding:(CGFloat)padding color:(UIColor *)color dash:(BOOL)dash {
    [color setStroke]; //设置线条颜色
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(0 + padding, 0 + padding)];
    [path addLineToPoint:CGPointMake(0 + padding, CGRectGetMaxY(rect) - padding)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - padding, CGRectGetMaxY(rect) - padding)];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(rect) - padding, 0 + padding)];
    [path addLineToPoint:CGPointMake(0 + padding, 0 + padding)];
    
    path.lineWidth = lineWidth;
    path.lineCapStyle = kCGLineCapRound;    //线条拐角
    path.lineJoinStyle = kCGLineJoinRound;  //终点处理
    if (dash) {
        CGFloat dashed[] = {1, 1, 1};
        [path setLineDash:dashed count:1 phase:1];
    }
    
    [path stroke];
}


@end
