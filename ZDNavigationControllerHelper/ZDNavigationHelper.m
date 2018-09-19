//
//  ZDNavigationHelper.m
//  ZDNavigationController
//
//  Created by Zero.D.Saber on 2018/9/19.
//  Copyright © 2018年 Zero.D.Saber. All rights reserved.
//

#import "ZDNavigationHelper.h"
#import "ZDPopAnimation.h"

static const CGFloat ZDResponseAreaWidth = 50.0;
static const CGFloat ZDResponseAreaHeight = 64.0;

@interface ZDNavigationHelper () <UIGestureRecognizerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak  ) UINavigationController *navigationController;
@property (nonatomic, weak  ) UIPanGestureRecognizer *popGestureRecognizer;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;

@property (nonatomic, assign) BOOL canResponse;
@property (nonatomic, assign) NSInteger currentOrientation;

@end

@implementation ZDNavigationHelper

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (instancetype)initWithNavgationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        navigationController.delegate = self;
        _navigationController = navigationController;
        [self initialize];
    }
    return self;
}

- (void)initialize {
    [self configuration];
}

- (void)configuration {
    [self replacePopGesture];
}

- (void)replacePopGesture {
    UIGestureRecognizer *originPopGesture = self.navigationController.interactivePopGestureRecognizer;
    originPopGesture.enabled = NO;
    
    UIView *gestureView = originPopGesture.view;
    
    UIPanGestureRecognizer *newPopRecognizer = [[UIPanGestureRecognizer alloc] init];
    newPopRecognizer.delegate = self;
    newPopRecognizer.maximumNumberOfTouches = 1;
    [newPopRecognizer addTarget:self action:@selector(handleControllerPop:)];
    [gestureView addGestureRecognizer:newPopRecognizer];
    
    self.popGestureRecognizer = newPopRecognizer;
}

#pragma mark - UIGestureRecognizerDelegate

- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
    ZDPopGestureOrientation pgo = _currentOrientation;
    // 触摸点位置
    CGFloat dx = [recognizer locationInView:recognizer.view].x;
    CGFloat dy = [recognizer locationInView:recognizer.view].y;
    
    // 横向位移量
    CGFloat dtx = [recognizer translationInView:recognizer.view].x;
    CGFloat dty = [recognizer translationInView:recognizer.view].y;
    
    // 我们需要更新它的进度来控制Pop动画的流程，我们用手指在视图中的位置与视图宽度比例作为它的进度。
    CGFloat progress = 0.f;
    if (pgo == ZDPopGestureOrientationDefault) {
        progress = dtx / recognizer.view.bounds.size.width;
    }
    else {
        progress = dty / recognizer.view.bounds.size.height;
    }
    progress = MIN(1.0, MAX(0.0, progress));
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // 设置手势响应区域
        self.canResponse = YES;
        if ((pgo == ZDPopGestureOrientationDefault && dx > ZDResponseAreaWidth) ||
            (pgo == ZDPopGestureOrientationTopToBottom && dy < ZDResponseAreaHeight)) {
            self.canResponse = NO;
            return;
        }
        
        // 手势开始，新建一个监控对象
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        // 告诉控制器开始执行pop的动画
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        if (!self.canResponse) return;
        // 更新手势的完成进度
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        if (!self.canResponse) return;
        
        CGPoint velocity = [recognizer velocityInView:recognizer.view];
        
        if ((pgo == ZDPopGestureOrientationDefault && velocity.x >= 700 && dtx >= ZDResponseAreaWidth) ||
            (pgo == ZDPopGestureOrientationTopToBottom && velocity.y >=700 && dty >= ZDResponseAreaHeight)) {
            // 快速侧滑，并且侧滑距离超过50，直接pop页面
            // 防止有时虽然是快速侧滑，但是距离很短的误操作
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            // 缓慢侧滑，根据位置选择是否pop页面
            if (progress > 0.5) {
                [self.interactivePopTransition finishInteractiveTransition];
            }
            else {
                [self.interactivePopTransition cancelInteractiveTransition];
            }
        }
        
        self.interactivePopTransition = nil;
        
        self.canResponse = NO;
        
        self.currentOrientation = 0;
    }
}

#pragma mark - UINavigationControllerDelegate

//在viewWillAppear之前执行,第一个执行的回调
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    //return nil时，执行系统默认动画
    if (operation == UINavigationControllerOperationPop) {
        return [[ZDPopAnimation alloc] init];
    }
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[ZDPopAnimation class]]) {
        return self.interactivePopTransition;
    }
    return nil;
}

@end
