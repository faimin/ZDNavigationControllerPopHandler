//
//  UIViewController+ZDBackButtonHandler.h
//  UINavigationControllerStudy
//
//  Created by 符现超 on 15/10/30.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDBackButtonHandler <NSObject>

@optional
// Override this method in UIViewController derived class to handle 'Back' button click
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;

@end

@interface UIViewController (ZDBackButtonHandler)<ZDBackButtonHandler>

@end
