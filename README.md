# JhMagnifierView
放大镜(MagnifierView) - 支持方形和圆形样式两种样式,可设置准星显示隐藏

![](https://gitee.com/iotjh/Picture/raw/master/JhMagnifierView_01.png)  <br> 
![](https://gitee.com/iotjh/Picture/raw/master/JhMagnifierView_02.png)  <br> 

## Examples


* demo
```objc
@property (strong, nonatomic) JhMagnifierView *magnifierView;

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

```
