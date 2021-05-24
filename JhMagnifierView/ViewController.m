//
//  ViewController.m
//  JhMagnifierView
//
//  Created by Jh on 2018/11/20.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "ViewController.h"
#import "JhMagnifierView.h"

@interface ViewController ()
//放大镜
@property (strong, nonatomic) JhMagnifierView *magnifierView;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
  
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 300)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = [UIImage imageNamed:@"cat"];
    imageView.userInteractionEnabled = YES;
    [self.view addSubview:imageView];

    UIPanGestureRecognizer *singlePan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singlePan:)];
    singlePan.maximumNumberOfTouches = 1;
    [self.view addGestureRecognizer:singlePan];
}

- (void)singlePan:(UIPanGestureRecognizer *)gesture {
    CGPoint point = [gesture locationInView:self.view.window];
    if (gesture.state == UIGestureRecognizerStateBegan) {
        self.magnifierView.targetPoint = point;
    } else if (gesture.state == UIGestureRecognizerStateChanged) {
        self.magnifierView.targetPoint = point;
    } else {
        //用完置nil。
        self.magnifierView = nil;
    }
}


- (JhMagnifierView *)magnifierView {
    if (! _magnifierView) {
        _magnifierView = [[JhMagnifierView alloc]init];
        _magnifierView.magStyle = JhMagnifierStyleCircular; //设为圆形
        _magnifierView.targetWindow = self.view.window;
        _magnifierView.adjustPoint = CGPointMake(0, -15); //放大镜位置调整
        _magnifierView.magnifierWidth = 100; //设置宽度
        _magnifierView.isHiddenAddLabel = YES;
    }
    return _magnifierView;
}


@end
