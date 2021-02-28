//
//  CanvasView.m
//  LayerDemo
//
//  Created by Vic Wan on 2020/12/20.
//

#import "CanvasView.h"
#import "ZegoPathHelper.h"

@interface CanvasView ()

@property (nonatomic, strong) CAShapeLayer *pathLayer;
@property (nonatomic, strong) UIBezierPath *path;

@property (nonatomic, assign) CGFloat scaleX;
@property (nonatomic, assign) CGFloat scaleY;
@property (nonatomic, assign) CGFloat angle;

@end

@implementation CanvasView
{
    UIView *_borderView;
    CALayer *_imgLayer;
}

- (instancetype)init {
    self = [super init];
    _scaleX = _scaleY = 1;
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    _scaleX = _scaleY = 1;
    [self setupImageLayer];
    return self;
}

- (void)setupImageLayer {
    _imgLayer = [CALayer layer];
    [_imgLayer setFrame:CGRectMake(10, 10, 30, 30)];
    [self.layer addSublayer:_imgLayer];
    UIImage *img = [UIImage imageNamed:@"arrow.png"];
    _imgLayer.contents = (__bridge id)img.CGImage;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_borderView removeFromSuperview];
    self.path = [[UIBezierPath alloc] init];
    self.path.lineJoinStyle = kCGLineJoinRound;
    CGPoint point = [self pointWithTouches:touches];
    [self.path moveToPoint:point];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGPoint point = [self pointWithTouches:touches];
    CGPoint previousPoint = [self previousPointWithTouches:touches];
    [self.path addQuadCurveToPoint:point controlPoint:previousPoint];
    self.pathLayer.path = self.path.CGPath;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.pathLayer.path = self.path.CGPath;
//    CGRect bounding = CGPathGetBoundingBox(self.pathLayer.path);
////    self.pathLayer.frame = bounding;
//    NSLog(@"frame: %@", NSStringFromCGRect(bounding));
//    NSLog(@"bound: %@", NSStringFromCGRect(self.pathLayer.bounds));
//    NSLog(@"position: %@", NSStringFromCGPoint(self.pathLayer.position));
    
//    CGAffineTransform transform = CGAffineTransformMakeTranslation(-bounding.origin.x, -bounding.origin.y);
//    self.pathLayer.affineTransform = transform;
    CGRect bounding = CGPathGetBoundingBox(self.pathLayer.path);
    [self drawBoundary:bounding transform:self.pathLayer.affineTransform];
}

- (void)drawBoundary:(CGRect)bounds transform:(CGAffineTransform)transform {
    [_borderView removeFromSuperview];
    UIView *borderView = [[UIView alloc] init];
    [borderView setFrame:bounds];
    [self addSubview:borderView];
//    borderView.backgroundColor = UIColor.greenColor;
    borderView.layer.borderWidth = 1;
    borderView.layer.borderColor = UIColor.redColor.CGColor;
    borderView.layer.affineTransform = transform;
    _borderView = borderView;
}

static CGPathRef createPathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    transform = CGAffineTransformRotate(transform, radians);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    return CGPathCreateCopyByTransformingPath(path, &transform);
}

//static CGPathRef createPathScaledAroundBoundingBoxCenter(CGPathRef path, CGFloat scaleX, CGFloat scaleY) {
//    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
//    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformTranslate(transform, center.x, center.y);
//    transform = CGAffineTransformScale(transform, scaleX, scaleY);
//    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
//    return CGPathCreateCopyByTransformingPath(path, &transform);
//}


static CGPathRef createPathScaledAroundBoundingBoxCenter(CGPathRef path, CGFloat scaleX, CGFloat scaleY) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
//    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGPoint center = CGPointMake(CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    return CGPathCreateCopyByTransformingPath(path, &transform);
}

