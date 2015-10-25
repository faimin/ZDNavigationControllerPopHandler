//
//  ViewController2.m
//  UINavigationControllerStudy
//
//  Created by 符现超 on 15/10/25.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import "ViewController2.h"
#import "UINavigationController+ZDPop.h"

@interface ViewController2 ()<UINavigationControllerShouldPop, UINavigationBarDelegate>

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *back = [[UIButton alloc] initWithFrame:(CGRect){50, 100, 100, 30}];
    back.backgroundColor = [UIColor purpleColor];
    [back setTitle:@"返回" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    
}

- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigatonController
{
    UIViewController *viewc = self.navigationController;
    if ([viewc isEqual:navigatonController])
    {
        NSLog(@"YES");
    }
    
    for (UIViewController *vc in self.navigationController.viewControllers)
    {
        if ([vc isKindOfClass:NSClassFromString(@"ViewController")])
        {
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
