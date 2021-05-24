//
//  JhMagnifierView.h
//  
//
//  Created by Jh on 2018/11/14.
//  Copyright © 2018 Jh. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, JhMagnifierStyle) {
    /** 方形放大镜 */
    JhMagnifierStyleSquare = 0,
    /** 圆形放大镜*/
    JhMagnifierStyleCircular,
};


@interface JhMagnifierView : UIWindow

/** 放大镜的宽度  - 默认90*/
@property (nonatomic, assign) float magnifierWidth;

/** 放大镜形状  -默认圆形 */
@property (nonatomic, assign) JhMagnifierStyle magStyle;

/** 放大镜放大倍数 -默认1.5  必须大于1*/
@property (nonatomic, assign) float magnification;

/** 目标视图 (注意: 传视图的Window 例子: self.view.window) */
@property (nonatomic, strong) UIView *targetWindow;

/**  目标视图展示位置 (放大镜需要展示的位置) */
@property (nonatomic, assign) CGPoint targetPoint;

/** 放大镜位置调整 (调整放大镜在原始位置上的偏移 Defalut: CGPointMake(0, 0)) */
@property (nonatomic, assign) CGPoint adjustPoint;

/** +号 是否隐藏  默认YES */
@property (nonatomic, assign) BOOL isHiddenAddLabel;


@end

NS_ASSUME_NONNULL_END