CGAffineTransform scaleTransform(CGPathRef path, CGFloat scaleX, CGFloat scaleY) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
//    CGAffineTransform transform = CGAffineTransformIdentity;

    CGAffineTransform transform = CGAffineTransformMakeTranslation(center.x, center.y);
    transform = CGAffineTransformScale(transform, scaleX, scaleY);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    return transform;
}

CGAffineTransform rotateTransform(CGPathRef path, CGFloat radians) {
    CGRect bounds = CGPathGetBoundingBox(path); // might want to use CGPathGetPathBoundingBox
    CGPoint center = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    transform = CGAffineTransformTranslate(transform, center.x, center.y);
    CGAffineTransform transform = CGAffineTransformMakeTranslation(center.x, center.y);
    transform = CGAffineTransformRotate(transform, radians);
    transform = CGAffineTransformTranslate(transform, -center.x, -center.y);
    return transform;
}


- (void)scale {
    [self scalePath];
//    [self scaleImage];
}

- (void)scalePath {
    self.scaleX = self.scaleX * 1.01;
    self.scaleY = self.scaleY * 1.01;
//    self.pathLayer.path = createPathScaledAroundBoundingBoxCenter(self.pathLayer.path, 1.01, 1.01);
    self.pathLayer.path = createPathScaledBasingBoundingBoxOriginType(self.pathLayer.path, ZegoPathTransformOriginLeft, 1.01, 1.01);
//    self.pathLayer.affineTransform = scaleTransform(self.pathLayer.path, self.scaleX, self.scaleY);
    
    CGRect bounding = CGPathGetBoundingBox(self.pathLayer.path);
//    [self drawBoundary:bounding transform:transform];
    NSLog(@"%@", NSStringFromCGRect(bounding));
}

- (void)scaleImage {
    self.scaleX = self.scaleX * 1.1;
    self.scaleY = self.scaleY * 1.1;
//    self.scaleX = 1.1;
//    self.scaleY = 1.1;
//    _imgLayer.affineTransform = CGAffineTransformConcat(_imgLayer.affineTransform, CGAffineTransformMakeScale(self.scaleX, self.scaleY));
    _imgLayer.affineTransform = CGAffineTransformMakeScale(self.scaleX, self.scaleY);
}

- (void)rotate {
//    [self rotatePath];
    [self rotateImage];
}

- (void)rotateImage {
    self.angle += M_PI / 8;
//    _imgLayer.affineTransform = CGAffineTransformConcat(_imgLayer.affineTransform, CGAffineTransformMakeRotation(self.angle));
    _imgLayer.affineTransform = CGAffineTransformMakeRotation(self.angle);
}

- (void)rotatePath {
    //    CGPathRef path = createPathRotatedAroundBoundingBoxCenter(self.pathLayer.path, M_PI / 8);
    //    self.pathLayer.path = path;
    //    CGPathRelease(path);
    self.angle += M_PI / 8;
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.pathLayer.affineTransform = rotateTransform(self.pathLayer.path, self.angle);
    [CATransaction commit];
}

- (void)resetScale {
    self.pathLayer.affineTransform = CGAffineTransformIdentity;
    _imgLayer.affineTransform = CGAffineTransformIdentity;
    self.scaleX = self.scaleY = 1;
    self.angle = 0;
}

- (CGPoint)pointWithTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    return point;
}

- (CGPoint)previousPointWithTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch precisePreviousLocationInView:self];
    return point;
}

- (CAShapeLayer *)pathLayer {
    if (!_pathLayer) {
        _pathLayer = [[CAShapeLayer alloc] init];
        [self.layer addSublayer:_pathLayer];
        _pathLayer.strokeColor = [UIColor yellowColor].CGColor;
        _pathLayer.fillColor = self.backgroundColor.CGColor;
        _pathLayer.lineWidth = 5;
    }
    return _pathLayer;
}

//static CGPathRef createPathRotatedAroundBoundingBoxCenter(CGPathRef path, CGFloat radians) {
//    CGRect bounds = CGPathGetBoundingBox(path);
//
//}

@end
