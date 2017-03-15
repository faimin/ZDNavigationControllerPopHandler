### UIViewController+ZDPop

###### 利用运行时截获控制器返回按钮的返回事件，然后在方法中进行一些自定义操作。

当前控制器只需要实现2个代理方法
```objc
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigatonController;
- (BOOL)navigationControllerShouldStarInteractivePopGestureRecognizer:(UINavigationController *)navigatonController;
```
在.h文件中定义了一个宏 `MergeGestureToBackMethod` ，控制点按钮返回和手势返回是否执行同一个代理方法，默认是`YES`，即不用实现 
```objc
- (BOOL)navigationControllerShouldStarInteractivePopGestureRecognizer:(UINavigationController *)navigatonController;
````
协议。



