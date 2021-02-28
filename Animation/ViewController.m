//
//  ViewController.m
//  Animation
//
//  Created by Vic Wan on 2021/1/26.
//

#import "ViewController.h"
#import "ScopeExit.h"
#import "MyView.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton *不同;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    CALayer *layer = [CALayer layer];
    UIImage *img = [UIImage imageNamed:@"22"];
//    layer.contents = (__bridge id)img.CGImage;
    layer.frame = CGRectMake(0, 0, 500, 500);
    layer.backgroundColor = UIColor.whiteColor.CGColor;
//    layer.contents = (__bridge id)[self getImage].CGImage;
    layer.contents = (__bridge id)img.CGImage;
    layer.contentsGravity = kCAGravityResizeAspect;
    [self.view.layer addSublayer:layer];
    
    layer.cornerRadius = 16;
//    layer.masksToBounds = YES;
    
//    CALayer *sub = [CALayer layer];
//    sub.backgroundColor = [[UIColor colorWithRed:0 green:0.5 blue:0 alpha:1] CGColor];
//    sub.frame = CGRectMake(0, 0, 200, 200);
//    sub.cornerRadius = 16;
//    sub.masksToBounds = YES;
//    [layer addSublayer:sub];
    __unused ScopeExit *endScope = [ScopeExit exitBlock:^{
        NSLog(@"exit!");
    }];
    {
        NSLog(@",,");
    }
    
    NSLog(@"afterexit");
    
    MyView *my = [[MyView alloc] initWithFrame:CGRectMake(200, 350, 100, 100)];
    my.backgroundColor = UIColor.greenColor;
//    [self.view addSubview:my];
    
    
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    UIView *my1 = [[UIView alloc] initWithFrame:CGRectMake(100, 500, screenSize.width * 5, screenSize.height * 2)];
//    my1.layer.drawsAsynchronously = YES;
    my1.backgroundColor = UIColor.greenColor;
//    [self.view addSubview:my1];
}

//- (UIImage *)getStoredImage {
//    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, 2);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//
//        float myFillColor[] = {1,0,0,1}; //red;
//        CGContextSaveGState(context);
//
//        CGContextSetRGBFillColor(context, 0,1,1,1);
//        CGContextFillRect(context, targetRect);
//        CGContextSetFillColor(context, myFillColor);
//        CGContextFillEllipseInRect(context, targetRect);
//        CGContextFillPath(context);
//        CGContextRestoreGState(context);
//
//        UIImage *uiImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//    CGContextRelease(context);
//    return UIImage;
//}

- (UIImage *)getImage {
    
    NSString *objectname = @"jiuf";
    NSLog(@"wed%@", objectname);
    

    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(100, 100), YES, 2);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSaveGState(ctx);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [UIColor.redColor setStroke];
    [path moveToPoint:CGPointMake(16.72, 7.22)];
    [path addLineToPoint:CGPointMake(3.29, 20.83)];
    [path addLineToPoint:CGPointMake(10, 30)];
    [path addLineToPoint:CGPointMake(20, 60)];
    [path closePath];
    [path stroke];
    CGContextAddPath(ctx, path.CGPath);
    
    
    CGContextSetFillColorWithColor(ctx, UIColor.greenColor.CGColor);
    UIBezierPath *pathF = [UIBezierPath bezierPath];
    [UIColor.yellowColor setStroke];
    [pathF moveToPoint:CGPointMake(16.72, 7.22)];
    [pathF addLineToPoint:CGPointMake(3.29, 20.83)];
    [pathF moveToPoint:CGPointMake(10, 30)];
    [pathF closePath];
    [pathF stroke];
    CGContextAddPath(ctx, pathF.CGPath);
    
    
    CGFloat myFillColor[] = {1,0,0,1}; //red;
    UIColor *color = UIColor.redColor;
//    CGContextSetFillColor(ctx, myFillColor);
    CGContextSetFillColorWithColor(ctx, UIColor.whiteColor.CGColor);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, 16.72, 7.22);
    CGContextAddLineToPoint(ctx, 3.29, 20.83);
    CGContextAddLineToPoint(ctx, 10, 30);
    CGContextAddLineToPoint(ctx, 20, 60);
    CGContextFillPath(ctx);
    
    
//    CGContextRestoreGState(ctx);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    CGContextRelease(ctx);
    return img;
}


@end
