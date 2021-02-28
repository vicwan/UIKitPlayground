//
//  ViewController.m
//  LayerDemo
//
//  Created by Vic Wan on 2020/12/20.
//

#import "ViewController.h"
#import "CanvasView.h"

@interface ViewController ()

//@property (nonatomic, strong) UIButton *scaleBtn;
@property (nonatomic, strong) CanvasView *canvas;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupScaleBtn];
    [self setupCanvas];
}

- (void)setupCanvas {
    CanvasView *canvas = [[CanvasView alloc] initWithFrame:CGRectMake(10, 100, 400, 600)];
//    CanvasView *canvas = [[CanvasView alloc] initWithFrame:CGRectMake(100, 200, 200, 200)];
    self.canvas = canvas;
    canvas.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:canvas];
}

- (void)setupScaleBtn {
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
    [self.view addSubview:btn];
    btn.backgroundColor = UIColor.blueColor;
    [btn setTitle:@"放大" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onClickScaleBtn) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *rotateBtn = [[UIButton alloc] initWithFrame:CGRectMake(90, 30, 50, 50)];
    [self.view addSubview:rotateBtn];
    rotateBtn.backgroundColor = UIColor.blueColor;
    [rotateBtn setTitle:@"旋转" forState:UIControlStateNormal];
    [rotateBtn addTarget:self action:@selector(ActionRotate) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *reset = [[UIButton alloc] initWithFrame:CGRectMake(190, 30, 50, 50)];
    [self.view addSubview:reset];
    reset.backgroundColor = UIColor.greenColor;
    [reset setTitle:@"reset" forState:UIControlStateNormal];
    [reset addTarget:self action:@selector(resetScale) forControlEvents:UIControlEventTouchUpInside];
    
    
//    UIButton *mark = [[UIButton alloc] initWithFrame:CGRectMake(180, 30, 50, 50)];
//    [self.view addSubview:mark];
//    mark.backgroundColor = UIColor.redColor;
//    [mark addTarget:self action:@selector(resetScale) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClickScaleBtn {
    [self.canvas scale];
}

- (void)ActionRotate {
    [self.canvas rotate];
}

- (void)resetScale {
    [self.canvas resetScale];
}

@end
