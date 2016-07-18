//
//  ViewController2.m
//  UINavigationControllerStudy
//
//  Created by 符现超 on 15/10/25.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import "ViewController2.h"
#import "ViewController3.h"
#import "Aspects.h"


#define NSLog(format, ...) do {                                             \
fprintf(stderr, "<%s : %d>\n%s\n",                                          \
[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],  \
__LINE__, __func__);                                                        \
(NSLog)((format), ##__VA_ARGS__);                                           \
fprintf(stderr, "-----------------\n");                                     \
} while (0)



@interface ViewController2 () 

@end

@implementation ViewController2

- (void)viewDidLoad
{
	[super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    self.view.backgroundColor = [UIColor redColor];
    self.title = @"2";

	UIButton *push = [[UIButton alloc] initWithFrame:(CGRect) {50, 100, 100, 30}];
	push.backgroundColor = [UIColor purpleColor];
	[push setTitle:@"下一步" forState:UIControlStateNormal];
	[push addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:push];
    
    [self aspect_hookSelector:@selector(push) withOptions:AspectPositionBefore usingBlock:^ (id<AspectInfo>info) {
        NSLog(@"push le");
    } error:nil];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)push
{
	[self.navigationController pushViewController:[ViewController3 new] animated:YES];
//    ViewController3 *vc3 = [ViewController3 new];
//    [self presentViewController:[ViewController3 new] animated:YES completion:^{
//        NSLog(@"\n\n\n**************%@\n\n======%@", [vc3.presentingViewController class], [self.presentedViewController class]);
//    }];
}


- (BOOL)zd_navigationControllerShouldPop:(UINavigationController *)navigationController
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"ViewController")]) {
            [self.navigationController popToViewController:vc animated:YES];
            break;
        }
    }
    return NO;
}

- (BOOL)zd_navigationControllerShouldStarInteractivePopGestureRecognizer:(UINavigationController *)navigatonController
{
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"ViewController1")]) {
            [navigatonController popToViewController:vc animated:YES];
            break;
        }
    }
    return NO;
}

- (NSString *)navigationItemBackBarButtonTitle
{
    return @"你好";
}

/*
 * #pragma mark - Navigation
 *
 *  // In a storyboard-based application, you will often want to do a little preparation before navigation
 *  - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 *   // Get the new view controller using [segue destinationViewController].
 *   // Pass the selected object to the new view controller.
 *  }
 */

@end
