//
//  UIViewController+ZDBackButtonHandler.m
//  UINavigationControllerStudy
//
//  Created by 符现超 on 15/10/30.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import "UIViewController+ZDBackButtonHandler.h"

@implementation UIViewController (ZDBackButtonHandler)

@end

@implementation UINavigationController (ShouldPopOnBackButton)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item
{
	if ([self.viewControllers count] < [navigationBar.items count]) {
		return YES;
	}

	BOOL shouldPop = YES;
	UIViewController *vc = [self topViewController];

    if ([vc respondsToSelector:@selector(navigationControllerShouldPop:)]) {
        shouldPop = [vc navigationControllerShouldPop:self];
	}

	if (shouldPop) {
		dispatch_async(dispatch_get_main_queue(), ^{
			[self popViewControllerAnimated:YES];
		});
	}
	else {
		// Workaround for iOS7.1. Thanks to @boliva - http://stackoverflow.com/posts/comments/34452906
		for (UIView *subview in [navigationBar subviews]) {
			if (subview.alpha < 1.) {
				[UIView animateWithDuration:.25 animations:^{
					subview.alpha = 1.;
				}];
			}
		}
	}

	return NO;
}

@end
