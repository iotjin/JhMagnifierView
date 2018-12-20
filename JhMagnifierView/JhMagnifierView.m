//
//  JhMagnifierView.m
//  
//
//  Created by Jh on 2018/11/14.
//  Copyright © 2018 Jh. All rights reserved.
//

#import "JhMagnifierView.h"

@interface JhMagnifierView ()

@property (nonatomic, strong) UILabel *addLabel;

@end

@implementation JhMagnifierView


- (void)dealloc {
    
    NSLog(@"JhMagnifierView dealloc");
  
}


-(UILabel *)addLabel{
    if (!_addLabel) {

        CGFloat width = _magnifierWidth;
        CGRect frame = CGRectMake(self.center.x-(width/2), self.center.y-(width/2), width, width);
        UILabel *addLabel = [[UILabel alloc] initWithFrame:frame];
        addLabel.center =self.center;
        addLabel.hidden = YES;
        addLabel.text = @"+";
        addLabel.font = [UIFont systemFontOfSize:15];
        addLabel.textAlignment = NSTextAlignmentCenter;
        addLabel.backgroundColor = [UIColor clearColor];
        addLabel.textColor = [UIColor redColor];
//        NSLog(@"%@",NSStringFromCGRect(self.frame));
        _addLabel =addLabel;
        [self addSubview:_addLabel];
    }
    return _addLabel;
}


-(instancetype)init{
    self = [super init];
    if (self) {
        
        self.magnifierWidth = 90;
        self.magnification = 1.5;
        self.adjustPoint = CGPointMake(0, 0);
        
        self.frame = CGRectMake(0, 0, _magnifierWidth, _magnifierWidth);
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[[UIColor lightGrayColor] colorWithAlphaComponent:0.9] CGColor];
        //为了居于状态条之上
        self.windowLevel = UIWindowLevelStatusBar + 1;
//        self.windowLevel = UIWindowLevelAlert;
        self.layer.delegate = self;
        //保证和屏幕读取像素的比例一致
        self.layer.contentsScale = [[UIScreen mainScreen] scale];
        //添加加号
       [self addLabel];
    }
    return self;
}



- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    //提前位移半个长宽的坑
    CGContextTranslateCTM(ctx, self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    CGContextScaleCTM(ctx, _magnification, _magnification);
    //再次位移后就可以把触摸点移至self.center的位置
    CGContextTranslateCTM(ctx, -1 * self.targetPoint.x, -1 * self.targetPoint.y);
    
    [self.targetWindow.layer renderInContext:ctx];
}

#pragma mark - setter and getter
- (void)setAdjustPoint:(CGPoint)adjustPoint {
    _adjustPoint = adjustPoint;
    [self setTargetPoint:self.targetPoint];
}

- (void)setMagnification:(float)magnification{
     if(magnification<=1) return;
    _magnification = magnification;
}

- (void)setTargetWindow:(UIView *)targetWindow {
    _targetWindow = targetWindow;
    [self makeKeyAndVisible];
    [self setTargetPoint:self.targetPoint];

}
- (void)setMagnifierWidth:(float)magnifierWidth{
    
    _magnifierWidth = magnifierWidth;
    self.frame = CGRectMake(0, 0, _magnifierWidth, _magnifierWidth);
    if(_magStyle == JhMagnifierStyleCircular){
        self.layer.cornerRadius = self.magnifierWidth/2;
        self.layer.masksToBounds = YES;
    }
    CGFloat width = _magnifierWidth;
    CGRect frame = CGRectMake(self.center.x-(width/2), self.center.y-(width/2), width, width);
    self.addLabel.frame = frame;
}

- (void)setMagStyle:(JhMagnifierStyle)magStyle{

    _magStyle = magStyle;
    switch (_magStyle) {
        case JhMagnifierStyleCircular:
        {
            self.layer.cornerRadius = self.magnifierWidth/2;
            self.layer.masksToBounds = YES;
        }
            break;
        case JhMagnifierStyleSquare:
        {
//             self.layer.cornerRadius = self.magnifierWidth;
        }
            break;

        default:
            break;
    }
}

- (void)setAddLabelIsHidden:(BOOL)AddLabelIsHidden{
    _AddLabelIsHidden = AddLabelIsHidden;
    _addLabel.hidden =_AddLabelIsHidden;
}


- (void)setTargetPoint:(CGPoint)targetPoint {
    _targetPoint = targetPoint;
    if (self.targetWindow) {
        CGPoint center = CGPointMake(targetPoint.x, self.center.y);
        if (targetPoint.y > CGRectGetHeight(self.bounds) * 0.5) {
            center.y = targetPoint.y -  CGRectGetHeight(self.bounds) / 2;
        }
        self.center = CGPointMake(center.x + self.adjustPoint.x, center.y + self.adjustPoint.y);
        [self.layer setNeedsDisplay];
    }
}


- (void)setHidden:(BOOL)hidden {
    [super setHidden:hidden];
    self.layer.borderColor = hidden ? [[UIColor clearColor] CGColor] : [[UIColor lightGrayColor] CGColor];
}


@end
