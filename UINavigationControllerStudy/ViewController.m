//
//  ViewController.m
//  UINavigationControllerStudy
//
//  Created by 符现超 on 15/10/25.
//  Copyright © 2015年 Fate.D.Bourne. All rights reserved.
//

#import "ViewController.h"
#import "ViewController1.h"
#import "UINavigationBar+Awesome.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor purpleColor]];
    
    self.view.backgroundColor = [UIColor yellowColor];
    self.title = @"0";
    
    UIButton *back = [[UIButton alloc] initWithFrame:(CGRect){50, 100, 100, 30}];
    back.backgroundColor = [UIColor purpleColor];
    [back setTitle:@"下一步" forState:UIControlStateNormal];
    [back addTarget:self action:@selector(push) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor purpleColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)push
{
    [self.navigationController pushViewController:[ViewController1 new] animated:YES];
}

@end
