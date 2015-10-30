//
//  ViewController3.m
//  UINavigationControllerStudy
//
//  Created by 符现超 on 15/10/30.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import "ViewController3.h"
#import "UINavigationController+ZDPop.h"

@interface ViewController3 () <UINavigationControllerShouldPop, UINavigationBarDelegate>

@end

@implementation ViewController3

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigatonController
{
    UIViewController *viewc = self.navigationController;
    
    if ([viewc isEqual:navigatonController]) {
        NSLog(@"YES");
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:NSClassFromString(@"ViewController1")]) {
            [navigatonController popToViewController:vc animated:YES];
            break;
        }
    }
    
    //MARK:此处返回NO，返回YES的话会报导航子视图可能损坏的错误
    return NO;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
