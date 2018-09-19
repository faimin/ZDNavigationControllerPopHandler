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


###### 参考

- [利用Runtime自定义控制器POP手势动画](https://github.com/huang303513/iOSKeyPointExploration/tree/master/%E5%88%A9%E7%94%A8Runtime%E8%87%AA%E5%AE%9A%E4%B9%89%E6%8E%A7%E5%88%B6%E5%99%A8POP%E6%89%8B%E5%8A%BF%E5%8A%A8%E7%94%BB)


